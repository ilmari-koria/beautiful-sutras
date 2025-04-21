module namespace page = 'http://basex.org/examples/web-page';

declare
  %rest:GET
  %rest:path("/bs/{$who}")
  %output:method('html')
  function page:hello($who) {
  <html>
    <p>{fn:replace($who,'-',' ')}!</p>
  </html>
};
