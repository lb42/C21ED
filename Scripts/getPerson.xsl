<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"    
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- extracts person bios and produces content for a listPerson 
    
    run like this:
    for f in *.xml; do saxon $f ../Scripts/getPerson.xsl >>listPerson.xml; done
and then tidied up
    -->
    
    <xsl:output xpath-default-namespace="http://www.tei-c.org/ns/1.0"
        omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <xsl:variable name="inputFile">
            <xsl:value-of select="tokenize(base-uri(.), '/')[last()]"/>
        </xsl:variable>
        <xsl:variable name="root" select="."/>                
    <xsl:for-each select="tokenize(substring-before(substring-after($inputFile, 'C21_'),'.xml'),'_')">
        <xsl:message><xsl:value-of select="position()"/><xsl:text> </xsl:text><xsl:value-of select="."/></xsl:message>
         <xsl:if test="not(. = 'JOS') and not(. = 'MK')">
             <xsl:choose><xsl:when test="$root//front/div/p[list]">
                 <xsl:variable name="which" select="position()-1"/>
                     <person xmlns="http://www.tei-c.org/ns/1.0" xml:id="{.}">  
                        <p><xsl:value-of select="$root//front/div/p[1]/list/item[$which]"/></p></person>
             </xsl:when><xsl:otherwise>
             <person xmlns="http://www.tei-c.org/ns/1.0" xml:id="{.}">  
                 <xsl:copy-of select="$root//front/div/p[1]"/></person></xsl:otherwise></xsl:choose></xsl:if>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>