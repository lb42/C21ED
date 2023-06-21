<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
     xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">

<!-- to use stylo, I needed to make separate text files  for each interviewee, which
        is what this does. 
        problems : naming of files and respondents were not consistent
        use of xsl:result-document meant that respondents present in more than one doc needed special treatment
        
        script is run like this so that the interviewers remarks are catenated into one file
        
          for f in *.xml; 
              do saxon $f ../Scripts/textOnly.xsl ; 
              cat txt/JOS.txt >> txt/allJOS.txt; 
              rm txt/JOS.txt; 
              cat txt/MK.txt >> txt/allMK.txt; 
              done 
-->
    
    <xsl:output xpath-default-namespace="http://www.tei-c.org/ns/1.0"
         method="text"
          omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <xsl:variable name="inputFile">
            <xsl:value-of select="tokenize(base-uri(.), '/')[last()]"/>
        </xsl:variable>
        <xsl:variable name="root" select="."/>                
        <xsl:for-each select="tokenize(substring-before(substring-after($inputFile, 'C21_'),'.xml'),'_')">
          <xsl:message><xsl:value-of select="."/></xsl:message>
            <xsl:variable name="outputFile">
                <xsl:value-of select="concat('txt/',.,'.txt')"/>
            </xsl:variable>
            <xsl:result-document omit-xml-declaration="yes" method="text"  href="{$outputFile}">
            <xsl:variable name="who" select="concat('#',.)"/>
            <xsl:for-each select="$root//sp[@who eq $who]/p">
               <xsl:value-of select="normalize-space(.)"/><xsl:text>
</xsl:text> 
            </xsl:for-each>
            </xsl:result-document>
      </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>