xquery version "3.1";
module namespace web-bs = "http://www.beautifulsutras.xyz/webapp";
import module namespace lib-bs = "http://www.beautifulsutras.xyz";
declare variable $web-bs:title as xs:string := "Beautiful Sūtras";
declare variable $web-bs:stable-uri as xs:anyURI := "http://www.beautifulsutras.xyz";
declare variable $web-bs:author as xs:string := "Ilmari Koria";
declare variable $web-bs:email as xs:anyURI := "mailto:beautifulsutras@posteo.net";

(:~ generate index html body :)
declare
  %rest:path('/index')
  %output:method('html')
  %output:html-version('5')
  %rest:query-param("msg", "{$msg}", "")
    function web-bs:index($msg as xs:string) as element(html) {
   <html>
    <head>
      <title>{$web-bs:title}</title>
      <link rel="stylesheet" type="text/css" href="/static/style.css"/>
    </head>
    <body>
      <h1>{$web-bs:title}</h1>
      <h2>Welcome to {$web-bs:title}.</h2>
      <p>Generate PDF:</p>
        { if ($msg != "") then <p style="color:green;">{$msg}</p> else () }
        <form method="post" action="/index/submit">
          <label for="cbeta-id">Enter ID:</label>
          <input type="text" name="cbeta-id" id="cbeta-id"/>
          <input type="submit" value="Submit"/>
        </form>
    </body>
  </html>
};

declare
  %rest:path("/index/submit")
  %rest:POST
  %rest:form-param("cbeta-id", "{$cbeta-id}", "")
  function web-bs:submit-id($cbeta-id as xs:string) {
    let $normalized := fn:normalize-space($cbeta-id)
    let $message := encode-for-uri("Inserted ID: " || $normalized)
    return web-bs:redirect("/index?msg=" || $message)
};

declare function web-bs:redirect($target as xs:string) {
  <rest:response>
    <http:response status="303">
      <http:header name="Location" value="{$target}"/>
    </http:response>
  </rest:response>
};
