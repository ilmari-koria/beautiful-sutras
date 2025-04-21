xquery version "3.1";
module namespace web-bs = "http://www.beautifulsutras.xyz/webapp";
declare variable $web-bs:title as xs:string := "Beautiful Sūtras";
declare variable $web-bs:stable-uri as xs:anyURI := "http://www.beautifulsutras.xyz";
declare variable $web-bs:author as xs:string := "Ilmari Koria";
declare variable $web-bs:email as xs:anyURI := "mailto:beautifulsutras@posteo.net";

(:~ generate index html body :)
declare
  %rest:GET
  %rest:path('/index')
  %output:method('html')
  %output:html-version('5')
    function web-bs:index() as element(html) {
   <html>
    <head>
      <title>{$web-bs:title}</title>
      <link rel="stylesheet" type="text/css" href="/static/style.css"/>
    </head>
    <body>
      <h1>{$web-bs:title}</h1>
      <p>Welcome to {$web-bs:title}</p>
    </body>
  </html>
};
