<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:cb="http://www.cbeta.org/ns/1.0"
                xmlns:lib-bs="http://www.beautifulsutras.site"
                version="3.0">
  <xsl:output method="text"
              encoding="UTF-8"
              indent="no"
              omit-xml-declaration="yes"/>

  <xsl:include href="../../basex/repo/http-www.beautifulsutras.site/beautifulsutras/beautiful-sutras.xsl"/>
  <xsl:include href="./tex-headers.xsl"/>

  <!-- this stylesheet should not be auto-indented. -->

  <xsl:template match="/">
      <xsl:call-template name="headers">
        <xsl:with-param name="title" select="//tei:title[@xml:lang='zh-Hant']" />
        <xsl:with-param name="date" select="lib-bs:return-chinese-date(fn:substring-before(//tei:date, ' '))" />
        <xsl:with-param name="author"
                        select="//tei:byline[@cb:type='editor'] | //tei:byline[@cb:type='other']" />
      </xsl:call-template>
      \begin{document}
      \maketitle
      \onehalfspacing
      <xsl:apply-templates />
      \end{document}
    </xsl:template>

    <xsl:template match="tei:p | cb:mulu[@type='其他']">
      \Large{<xsl:apply-templates />}
    </xsl:template>

    <xsl:template match="cb:jhead">
      \chapter*{<xsl:apply-templates />}
    </xsl:template>

    <xsl:template match="tei:teiHeader |
                         cb:docNumber |
                         tei:byline |
                         cb:div[@type='add-notes'] |
                         cb:div[@type='apparatus']"/>
</xsl:stylesheet>
