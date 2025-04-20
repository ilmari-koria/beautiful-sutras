xquery version "3.1";
import module namespace lib-bs = "http://www.beautifulsutras.site";
declare option output:indent "yes";
declare variable $lib-bs:xml-p5-stable as xs:string := "https://github.com/ilmari-koria/utils/archive/refs/heads/master.zip";
declare variable $lib-bs:working-dir as xs:string := "." ;


lib-bs:download-zip-file($lib-bs:xml-p5-stable,'file.zip')