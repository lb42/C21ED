<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">

    <!-- improves on the output of the c21 stylesheet,. chiefly by adding <sp> elements -->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="*:body">
        <body xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:for-each-group select="*" group-starting-with="speaker">
                <sp xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="who">
                        <xsl:value-of select="concat('#', current-group()[1])"/>
                    </xsl:attribute>
                    <xsl:for-each select="current-group()">
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>
                </sp>
            </xsl:for-each-group>
        </body>
    </xsl:template>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
