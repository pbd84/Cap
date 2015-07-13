<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:exslt="http://exslt.org/common" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:my="my" exclude-result-prefixes="exslt msxsl my">
    
    <xsl:output method="xml" omit-xml-declaration="no" indent="no" encoding="UTF-8"/>
    
    <xsl:include href="NoLinebreaks.xsl"/>
    <xsl:include href="LesEdi.xsl"/>
    <!--<xsl:include href="link3.xsl"/>-->
    
    <xsl:template match="/">
        <xsl:variable name="step1">
            <xsl:copy>
                <xsl:apply-templates mode="NoLinebreak" select="@* | node()"/>
            </xsl:copy>
        </xsl:variable>
        
        <xsl:variable name="step2">
            <xsl:apply-templates mode="LesEdi" select="exslt:node-set($step1)"/>
        </xsl:variable>

        <xsl:copy-of select="exslt:node-set($step2)/node()"/>
        <!--<xsl:copy-of select="exslt:node-set($step1)/node()"/>-->
    </xsl:template>
    
</xsl:stylesheet>