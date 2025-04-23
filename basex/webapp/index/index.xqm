xquery version "3.1";
module namespace web-bs = "http://www.beautifulsutras.xyz/webapp";
import module namespace lib-bs = "http://www.beautifulsutras.xyz";
declare variable $web-bs:title as xs:string := "Beautiful Sūtras";
declare variable $web-bs:stable-uri as xs:anyURI := "http://www.beautifulsutras.xyz";
declare variable $web-bs:author as xs:string := "Ilmari Koria";
declare variable $web-bs:email as xs:anyURI := "mailto:beautifulsutras@posteo.net";
declare variable $web-bs:publish-path as xs:string := "../webapp/static/publish";


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
      <header>
        <h1>📜 {$web-bs:title} 📜</h1>
      </header>
      <main>
        <p>Generate a sūtra:</p>
        {
         if ($msg != "") then 
           <p>
             PDF ready: <a href="{$msg}" target="_blank">Download</a>
           </p>
         else ()
        }
        <form method="post" action="/index/submit">
          <label for="cbeta-id">Enter a CBETA id</label><br/>
          <input type="text" name="cbeta-id" id="cbeta-id"/><br/>
          <input type="submit" value="Submit"/>
        </form>
        <p>For example:</p>
        <ul>
          <li>X69n1336</li>
          <li>T08n0251</li>
          <li>T01n0002</li>
        </ul>
        <p>All content sourced from <a href="http://tripitaka.cbeta.org">CBETA 漢文大藏經</a>.</p>
        <p>Compiled by <a href="https://ilmarikoria.xyz">Ilmari Koria</a>.</p>
        <ul>
          <li>Contact: <a href="mailto:beautifulsutras@posteo.net">beautifulsutras@posteo.net</a></li>
          <li>Source: <a href="https://github.com/ilmari-koria/beautiful-sutras">Source</a></li>
        </ul>
      </main>
      <footer>
      <hr/>
        <p>Powered by ⚡ <a href="https://basex.org/">BaseX</a></p>
      </footer>
    </body>
  </html>
};

declare
  %rest:path("/index/submit")
  %rest:POST
  %rest:form-param("cbeta-id", "{$cbeta-id}", "")
  function web-bs:submit-id($cbeta-id as xs:string) {
    let $normalized := fn:normalize-space($cbeta-id)
    let $pdf-uri := web-bs:generate-pdf($normalized)
    return web-bs:redirect("/index?msg=" || encode-for-uri($pdf-uri))
};

declare function web-bs:redirect($target as xs:string) {
  <rest:response>
    <http:response status="303">
      <http:header name="Location" value="{$target}"/>
    </http:response>
  </rest:response>
};

declare
  %rest:path("/index/publish/{$cbeta-id}")
  function web-bs:generate-pdf($cbeta-id as xs:string) as xs:string {
  let $tex-file :=
    lib-bs:generate-tex-file-and-return-path(
      $lib-bs:tmp-dir, 
      lib-bs:return-result($cbeta-id),
      $cbeta-id
    )
  let $out-path := "/static/publish/" || $cbeta-id || "-out.pdf"
  (: The '$_' syntax here will disregard output. 
   : I use this because the LuaLaTeX engine seems to always return something, even when run in batch mode.
   : TODO should this be in the actual function itself? 
   :)
  let $_ := lib-bs:generate-pdf-with-lualatex($tex-file, $web-bs:publish-path)
  return
    $out-path
};

(: TODO should this redirection be handled by nginx?? :)
declare
  %rest:path("/")
  %rest:GET
  function web-bs:redirect-root() {
    web:redirect("/index")
};
