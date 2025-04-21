xquery version "3.1";

module namespace lib-bs = "http://www.beautifulsutras.xyz";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace cb = "http://www.cbeta.org/ns/1.0";
declare namespace locale = "java:java.util.Locale";

declare variable $lib-bs:stylesheet as xs:anyURI := file:path-to-uri(fn:resolve-uri("../../../src/xsl/tex-main.xsl"));
declare variable $lib-bs:tmp-dir as xs:anyURI := file:path-to-uri(fn:resolve-uri("../../../tmp/"));


declare %public function lib-bs:return-result(
  $cbeta-id as xs:string)
  as node()* {
  let $xml-id :=
    fn:normalize-space($cbeta-id)
  let $xml-result :=
    collection("xml-p5")//tei:TEI[@xml:id=$xml-id]
  return
    $xml-result
};

declare %public function lib-bs:generate-tex-file-and-return-path(
  $out-dir as xs:string, 
  $input-xml as node()*,
  $cbeta-id as xs:string) 
  as xs:string {
  let $out-path := $lib-bs:tmp-dir || $cbeta-id || '-out.tex'
  let $transform := 
    file:write($out-path,
    xslt:transform-text(
      lib-bs:return-result($cbeta-id),
      $lib-bs:stylesheet,
      { 'method': 'text' }
    ) 
  )
  return (
    $transform, 
    file:path-to-native($out-path)
  )
};

declare %public function lib-bs:generate-pdf-with-lualatex(
  $tex-file-path as xs:string,
  $output-dir as xs:string) 
  {
  let $args := (
    "-interaction=batchmode",
    "-output-directory", $output-dir,
    $tex-file-path
   )
   return (
      proc:system("lualatex", $args)
   )
};


(: TODO this needs to use cURL :) 
declare %public function lib-bs:download-zip-file-and-return-uri(
  $file-uri as xs:string,
  $out-path as xs:string) 
  as xs:anyURI {    
    let $request-response := 
      http:send-request(<http:request method='GET' timeout='360' />, $file-uri)
    let $request-body := tail($request-response)
    return (
      fn:message("Downloading file: " || $file-uri),
      file:write-binary($out-path, $request-body),
      file:path-to-uri($out-path)
    )
};

declare %public function lib-bs:check-lang($lang-code as xs:string) 
  as xs:boolean {
  for $lang in distinct-values(locale:getAvailableLocales() ! locale:getLanguage(.))
    where contains($lang, lower-case($lang-code))
    return 
      if ($lang = "") then
        fn:error(QName("http://www.beautifulsutras.xyz/errors", "lang-error"), "language error.")
      else 
        true()
};

  
