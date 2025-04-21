module namespace bs = 'bs/index';

(: generate index :)
declare
  %rest:GET
  %rest:path('/index')
  %output:method('html')
  %output:html-version('5')
    function bs:index() as element(html) {

    <html>
      This is the index
    </html>

};
