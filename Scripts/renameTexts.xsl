<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
     xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">

<!-- apply this to listPerson.xml
     make shell script to rename files again for stylo to use-->

    
    <xsl:output xpath-default-namespace="http://www.tei-c.org/ns/1.0"
         method="text"
          omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
       <xsl:for-each select="//*:person">
           <xsl:sort select="@xml:id"/>
           <xsl:value-of select="concat('cp txt/corpus/',@xml:id,'.txt stxt/corpus/',@sex,'_', @xml:id,'.txt')"/><xsl:text>
</xsl:text>
       </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>