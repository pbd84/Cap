<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:exslt="http://exslt.org/common" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:my="my" exclude-result-prefixes="exslt msxsl my">
    
    <!--<xsl:include href="allgFunktionen.xsl"/>-->
    
    <xsl:template priority="-9" mode="NoLinebreak" match="@*|node()">
        <xsl:copy>
            <!--<xsl:text>{TEST_1}</xsl:text>-->
            <xsl:apply-templates mode="NoLinebreak" select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template mode="NoLinebreak" match="/">
        <xsl:copy>
            <!--<xsl:text>{TEST_2}</xsl:text>-->
            <xsl:apply-templates mode="NoLinebreak" select="//text()[contains(.,'&#xA;')]"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template mode="NoLinebreak" match="//text()[contains(.,'&#xA;')]">
        <!--<xsl:text>{TEST_3}</xsl:text>-->
        <xsl:call-template name="string-replace_">
            <xsl:with-param name="string" select="."/>
            <xsl:with-param name="replace" select="'&#xA;'"/>
            <xsl:with-param name="with" select="' '"/>
        </xsl:call-template>
    </xsl:template>
    
    
<!--    <xsl:template mode="NoLinebreak" match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates mode="NoLinebreak" select="@*|node()"/>
        </xsl:copy>
    </xsl:template>-->
    
    <!--More specific template for Node766 that provides custom behavior -->
<!--    <xsl:template mode="NoLinebreak" match="//text()[contains(.,'&#xA;')]">  
        <xsl:copy>
<!-\-            <xsl:apply-templates select="@*|node()"/>
            <!-\\-Do something special for Node766, like add a certain string-\\->
            <xsl:text> add some text </xsl:text>-\->
            
            <xsl:call-template name="string-replace_">
                <xsl:with-param name="string" select="."/>
                <xsl:with-param name="replace" select="'&#xA;'"/>
                <xsl:with-param name="with" select="'|LB|'"/>
            </xsl:call-template>
        </xsl:copy>
    </xsl:template>-->
    
    
    
    <xsl:template name="string-replace_">
        <xsl:param name="string" />
        <xsl:param name="replace" />
        <xsl:param name="with" />
        
        <xsl:choose>
            <xsl:when test="contains($string, $replace)">
                <xsl:value-of select="substring-before($string, $replace)" />
                <xsl:value-of select="$with" />
                <xsl:call-template name="string-replace_">
                    <xsl:with-param name="string" select="substring-after($string,$replace)" />
                    <xsl:with-param name="replace" select="$replace" />
                    <xsl:with-param name="with" select="$with" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>