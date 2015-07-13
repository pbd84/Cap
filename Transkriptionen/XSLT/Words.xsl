<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:exslt="http://exslt.org/common" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:my="my" exclude-result-prefixes="exslt msxsl my">
    
    <xsl:template priority="-9" mode="Words" match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates mode="Words" select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template mode="Words" match="/">
        <xsl:copy>
            <!--<xsl:apply-templates mode="Words" select="//text()[contains(.,'&#xA;')]"/>-->
            
            <!--???-->
            <xsl:apply-templates mode="Words" select="tei:ab"/>
        </xsl:copy>
    </xsl:template>
    
<!--    <xsl:template mode="Words" match="tei:ab">
        <xsl:for-each select="node()">
            
        </xsl:for-each>
    </xsl:template>-->
    
    
    <!--
        für jede node() in tei:ab mit ungerader Position/Zahl => <word> bei Leerzeichen etc.
        
        für jede node() in tei:ab mit gerader Position/Zahl => </word> bei Leerzeichen etc.
    -->
    
</xsl:stylesheet>