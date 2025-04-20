xquery version "3.1";
import module namespace lib-bs = "http://www.beautifulsutras.site";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace cb = "http://www.cbeta.org/ns/1.0";
declare option output:indent "yes";
declare variable $publish-path as xs:string external;
declare variable $collection as xs:string external;
declare variable $collection-number as xs:string external;
declare variable $text-identifier as xs:string external;
declare variable $text-scroll as xs:string external;

declare variable $stylesheet as xs:anyURI := file:path-to-uri(fn:resolve-uri("../../src/xsl/tex-main.xsl"));

declare function local:return-result(
  $collection as xs:string,
  $collection-number as xs:string,
  $text-identifier as xs:string,
  $text-scroll as xs:string)
  as node()* {
  let $xml-id :=
    fn:normalize-space(
      fn:upper-case($collection) || $collection-number || "n" || $text-identifier
      )
  let $xml-result :=
    collection("xml-p5")//tei:TEI[@xml:id=$xml-id]
  return
    (: TODO this should *NOT* return a sequence :)
    $xml-result
};

let $transform := 
  file:write('/home/ilmari/my-files/projects/beautiful-sutras/tmp/out.tex',
  xslt:transform-text(
    local:return-result("X","69","1336","1"),
    $stylesheet,
    { 'method': 'text' }
  ) 
)


return $transform