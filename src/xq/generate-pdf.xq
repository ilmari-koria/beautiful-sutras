xquery version "3.1";
import module namespace lib-bs = "http://www.beautifulsutras.site";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace cb = "http://www.cbeta.org/ns/1.0";
declare option output:indent "yes";
declare variable $publish-path as xs:string external;
declare variable $cbeta-id as xs:string external;

declare variable $stylesheet as xs:anyURI := file:path-to-uri(fn:resolve-uri("../../src/xsl/tex-main.xsl"));
declare variable $tmp-dir as xs:anyURI := file:path-to-uri(fn:resolve-uri("../../tmp/"));

(: These functions are not very generic, so I am keeping them local :)

declare function local:return-result(
  $cbeta-id as xs:string)
  as node()* {
  let $xml-id :=
    fn:normalize-space($cbeta-id)
  let $xml-result :=
    collection("xml-p5")//tei:TEI[@xml:id=$xml-id]
  return
    $xml-result
};

declare function local:generate-tex-file-and-return-path(
  $out-dir as xs:string, 
  $input-xml as node()*,
  $cbeta-id as xs:string) 
  as xs:string {
  let $out-path := $tmp-dir || 'out.tex'
  let $transform := 
    file:write($out-path,
    xslt:transform-text(
      local:return-result($cbeta-id),
      $stylesheet,
      { 'method': 'text' }
    ) 
  )
  return (
    $transform, 
    file:path-to-native($out-path)
  )
};

declare function local:generate-pdf-with-lualatex-and-return-path(
  $tex-file-path as xs:string,
  $output-dir as xs:string) 
  as xs:string {
  let $args := (
    "-interaction=batchmode",
    "-output-directory", $output-dir,
    $tex-file-path
   )
   return (
    proc:system("lualatex", $args)
    
  )
};

let $tex-file := 
  local:generate-tex-file-and-return-path(
    $tmp-dir, 
    local:return-result($cbeta-id),
    $cbeta-id
  )

return
  local:generate-pdf-with-lualatex-and-return-path($tex-file, $publish-path)
