<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:lib-bs="http://www.beautifulsutras.xyz"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                exclude-result-prefixes="xs"                
                version="3.0">

  <xsl:function name="lib-bs:return-chinese-date" as="xs:string">
    <xsl:param name="date" as="xs:string"/>
    <xsl:value-of select="fn:format-date(xs:date($date), '[Y0001]年[M01]月[D01]日')"/>
  </xsl:function>

</xsl:stylesheet>
