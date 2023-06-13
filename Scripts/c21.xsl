<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
    
<!-- caution: this doesnt cope well with multiple interviewees -->
 
 <!-- we take the outtput from docxtotei, rewrite its teiHeader, make unwarranted assumptions about
     the content, and generate an invalid tei doc with speaker tags in it but no sp s -->
    
    <xsl:template match="/">

        <xsl:variable name="today">
            <xsl:value-of select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
        </xsl:variable>

        <xsl:variable name="inputFile">
            <xsl:value-of select="tokenize(base-uri(.), '/')[last()]"/>
        </xsl:variable>


        <xsl:variable name="hiString">
            <xsl:value-of select="/TEI/text/body/p[1]"/>
        </xsl:variable>
        <!-- sometimes the first p contains  two hi elements; sometimes only 1 -->
        <xsl:variable name="interviewee">
            <xsl:value-of select="substring-after($hiString, 'Interviewee:')"/>
        </xsl:variable>
        <xsl:variable name="interviewer">
            <xsl:value-of
                select="substring-after(substring-before($hiString, 'Interviewee:'), 'Interviewer:')"
            />
        </xsl:variable>
        <xsl:variable name="interviewDate">
            <xsl:value-of select="/TEI/text/body/p[3]"/>
        </xsl:variable>

        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>C21 Editions: <xsl:value-of select="$interviewee"/></title>
                        <title type="sub">Interview conducted by <xsl:value-of select="$interviewer"
                            /> on <xsl:value-of select="$interviewDate"/></title>
                    </titleStmt>
                    <publicationStmt>
                        <p>Unpublished working draft</p>
                    </publicationStmt>
                    <sourceDesc>
                        <bibl> O'Sullivan, J., M. Pidd, M. Kurzmeier, O. Murphy, and B. Wessels.
                            (2023). <title>Interviews about the future of scholarly digital editions
                                [Data files].</title> Available from <ref
                                target="https://www.dhi.ac.uk/data/c21editions"
                                >https://www.dhi.ac.uk/data/c21editions</ref> (File <xsl:value-of
                                select="$inputFile"/> downloaded: 8th June 2023).</bibl>
                    </sourceDesc>
                </fileDesc>
                <encodingDesc>
                    <p>Retagged in TEI P5 from RTF (via soffice and docxtotei) </p>
                </encodingDesc>
                <revisionDesc>
                    <listChange>
                        <change><date>$today</date>Header added</change>
                    </listChange>
                </revisionDesc>
            </teiHeader>
            <text>
                <front>
                    <div>
                        <head>Interviewee bio</head>
                        <p>
                            <xsl:value-of select="/TEI/text/body/p[2]"/>
                        </p>
                    </div>
                </front>
                <body>
                    <xsl:apply-templates select="/TEI/text/body/p[position() gt 3]"/>
                </body>
            </text>
        </TEI>
    </xsl:template>

    <xsl:template match="p">
        <xsl:variable name="pString">
            <xsl:value-of select="."/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="matches($pString, '^[A-Z]+:')">
                <speaker xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:value-of select="substring-before($pString, ':')"/>
                </speaker>
                <p xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:value-of select="substring-after($pString, ':')"/>
                </p>
            </xsl:when>
            <xsl:otherwise>
                <p xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:value-of select="$pString"/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
