<!--<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:exslt="http://exslt.org/common" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:my="my" exclude-result-prefixes="exslt msxsl my">
    
    <xsl:template priority="-9" mode="Words" match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates mode="Words" select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template mode="Words" match="/">
        <xsl:copy>
            <!-\-<xsl:apply-templates mode="Words" select="//text()[contains(.,'&#xA;')]"/>-\->
            
            <!-\-???-\->
            <xsl:apply-templates mode="Words" select="tei:ab"/>
        </xsl:copy>
    </xsl:template>
    
<!-\-    <xsl:template mode="Words" match="tei:ab">
        <xsl:for-each select="node()">
            
        </xsl:for-each>
    </xsl:template>-\->
    
    
    <!-\-
        für jede node() in tei:ab mit ungerader Position/Zahl => <word> bei Leerzeichen etc.
        
        für jede node() in tei:ab mit gerader Position/Zahl => </word> bei Leerzeichen etc.
    -\->
    
</xsl:stylesheet>-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:exslt="http://exslt.org/common" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:my="my" exclude-result-prefixes="exslt msxsl my tei xs xhtml">
    <xsl:param name="pSeparators">&#xA;&#x9;&#x20;,.;:?!()'"</xsl:param>
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:ab//text()" name="tokenize">
        <xsl:param name="pString" select="."/>
        <xsl:param name="pMask"
            select="translate(.,translate(.,$pSeparators,''),'')"/>
        <xsl:param name="pCount" select="1"/>
        <xsl:choose>
            <xsl:when test="not($pString)"/>
            <xsl:when test="$pMask">
                <xsl:variable name="vSeparator"
                    select="substring($pMask,1,1)"/>
                <xsl:variable name="vString"
                    select="substring-before($pString,$vSeparator)"/>
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="pString" select="$vString"/>
                    <xsl:with-param name="pMask"/>
                    <xsl:with-param name="pCount" select="$pCount"/>
                </xsl:call-template>
                <xsl:value-of select="$vSeparator"/>
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="pString"
                        select="substring-after($pString,$vSeparator)"/>
                    <xsl:with-param name="pMask"
                        select="substring($pMask,2)"/>
                    <xsl:with-param name="pCount"
                        select="$pCount + boolean($vString)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
<!--                <word class="word-{$pCount}">
                    <xsl:value-of select="$pString"/>
                </word>-->
<!--                <w class="{count(ancestor::tei:ab/preceding-sibling::node())+1}-{count(preceding-sibling::node())+1}-word-{$pCount}">
                    <xsl:value-of select="$pString"/>
                </w>-->
<!--                <w class="{count(ancestor::tei:ab/preceding-sibling::node())+1}-{local-name(parent::*)}{count(parent::*/preceding-sibling::node())+1}-{count(preceding-sibling::node())+1}-{$pCount}">
                    <xsl:value-of select="$pString"/>
                </w>-->
                
                <xsl:choose>
                    <xsl:when test="parent::tei:ab">
                        <w class="{count(ancestor::tei:ab/preceding-sibling::node())+1}-{count(preceding-sibling::node())+1}-{$pCount}" id="{generate-id()}-{$pCount}">
                            <xsl:value-of select="$pString"/>
                        </w>
                    </xsl:when>
                    <xsl:otherwise>
<!--                        <w class="{count(ancestor::tei:ab/preceding-sibling::node())+1}-{count(parent::*/preceding-sibling::node())+1}-{count(preceding-sibling::node())+1}-{$pCount}">
                            <xsl:value-of select="$pString"/>
                        </w>-->
                        
<!--                        <xsl:variable name="vParentsTilAncestor">
                            <xsl:call-template name="tParentsTilAncestor">
                                <xsl:with-param name="pAncestorName" select="'ab'"/>
                                <xsl:with-param name="pCurrent" select="."/>
                            </xsl:call-template>
                        </xsl:variable>-->
                        
                        <w class="{count(ancestor::tei:ab/preceding-sibling::node())+1}-{generate-id(parent::*)}-{count(parent::*/preceding-sibling::node())+1}-{count(preceding-sibling::node())+1}-{$pCount}" id="{generate-id()}-{$pCount}">
                            <xsl:value-of select="$pString"/>
                        </w>
<!--                        <w class="{count(ancestor::tei:ab/preceding-sibling::node())+1}-{$vParentsTilAncestor}-{generate-id(parent::*)}-{count(parent::*/preceding-sibling::node())+1}-{count(preceding-sibling::node())+1}-{$pCount}">
                            <xsl:value-of select="$pString"/>
                        </w>-->
                    </xsl:otherwise>
                </xsl:choose>
                
<!--                <w class="{count(ancestor::tei:ab/preceding-sibling::node())+1}-{local-name(parent::*)}{count(parent::*/preceding-sibling::node())+1}-{count(preceding-sibling::node())+1}-{$pCount}">
                    <xsl:value-of select="$pString"/>
                </w>-->
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
<!--    <xsl:template name="tParentsTilAncestor">
        <xsl:param name="pAncestorName"/>
        <!-\-<xsl:param name="pParents"/>-\->
        <xsl:param name="pCurrent"/>
        
        <xsl:choose>
            <xsl:when test="local-name($pCurrent/parent::*)=$pAncestorName">
                <!-\-<xsl:text>TST</xsl:text>-\->
            </xsl:when>
            <xsl:otherwise>
<!-\-                <xsl:value-of select="local-name($pThis)"/>
                <xsl:text>|</xsl:text>
                <xsl:call-template name="tParentsTilAncestor">
                    <xsl:with-param name="pAncestorName" select="$pAncestorName"/>
                    <xsl:with-param name="pZ" select="$pThis/parent::*"/>
                </xsl:call-template>-\->
                
                <xsl:text>{</xsl:text>
                
                <!-\-<xsl:value-of select="$pAncestorName"/>-\->
                <xsl:value-of select="$pCurrent/parent::*"/>
                
                <xsl:text>}</xsl:text>
                
                <xsl:call-template name="tParentsTilAncestor">
                    <xsl:with-param name="pAncestorName" select="$pAncestorName"/>
                    <xsl:with-param name="pCurrent" select="$pCurrent/parent::*"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>-->
    
</xsl:stylesheet>


<!-- zunächst jedes einzelne Wortteil taggen, im nächsten Schritt Wortteile ohne Leerzeichen zusammenlegen?! (nachfolgender Transformationsschritt!) -->