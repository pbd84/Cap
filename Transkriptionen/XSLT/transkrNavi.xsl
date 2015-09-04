<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:exslt="http://exslt.org/common" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:my="my" version="1.0" exclude-result-prefixes="exslt msxsl">
    
    
    <xsl:template match="/">
        <ol>
            <xsl:apply-templates select="//tei:ab" />            
        </ol>
    </xsl:template>
    
    <xsl:template match="tei:ab">
        
        <xsl:variable name="vVorschau">
<!--            <xsl:choose>
                <xsl:when test="string-length(node()[1]) &lt; 25">
                    <xsl:value-of select="substring(concat(node()[1],node()[2]),1,25)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring(.,1,25)"/>
                </xsl:otherwise>
            </xsl:choose>-->
            
            <xsl:value-of select="substring(.,1,25)"/>
        </xsl:variable>
        
        <li>
            <xsl:value-of select="@xml:id"/>
            <xsl:text>: </xsl:text>
            <xsl:value-of select="$vVorschau"/>
            <xsl:text>...</xsl:text>
        </li>
    </xsl:template>
    
</xsl:stylesheet>