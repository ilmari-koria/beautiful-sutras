xquery version "3.1";
module namespace lib-bs = "http://www.beautifulsutras.site";

declare %public function lib-bs:download-zip-file(
  $file-uri as xs:string,
  $out-path as xs:string) 
  as empty-sequence() {    
    let $request-response := 
      http:send-request(<http:request method='GET'/>, $file-uri)
    let $request-body := tail($request-response)
    return
      file:write-binary($out-path, $request-body)
};
  