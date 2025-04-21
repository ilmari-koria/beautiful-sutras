xquery version "3.1";
import module namespace lib-bs = "http://www.beautifulsutras.xyz";
declare option output:indent "yes";
declare variable $lib-bs:xml-p5-stable as xs:string := "https://github.com/ilmari-koria/xml-p5/archive/refs/heads/master.zip";
declare variable $lib-bs:tmp-dir as xs:string := "../../tmp/" ;

(: TODO ftindex tokenizer for zh :)
db:create(
  'xml-p5', 
  lib-bs:download-zip-file-and-return-uri(
    $lib-bs:xml-p5-stable, 
    file:resolve-path($lib-bs:tmp-dir) || 'xml-p5.zip'
  )
)
