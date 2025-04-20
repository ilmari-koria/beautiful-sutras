xquery version "3.1";
module namespace lib-bs = "http://www.beautifulsutras.site";
declare namespace locale = "java:java.util.Locale";

(: TODO should this use fetch:binary? :)
declare %public function lib-bs:download-zip-file-and-return-uri(
  $file-uri as xs:string,
  $out-path as xs:string) 
  as xs:anyURI {    
    let $request-response := 
      http:send-request(<http:request method='GET'/>, $file-uri)
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
 x       fn:error(QName("http://www.beautifulsutras.site/errors", "lang-error"), "language error.")
      else 
        true()
};