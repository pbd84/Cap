<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs"
	version="1.0">
	
	
	<xsl:template name="string-replace">
		<xsl:param name="string" />
		<xsl:param name="replace" />
		<xsl:param name="with" />
		
		<xsl:choose>
			<xsl:when test="contains($string, $replace)">
				<xsl:value-of select="substring-before($string, $replace)" />
				<xsl:value-of select="$with" />
				<xsl:call-template name="string-replace">
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
	
	
	<xsl:template name="indexOf">
		<!-- Zahl -->
		<xsl:param name="pSeq"/>
		<xsl:param name="pNode"/>
		
		<xsl:for-each select="$pSeq">
			<xsl:if test="generate-id(current())=generate-id($pNode)">
				<xsl:number value="position()" format="1"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="indexOf_a">
		<!-- Buchstabe -->
		<xsl:param name="pSeq"/>
		<xsl:param name="pNode"/>
		
		<xsl:for-each select="$pSeq">
			<xsl:if test="generate-id(current())=generate-id($pNode)">
				<xsl:number value="position()" format="a"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	
	<xsl:template name="string-join">
		<xsl:param name="pSequence" select="''"/>
		<xsl:param name="pSeparator" select="','"/>
		
		<xsl:for-each select="$pSequence">
			<xsl:choose>
				<xsl:when test="position()=1">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat($pSeparator,.)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="tDeepCopy">
		<xsl:param name="pNode"/>
		
		<xsl:copy>
			<xsl:for-each select="@*">
				<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
			</xsl:for-each>
			<xsl:for-each select="./*">
				<!--<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>-->
				<xsl:call-template name="tDeepCopy">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template name="tBeginntMitVokal">
		<xsl:param name="pText"/>
		<xsl:variable name="vTextLC">
			<xsl:call-template name="tLowerCase">
				<xsl:with-param name="pText" select="$pText"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:choose>
			<!--<xsl:when test="substring($pText,1,1)='a' or substring($pText,1,1)='e' or substring($pText,1,1)='i' or substring($pText,1,1)='o' or substring($pText,1,1)='u' or substring($pText,1,1)='A' or substring($pText,1,1)='E' or substring($pText,1,1)='I' or substring($pText,1,1)='O' or substring($pText,1,1)='U'">-->
			<xsl:when test="substring($vTextLC,1,1)='a' or substring($vTextLC,1,1)='e' or substring($vTextLC,1,1)='i' or substring($vTextLC,1,1)='o' or substring($vTextLC,1,1)='u' ">
				<xsl:value-of select="true()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="false()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="tUpperCase">
		<xsl:param name="pText"/>
		
		<xsl:variable name="lowercase" select="abcdefghijklmnopqrstuvwxyzäöü"/>
		<xsl:variable name="uppercase" select="ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ"/>
		
		<xsl:variable name="vUpperCase" select="translate($pText,$lowercase,$uppercase)"/>
	</xsl:template>
	<xsl:template name="tLowerCase">
		<xsl:param name="pText"/>
		
		<xsl:variable name="lowercase" select="abcdefghijklmnopqrstuvwxyzäöü"/>
		<xsl:variable name="uppercase" select="ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ"/>
		
		<xsl:variable name="vLowerCase" select="translate($pText,$uppercase,$lowercase)"/>
	</xsl:template>
	
	<xsl:template name="tLastSubstringAfter">
		<!-- sucht hinter erstem Fund des Zeichens noch weiter in Zeichenkette und liefert den zuletzt gefundenen substring-after() -->
		<xsl:param name="pString"/>
		<xsl:param name="pCharacter"/>
		
		<xsl:variable name="vSubstringAfter" select="substring-after($pString,$pCharacter)"/>
		
		<xsl:choose>
			<xsl:when test="string-length($vSubstringAfter)>0">
				<!-- Zeichen/Zeichenkette in String gefunden -->
				<xsl:variable name="vLastSubstringAfter">
					<!-- Rekursion -->
					<xsl:call-template name="tLastSubstringAfter">
						<xsl:with-param name="pString" select="$vSubstringAfter"/>
						<xsl:with-param name="pCharacter" select="$pCharacter"/>
					</xsl:call-template>
				</xsl:variable>
				
				<xsl:choose>
					<xsl:when test="string-length($vLastSubstringAfter)>0">
						<!-- Zeichen/Zeichenkette nochmals in String gefunden -->
						<xsl:value-of select="$vLastSubstringAfter"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$vSubstringAfter"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$pString"/>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
</xsl:stylesheet>