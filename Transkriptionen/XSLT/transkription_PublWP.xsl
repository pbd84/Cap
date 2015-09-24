<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:exslt="http://exslt.org/common" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:my="my" version="1.0" exclude-result-prefixes="exslt msxsl tei xhtml my">

	<!-- author: NG -->
	<xsl:include href="allgFunktionen.xsl"/>

	<!--<xsl:output method="xhtml" encoding="UTF-8" indent="no"/>-->
	<xsl:output method="xml" encoding="UTF-8" indent="no"/>
	<xsl:strip-space elements="tei:*"/>

	<xsl:strip-space elements="*"/>

	<xsl:preserve-space elements="tei:ab tei:lb tei:text"/>

	<xsl:preserve-space elements="ab lb text"/>

	<!-- Funktion node-set() per Namespace "exslt" implementieren -->
	<msxsl:script language="JScript" implements-prefix="exslt">
		this['node-set'] =  function (x) {
		return x;
		}
	</msxsl:script>

	<xsl:key name="kSubst_Liste" match="//tei:subst" use="generate-id(.)"/>
	<xsl:key name="kAdd_Liste" match="//tei:add" use="generate-id(.)"/>
	<xsl:key name="kDel_Liste" match="//tei:del" use="generate-id(.)"/>
	<xsl:key name="kMod_Liste" match="//tei:mod" use="generate-id(.)"/>

	<xsl:key name="kSic_Liste" match="//tei:sic" use="generate-id(.)"/>

	<xsl:key name="kSpace_Liste" match="//tei:space" use="generate-id(.)"/>


	<xsl:variable name="vSubst_Liste">
		<xsl:for-each select="//tei:subst">
			<xsl:copy>
				<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
				<xsl:for-each select="@*">
					<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
				</xsl:for-each>
				<xsl:for-each select="./*">
					<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
				</xsl:for-each>
			</xsl:copy>
		</xsl:for-each>
	</xsl:variable>

	<!-- <subst> -->
	<xsl:variable name="Subst_mNote">
		<xsl:for-each select="//tei:subst">
			<xsl:variable name="vNoteFolgt">
				<xsl:call-template name="tNoteFolgt">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="$vNoteFolgt='true'">
				<xsl:copy>
					<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
					<xsl:for-each select="@*">
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="./*">
						<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
					</xsl:for-each>
				</xsl:copy>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="vSubst_mNote" select="key('kSubst_Liste',exslt:node-set($Subst_mNote)/*/@id)"/>

	<xsl:variable name="Subst_oNote">
		<xsl:for-each select="//tei:subst">
			<xsl:variable name="vNoteFolgt">
				<xsl:call-template name="tNoteFolgt">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="$vNoteFolgt='false'">
				<xsl:copy>
					<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
					<xsl:for-each select="@*">
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="./*">
						<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
					</xsl:for-each>
				</xsl:copy>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="vSubst_oNote" select="key('kSubst_Liste',exslt:node-set($Subst_oNote)/*/@id)"></xsl:variable>
	<!-- </subst> -->

	<!-- <add> -->
	<xsl:variable name="Add_mNote">
		<xsl:for-each select="//tei:add[parent::*[local-name(.)!='subst']]">
			<xsl:variable name="vNoteFolgt">
				<xsl:call-template name="tNoteFolgt">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="$vNoteFolgt='true'">
				<xsl:copy>
					<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
					<xsl:for-each select="@*">
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="./*">
						<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
					</xsl:for-each>
				</xsl:copy>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="vAdd_mNote" select="key('kAdd_Liste',exslt:node-set($Add_mNote)/*/@id)"></xsl:variable>

	<xsl:variable name="Add_oNote">
		<xsl:for-each select="//tei:add[parent::*[local-name(.)!='subst']]">
			<xsl:variable name="vNoteFolgt">
				<xsl:call-template name="tNoteFolgt">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="$vNoteFolgt='false'">
				<xsl:copy>
					<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
					<xsl:for-each select="@*">
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="./*">
						<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
					</xsl:for-each>
				</xsl:copy>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="vAdd_oNote" select="key('kAdd_Liste',exslt:node-set($Add_oNote)/*/@id)"></xsl:variable>
	<!-- </add> -->

	<!-- <del> -->
<!--	<xsl:variable name="Del_mNote">
		<xsl:for-each select="//tei:del[parent::*[local-name(.)!='subst']]">
			<xsl:variable name="vNoteFolgt">
				<xsl:call-template name="tNoteFolgt">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="$vNoteFolgt='true'">
				<xsl:copy>
					<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
					<xsl:for-each select="@*">
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="./*">
						<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
					</xsl:for-each>
				</xsl:copy>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="vDel_mNote" select="key('kDel_Liste',exslt:node-set($Del_mNote)/*/@id)"></xsl:variable>

	<xsl:variable name="Del_oNote">
		<xsl:for-each select="//tei:del[parent::*[local-name(.)!='subst']]">
			<xsl:variable name="vNoteFolgt">
				<xsl:call-template name="tNoteFolgt">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="$vNoteFolgt='false'">
				<xsl:copy>
					<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
					<xsl:for-each select="@*">
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="./*">
						<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
					</xsl:for-each>
				</xsl:copy>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="vDel_oNote" select="key('kDel_Liste',exslt:node-set($Del_oNote)/*/@id)"></xsl:variable>-->

	<xsl:variable name="Del_mNote">
		<!--<xsl:for-each select="//tei:del[parent::*[local-name(.)!='subst']]">-->
		<xsl:for-each select="//tei:del[parent::*[local-name(.)!='subst']][count(./node())>0]">
			<xsl:variable name="vNoteFolgt">
				<xsl:call-template name="tNoteFolgt">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="$vNoteFolgt='true'">
				<xsl:copy>
					<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
					<xsl:for-each select="@*">
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="./*">
						<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
					</xsl:for-each>
				</xsl:copy>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="vDel_mNote" select="key('kDel_Liste',exslt:node-set($Del_mNote)/*/@id)"></xsl:variable>

	<xsl:variable name="Del_oNote">
		<!--<xsl:for-each select="//tei:del[parent::*[local-name(.)!='subst']]">-->
		<xsl:for-each select="//tei:del[parent::*[local-name(.)!='subst']][count(./node())>0]">
			<xsl:variable name="vNoteFolgt">
				<xsl:call-template name="tNoteFolgt">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="$vNoteFolgt='false'">
				<xsl:copy>
					<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
					<xsl:for-each select="@*">
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="./*">
						<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
					</xsl:for-each>
				</xsl:copy>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="vDel_oNote" select="key('kDel_Liste',exslt:node-set($Del_oNote)/*/@id)"></xsl:variable>
	<!-- </del> -->

	<!-- <mod> -->
	<xsl:variable name="Mod_mNote">
		<xsl:for-each select="//tei:mod">
			<xsl:variable name="vNoteFolgt">
				<xsl:call-template name="tNoteFolgt">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="$vNoteFolgt='true'">
				<xsl:copy>
					<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
					<xsl:for-each select="@*">
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="./*">
						<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
					</xsl:for-each>
				</xsl:copy>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="vMod_mNote" select="key('kMod_Liste',exslt:node-set($Mod_mNote)/*/@id)"></xsl:variable>

	<xsl:variable name="Mod_oNote">
		<xsl:for-each select="//tei:mod">
			<xsl:variable name="vNoteFolgt">
				<xsl:call-template name="tNoteFolgt">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="$vNoteFolgt='false'">
				<xsl:copy>
					<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
					<xsl:for-each select="@*">
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="./*">
						<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
					</xsl:for-each>
				</xsl:copy>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="vMod_oNote" select="key('kMod_Liste',exslt:node-set($Mod_oNote)/*/@id)"></xsl:variable>
	<!-- </mod> -->

	<!-- <sic> -->
	<xsl:variable name="Sic_mNote">
		<xsl:for-each select="//tei:sic">
			<xsl:variable name="vNoteFolgt">
				<xsl:call-template name="tNoteFolgt">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="$vNoteFolgt='true'">
				<xsl:copy>
					<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
					<xsl:for-each select="@*">
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="./*">
						<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
					</xsl:for-each>
				</xsl:copy>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="vSic_mNote" select="key('kSic_Liste',exslt:node-set($Sic_mNote)/*/@id)"></xsl:variable>

	<xsl:variable name="Sic_oNote">
		<xsl:for-each select="//tei:sic">
			<xsl:variable name="vNoteFolgt">
				<xsl:call-template name="tNoteFolgt">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="$vNoteFolgt='false'">
				<xsl:copy>
					<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
					<xsl:for-each select="@*">
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="./*">
						<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
					</xsl:for-each>
				</xsl:copy>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="vSic_oNote" select="key('kSic_Liste',exslt:node-set($Sic_oNote)/*/@id)"></xsl:variable>
	<!-- </sic> -->

	<!-- <space> -->
	<xsl:variable name="Space_mNote">
		<xsl:for-each select="//tei:space">
			<xsl:variable name="vNoteFolgt">
				<xsl:call-template name="tNoteFolgt">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="$vNoteFolgt='true'">
				<xsl:copy>
					<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
					<xsl:for-each select="@*">
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="./*">
						<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
					</xsl:for-each>
				</xsl:copy>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="vSpace_mNote" select="key('kSpace_Liste',exslt:node-set($Space_mNote)/*/@id)"></xsl:variable>

	<xsl:variable name="Space_oNote">
		<xsl:for-each select="//tei:space">
			<xsl:variable name="vNoteFolgt">
				<xsl:call-template name="tNoteFolgt">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="$vNoteFolgt='false'">
				<xsl:copy>
					<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
					<xsl:for-each select="@*">
						<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="./*">
						<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
					</xsl:for-each>
				</xsl:copy>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="vSpace_oNote" select="key('kSpace_Liste',exslt:node-set($Space_oNote)/*/@id)"></xsl:variable>
	<!-- </space> -->

	<!-- VARIABLEN für Fußnoten(-index) -->
	<xsl:variable name="funoRef" select="//tei:cit/tei:ref"/>
	<!--<xsl:variable name="funoSic" select="//tei:sic"/>-->
	<xsl:variable name="funoSic" select="$vSic_oNote"/>
	<xsl:variable name="funoNote" select="//tei:note[@type='editorial'][ancestor::tei:body]"/>
	<!--<xsl:variable name="funoNoteNoEdit" select="//tei:note[not(@type='editorial')]"/>-->
	<xsl:variable name="funoNoteComment" select="//tei:note[@type='comment'][ancestor::tei:body]"/>
	<xsl:variable name="funoSubst" select="$vSubst_oNote"/>
	<xsl:variable name="funoDel" select="$vDel_oNote"/>
	<xsl:variable name="funoAdd" select="$vAdd_oNote"/>
	<!--<xsl:variable name="funoSpace" select="//tei:space"/>-->
	<xsl:variable name="funoSpace" select="$vSpace_oNote"/>
	<xsl:variable name="funoUnclear" select="//tei:unclear[count(tei:gap)>0]"/>
	<xsl:variable name="funoMod" select="$vMod_oNote"/>
	<xsl:variable name="funoChoice" select="//tei:choice"/>
	<xsl:variable name="funoHandShift" select="//tei:handShift"/>
	<!--<xsl:variable name="funoGap" select="//tei:gap"/>-->

	<!-- alphabetischer Fußnotenindex -->
	<!--<xsl:variable name="funoAlphabetisch" select="$funoSic|$funoNote|$funoSubst|$funoDel|$funoAdd|$funoSpace|$funoSpace|$funoNoteNoEdit|$funoMod"/>-->
	<!--<xsl:variable name="funoAlphabetisch" select="$funoSic|$funoNote|$funoSubst|$funoDel|$funoAdd|$funoSpace|$funoSpace|$funoNoteNoEdit|$funoMod|$funoGap"/>-->
	<!--<xsl:variable name="funoAlphabetisch" select="$funoSic|$funoNote|$funoSubst|$funoDel|$funoAdd|$funoSpace|$funoSpace|$funoMod|$funoGap"/>-->
	<!--<xsl:variable name="funoAlphabetisch" select="$funoSic|$funoNote|$funoSubst|$funoDel|$funoAdd|$funoSpace|$funoSpace|$funoMod"/>-->
	<xsl:variable name="funoAlphabetisch" select="$funoSic|$funoNote|$funoSubst|$funoDel|$funoAdd|$funoSpace|$funoSpace|$funoMod|$funoChoice|$funoHandShift"/>

	<!-- numerischer Fußnotenindex -->
	<!--<xsl:variable name="funoNumerisch" select="$funoRef"/>-->
	<xsl:variable name="funoNumerisch" select="$funoRef|$funoNoteComment"/>

	<xsl:template match="/">
<!--		<HTML lang="de">
			<HEAD>
				<meta charset="utf-8"/>
				<TITLE>
					<xsl:value-of select="//tei:title"/>
				</TITLE>-->

				<style type="text/css">
                    body { <!-- allgemeine Darstellung des Textes -->
                        <!--font-family: 'Times New Roman';-->
                        line-height: 100%;
                        <!--font-size: medium-->
						font-size: 90%
                        }
                    span.titel {
                        font-weight: bold;
                        font-size: 110%;
                        color: #b92900;
                        }

                    span.encodingDesc {
                    	<!--display: inline-block;-->
                    	<!--font-style: italic;-->
                    	font-size: 90%
                    	}
                    	
                    div.transkr {
                    	<!--font-family: 'Times New Roman';-->
                    }

                    div.text {
                    	<!--display: inline-block;-->

						<!--white-space: nowrap;-->

                    	line-height: 200%;
                    	font-size: 120%
                    	}

					<!-- Hinzufügung durch DS am 29.08.2014, da sonst komplette WP-Seite inklusive Header und Menü in Times New Roman -->
					div.meta {
					line-height: 100%;
					<!--font-family: 'Times New Roman'-->
					}

<!--                    div.initial { <!-\- Initialen -\->
                        display: inline-block;
                        font-family: Arial;
                        font-weight: bold
					<!-\-
                    	color: white;
                        background-color: black
					-\->
                        }-->
                        
                        span.initial { <!-- Initialen -->
					display: inline-block;
					font-family: Arial;
					font-weight: bold
					<!--
                    	color: white;
                        background-color: black
					-->
					}
                        
                    span.initialABC { <!-- Initialen, Buchstaben -->
                        font-size: 110%
                        }
                    span.initialTYP { <!-- Initialen, Typ-Marker -->
                        font-size: 50%;
                        vertical-align: top
                        }
                    span.versalie {
                        font-size: 110%;
                        font-weight: bold
                        }

                    span.folio {
                    	font-weight: bold;
                    	<!--font-style: italic-->
						color: grey;
						font-style: normal
                    	}

                    span.milestone {
                    <!--
                        line-height: 100%;
                        font-size: 110%;
                        font-weight: bold
                    -->
						font-weight: bold;
						<!--color: lightgrey;-->
						color: grey;
						font-weight: bold;
						font-family: 'Arial'
                        }
                        
                        span.corresp {
                        line-height: 100%;
                        font-size: 50%;
					<!--color: lightgrey;-->
					color: grey;
					font-weight: bold;
					font-family: 'Arial'
					}
					
					div.corresp {
					line-height: 100%;
					font-size: 70%;
					color: grey;
					font-weight: bold;
					vertical-align: top;
					font-family: 'Arial'
					}
					
					div.corresp2 {
					line-height: 100%;
					font-size: 70%;
					<!--color: lightgrey;-->
					font-weight: bold;
					vertical-align: top;
					<!--font-family: 'Arial'-->
					}
					
                    span.quote {
                        font-size: 100%;
                        font-weight: normal
                        }
					span.unclear {
						color: lightgrey;
                        }
                    span.abTEXT { <!-- Darstellung innerhalb <ab type="text"> -->
<!--                    line-height: 200%;
                        font-size: 120%-->
						line-height: 150%;
                        }
                    span.abMETA { <!-- Darstellung innerhalb <ab type="meta-text"> -->
<!--                    line-height: 200%;
                        font-size: 120%;-->
                        font-weight: bold
                        }

					span.hiSuper {
						vertical-align: top;
						font-size: 60%
					}

					span.frontDiv {
					font-weight: bold
					}
					
					span.PublikationAenderung {
					font-size: smaller;
					color: black;
					}

					ol.alphabetisch {
                        list-style:lower-alpha outside none;
                        }
					ol.numerisch {

                        }


                        @media all {
                        .page-break	{ display: none; }
                        }

                        @media print {
                        .page-break	{ display: block; page-break-before: always; }
                        div, span, article { float: none !important; }
                        .qtrans_language_chooser { display: none; }
                        nav {display: none !important}
                        }
                        
<!--					a {
					vertical-align: super;
					font-size: smaller;
					}-->
					
					span.frontMentioned {
					font-style: normal;
					}
					
					span.textMentioned {
					font-style: italic;
					}
					
					span.textItalic {
					font-style: italic;
					}

                </style>
<!--			</HEAD>
			<BODY>-->
				<div class="transkr" align="justify"> <!-- Ersatz für <body> -->
				
				<xsl:if test="count(//tei:div[@xml:id='divContent'])>0">
					<div id="inhaltsverzeichnis" style="display: none">

						<xsl:text>Inhaltsverzeichnis:</xsl:text>
						<br/>

						<!--<xsl:apply-templates select="tei:text/tei:front/tei:div[@xml:id='divContent']"/>-->
						<xsl:apply-templates select="//tei:div[@xml:id='divContent']" mode="toc"/>
					</div>
				</xsl:if>




<!--				<span class="textItalic">
					<xsl:text>(Leseversion für die Editoren)</xsl:text>
				</span>-->
				<!--<hr/>-->

				<!-- TITLE -->
				<div class="meta">
					<p>
						<xsl:apply-templates select="//tei:teiHeader"/>
					</p>
				</div>

				<br/>
				<!-- ??? für Abstand zwischen Header und Body -->
				<br/>
				<!-- ??? für Abstand zwischen Header und Body -->


				<!-- TEXT -->
				<div id="EditorischeVorbemerkung">
					<span style="font-weight: bold;">
						<xsl:text>Editorische Vorbemerkung zur Transkription</xsl:text>
					</span>
<!--					<h5>
						<xsl:text>Editorische Vorbemerkung zur Transkription</xsl:text>
					</h5>-->
					<br/>
					<br/>
					<span class="encodingDesc">
						<xsl:apply-templates select="//tei:text/tei:front/tei:div[count(./node())>0]"/>
					</span>
				</div>

				<!-- Seitenumbruch -->
				<span class="page-break">
					<xsl:text> </xsl:text> <!-- <span> muss gefüllt sein, sonst landet der restliche Output des Templates darin (Wieso auch immer...) / Wird nur beim Druck ausgegeben! => Hier vllt sowas wie "BK_..." ausgeben lassen, um Orientierung mit Ausdrucken zu erleichtern?! -->
				</span>

				<br/>
				<hr/>
					<div align="right">
						<a href="#top" class="ssdone">
							<img alt="To top" src="http://capitularia.uni-koeln.de/ThemeDummy/wp-content/themes/Capitularia/img/icon-to-top.png"/>
						</a>
					</div>
				<br/>

				<!-- BODY -->
				<div class="text">
					<xsl:apply-templates select="//tei:body"/>
				</div>


				<br/>
				<br/>


				<!-- Seitenumbruch -->
				<span class="page-break">
					<xsl:text> </xsl:text> <!-- <span> muss gefüllt sein, sonst landet der restliche Output des Templates darin (Wieso auch immer...) / Wird nur beim Druck ausgegeben! => Hier vllt sowas wie "BK_..." ausgeben lassen, um Orientierung mit Ausdrucken zu erleichtern?! -->
				</span>

				<br/>
				<hr/>
					<div align="right">
						<a href="#top" class="ssdone">
							<img alt="To top" src="http://capitularia.uni-koeln.de/ThemeDummy/wp-content/themes/Capitularia/img/icon-to-top.png"/>
						</a>
					</div>
				<br/>

				<!-- Fußnoten -->

				<!-- alphabetische Fußnoten -->
				<ol type="a" class="alphabetisch">
					<xsl:for-each select="$funoAlphabetisch">
						<xsl:variable name="vFunoText">
							<xsl:call-template name="tFunoText_alphabetisch">
								<xsl:with-param name="pNode" select="."/>
							</xsl:call-template>
						</xsl:variable>

						<li id="{generate-id()}">
							<!--<xsl:value-of select="$vFunoText"/>-->
							<xsl:copy-of select="exslt:node-set($vFunoText)"/>
							<xsl:text> </xsl:text>
							<a href="#{generate-id()}-L" class="noteBack">&#x2934;</a>
						</li>

					</xsl:for-each>
				</ol>
					
					
				<br/>

				<!-- numerische Fußnoten -->
					<!--<ol type="1" class="numerisch">-->
				<ol type="1" class="numerisch">
					<xsl:for-each select="$funoNumerisch">
						<xsl:variable name="vFunoText">
							<xsl:call-template name="tFunoText_numerisch">
								<xsl:with-param name="pNode" select="."/>
							</xsl:call-template>
						</xsl:variable>

						<li id="{generate-id()}" type="1">
							<!--<xsl:apply-templates select="./node()"/>-->
							<xsl:copy-of select="exslt:node-set($vFunoText)"/>
							<a href="#{generate-id()}-L" class="noteBack">&#x2934;</a>
						</li>
					</xsl:for-each>
				</ol>
					
					<div align="right">
						<a href="#top" class="ssdone">
							<img alt="To top" src="http://capitularia.uni-koeln.de/ThemeDummy/wp-content/themes/Capitularia/img/icon-to-top.png"/>
						</a>
					</div>
					
				</div>
<!--			</BODY>
		</HTML>-->
	</xsl:template>

	<!--
    #############################################################################################
      -->


	<!-- Das strukturierte Inhaltsverzeichnis in der Sidebar wird
	     vorläufig aus einem nur zu diesem Zwecke angelegten div
	     erzeugt.  TODO: Struktur irgendwie aus dem Haupttext
	     ableiten. -->

	<xsl:template match="tei:div[@xml:id='divContent']//tei:list" mode="toc">
	  <ul>
	    <xsl:apply-templates select="tei:item" mode="toc"/>
	  </ul>
	</xsl:template>

	<xsl:template match="tei:div[@xml:id='divContent']//tei:item" mode="toc">
	  <li>
	    <a href="{tei:ptr/@target}"><xsl:value-of select="text()"/></a>
            <xsl:apply-templates select="tei:list" mode="toc"/>
	  </li>
	</xsl:template>

<!--	<xsl:template match="//tei:title">
		<span class="titel">
			<xsl:value-of select="."/>
		</span>
	</xsl:template>-->
	
	<xsl:template match="tei:body">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="tei:title">

	</xsl:template>
	
	<xsl:template match="tei:title[@type='main']">
<!--		<span class="titel">
			<xsl:value-of select="."/>
		</span>-->
<!--		<span class="titel">
			<xsl:text>Transkription</xsl:text>
		</span>-->
		<h4>
			<xsl:text>Transkription</xsl:text>
		</h4>
		
		<br/>
		<span class="PublikationAenderung">
			<xsl:text>(</xsl:text>
			<xsl:apply-templates select="//tei:publicationStmt/tei:date"/>
			<xsl:apply-templates select="//tei:revisionDesc/tei:change[last()]"/>
			<!--<xsl:apply-templates select="//tei:revisionDesc/tei:change"/>-->
			<xsl:text>)</xsl:text>
		</span>
	</xsl:template>
	
	
	<xsl:template match="tei:front/tei:div[count(./node())>0]">
		<!--
- <front>:
	Die einzelnen <div>s sollten noch Überschriften bekommen (selbe Schriftart, aber fett; danach einfacher Zeilenumbruch):
		scribe = Schreiber
		lett = Buchstabenformen
		abbr = Abkürzungen
		punct = Interpunktion
		struct = Gliederungsmerkmale
		other = Sonstiges
-->
		
		<!-- Zeilenumbruch nur für nachfoglende Elemente, um den Abstand nach oben zu verkürzen -->
		<xsl:if test="count(preceding-sibling::tei:div)>0">
			<br/>	
		</xsl:if>
		
		
		<xsl:choose>
			<xsl:when test="@type='scribe'">
				<span class="frontDiv"><xsl:text>Schreiber</xsl:text></span>
				<br/>
			</xsl:when>
			<xsl:when test="@type='lett' or @type='letters'">
				<span class="frontDiv"><xsl:text>Buchstabenformen</xsl:text></span>
				<br/>
			</xsl:when>
			<xsl:when test="@type='abbr' or @type='abbreviation' or @type='abbreviations'">
				<span class="frontDiv"><xsl:text>Abkürzungen</xsl:text></span>
				<br/>
			</xsl:when>
			<xsl:when test="@type='punct' or @type='punctuation'">
				<span class="frontDiv"><xsl:text>Interpunktion</xsl:text></span>
				<br/>
			</xsl:when>
			<xsl:when test="@type='struct' or @type='structure'">
				<span class="frontDiv"><xsl:text>Gliederungsmerkmale</xsl:text></span>
				<br/>
			</xsl:when>
			<xsl:when test="@type='other'">
				<span class="frontDiv"><xsl:text>Sonstiges</xsl:text></span>
				<br/>
			</xsl:when>
			<xsl:when test="@type='mshist'">
				<span class="frontDiv"><xsl:text>Zur Handschrift</xsl:text></span>
				<br/>
			</xsl:when>
			<xsl:when test="@type='annotations'">
				<span class="frontDiv"><xsl:text>Benutzungsspuren</xsl:text></span>
				<br/>
			</xsl:when>
			<xsl:otherwise>
				
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:for-each select="tei:p">
			<span class="textItalic">
				<xsl:apply-templates select="node()"/>
			</span>
			<br/>
		</xsl:for-each>

	</xsl:template>
	
<!--	<xsl:template match="tei:mentioned/text()">
		<span class="textMentioned">
			<xsl:value-of select="."/>
		</span>
	</xsl:template>-->
	
	<xsl:template match="tei:mentioned[not(ancestor::tei:front)]">
		<span class="textMentioned">
			<xsl:value-of select="node()"/>
		</span>
	</xsl:template>
	
	<!--	<xsl:template match="tei:mentioned/text()">
		<i>
			<xsl:value-of select="."/>
		</i>
	</xsl:template>-->
	
	<xsl:template match="tei:mentioned/text()[ancestor::tei:front]">
		<span class="frontMentioned">
			<xsl:value-of select="."/>
		</span>
	</xsl:template>
	
	<xsl:template match="tei:publicationStmt/tei:date">
		
		<xsl:variable name="vDatum_isYYY-MM-DD">
			<xsl:call-template name="tDate_isYYYY-MM-DD">
				<xsl:with-param name="pDate" select="@when"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:text>Veröffentlicht am </xsl:text>
		<!--<xsl:value-of select="@when"/>-->
		
		<xsl:choose>
			<xsl:when test="$vDatum_isYYY-MM-DD='true'">
				<xsl:variable name="vDatum">
					<xsl:call-template name="tDate_YYYY-MM-DDtoDD-MM-YYYY">
						<xsl:with-param name="pDate_YYYY-MM-DD" select="@when"/>
					</xsl:call-template>
				</xsl:variable>
				
				<xsl:variable name="vDatumSlashes">
					<xsl:value-of select="translate($vDatum,'-','/')"/>
				</xsl:variable>
				
				<!--<xsl:value-of select="$vDatum"/>-->
				<xsl:value-of select="$vDatumSlashes"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@when"/>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	<xsl:template match="tei:revisionDesc/tei:change">
		<xsl:variable name="vDatum_isYYY-MM-DD">
			<xsl:call-template name="tDate_isYYYY-MM-DD">
				<xsl:with-param name="pDate" select="@when"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="vDatum_ChangeNachPubl">
			<xsl:call-template name="tDate_Vergleich_1vor2">
				<xsl:with-param name="pDate1_YYYY-MM-DD" select="//tei:publicationStmt/tei:date/@when"/>
				<xsl:with-param name="pDate2_YYYY-MM-DD" select="@when"/>
			</xsl:call-template>
		</xsl:variable>
		
		<!--<xsl:text>{</xsl:text><xsl:value-of select="$vDatum_ChangeNachPubl"/><xsl:text>}</xsl:text>-->
		
		<xsl:if test="$vDatum_ChangeNachPubl='true'">
			<xsl:text>, letzte Änderung: </xsl:text>
			<xsl:choose>
				<xsl:when test="$vDatum_isYYY-MM-DD='true'">
					<xsl:variable name="vDatum">
						<xsl:call-template name="tDate_YYYY-MM-DDtoDD-MM-YYYY">
							<xsl:with-param name="pDate_YYYY-MM-DD" select="@when"/>
						</xsl:call-template>
					</xsl:variable>
					
					<xsl:variable name="vDatumSlashes">
						<xsl:value-of select="translate($vDatum,'-','/')"/>
					</xsl:variable>
					
					<!--<xsl:value-of select="$vDatum"/>-->
					<xsl:value-of select="$vDatumSlashes"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@when"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

	</xsl:template>

	<xsl:template match="tei:publisher">
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="tei:encodingDesc">
		<br/>

		<span class="encodingDesc">
			<xsl:apply-templates select="node()"/>
		</span>
	</xsl:template>

	<xsl:template match="tei:encodingDesc//text()">
		<span class="textItalic">
			<xsl:value-of select="."/>
		</span>
	</xsl:template>

	<xsl:template match="tei:encodingDesc/tei:p">
		<p>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="tei:encodingDesc/tei:p/tei:mentioned">
		<!-- BAUSTELLE ??? -->
		<xsl:value-of select="."/>
	</xsl:template>
	
	<xsl:template match="tei:projectDesc"/>
	<xsl:template match="tei:editorialDecl"/>
	<xsl:template match="tei:revisionDesc"/>	
	

<!--	<xsl:template match="tei:revisionDesc">
		<b>
			<xsl:text>Bearbeitung</xsl:text>
		</b>
		<br/>
		<xsl:for-each select="tei:change">
			<xsl:value-of select="text()"/>
			<xsl:text>: </xsl:text>
			<xsl:value-of select="@who"/>
			<xsl:text> (</xsl:text>
			<xsl:value-of select="@when"/>
			<xsl:text>)</xsl:text>
			<br/>
		</xsl:for-each>
	</xsl:template>-->

	<!-- zusätzliche Formatierung -->
	<xsl:template match="tei:fileDesc">
		<xsl:apply-templates select="./tei:titleStmt/tei:title"/>
		<br/>
	</xsl:template>

	<xsl:template match="tei:respStmt">
		<br/>
		<xsl:value-of select="./tei:resp"/>
		<xsl:text>: </xsl:text>
		<xsl:value-of select="./tei:name"/>
	</xsl:template>
	<!-- /zusätzliche Formatierung -->


	<!--
    #############################################################################################
        <body>:

    -->

	<xsl:template match="tei:body/tei:ab[@type='text']">


		<xsl:if test="count(@corresp)>0">
			<xsl:choose>
				<xsl:when test="not(contains(@corresp,'inscriptio')) and not(contains(@corresp,'incipit'))">
					<xsl:variable name="vCorresp">
						<xsl:call-template name="string-replace">
							<xsl:with-param name="string" select="translate(@corresp,'.',' ')"/>
							<xsl:with-param name="replace" select="'_'"/>
							<xsl:with-param name="with" select="' c. '"/>
						</xsl:call-template>
						
						<!--<xsl:value-of select="translate(translate(./@corresp,'.',' '),'_',' ')"/>-->
					</xsl:variable>
					
					<div class="corresp">
						<xsl:text>[</xsl:text>
						<xsl:value-of select="$vCorresp"/>
						<xsl:text>]</xsl:text>
					</div>
				</xsl:when>
				<xsl:when test="contains(@corresp,'inscriptio')">
					<!-- inscriptio entfernen -->
					
					<!-- inscriptio finden, delimiter vor und anch isncriptio finden, text vor und nach delimiter übernehmen -->
					<xsl:variable name="vInscriptioBefore_mitRest">
						<xsl:value-of select="substring-before(@corresp,'inscriptio')"/>
					</xsl:variable>
					<xsl:variable name="vInscriptioBefore_nurRest">
						<xsl:call-template name="tLastSubstringAfter">
							<xsl:with-param name="pString" select="$vInscriptioBefore_mitRest"/>
							<xsl:with-param name="pCharacter" select="' '"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="vInscriptioBefore">
						<xsl:value-of select="substring($vInscriptioBefore_mitRest, 1, string-length($vInscriptioBefore_mitRest) - string-length($vInscriptioBefore_nurRest))"/>
					</xsl:variable>
					<xsl:variable name="vInscriptioAfter">
						<xsl:value-of select="substring-after(substring-after(@corresp,'inscriptio'),' ')"/>
					</xsl:variable>
					
					<xsl:variable name="vCorrespOhne">
						<!-- corresp ohne Einzel-Einträge, die "inscriptio" oder "incipit" beinhalten -->
						<xsl:value-of select="$vInscriptioBefore"/>
						<xsl:value-of select="$vInscriptioAfter"/>
					</xsl:variable>
					
					<xsl:variable name="vCorrespOhne2">
						<xsl:call-template name="string-replace">
							<xsl:with-param name="string" select="translate($vCorrespOhne,'.',' ')"/>
							<xsl:with-param name="replace" select="'_'"/>
							<xsl:with-param name="with" select="' c. '"/>
						</xsl:call-template>
					</xsl:variable>
					
					
					<!-- Ausgabe -->
					<xsl:if test="string-length($vCorrespOhne2) &gt; 0">
						<div class="corresp">
							<xsl:text>[</xsl:text>
							<xsl:value-of select="$vCorrespOhne2"/>
							<xsl:text>]</xsl:text>
						</div>
					</xsl:if>
				</xsl:when>
				<xsl:when test="contains(@corresp,'incipit')">
					<!-- incipit entfernen -->
					<!-- incipit finden, delimiter vor und anch isncriptio finden, text vor und nach delimiter übernehmen -->
					<xsl:variable name="vInscriptioBefore_mitRest">
						<xsl:value-of select="substring-before(@corresp,'incipit')"/>
					</xsl:variable>
					<xsl:variable name="vInscriptioBefore_nurRest">
						<xsl:call-template name="tLastSubstringAfter">
							<xsl:with-param name="pString" select="$vInscriptioBefore_mitRest"/>
							<xsl:with-param name="pCharacter" select="' '"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="vInscriptioBefore">
						<xsl:value-of select="substring($vInscriptioBefore_mitRest, 1, string-length($vInscriptioBefore_mitRest) - string-length($vInscriptioBefore_nurRest))"/>
					</xsl:variable>
					<xsl:variable name="vInscriptioAfter">
						<xsl:value-of select="substring-after(substring-after(@corresp,'incipit'),' ')"/>
					</xsl:variable>
					
					<xsl:variable name="vCorrespOhne">
						<!-- corresp ohne Einzel-Einträge, die "inscriptio" oder "incipit" beinhalten -->
						<xsl:value-of select="$vInscriptioBefore"/>
						<xsl:value-of select="$vInscriptioAfter"/>
					</xsl:variable>
					
					<xsl:variable name="vCorrespOhne2">
						<xsl:call-template name="string-replace">
							<xsl:with-param name="string" select="translate($vCorrespOhne,'.',' ')"/>
							<xsl:with-param name="replace" select="'_'"/>
							<xsl:with-param name="with" select="' c. '"/>
						</xsl:call-template>
					</xsl:variable>
					
					
					<!-- Ausgabe -->
					<xsl:if test="string-length($vCorrespOhne2) &gt; 0">
						<div class="corresp">
							<xsl:text>[</xsl:text>
							<xsl:value-of select="$vCorrespOhne2"/>
							<xsl:text>]</xsl:text>
						</div>
					</xsl:if>

				</xsl:when>
				<xsl:otherwise>
					<!-- ??? -->
				</xsl:otherwise>
			</xsl:choose>
			
			
			
<!--			<xsl:if test="not(contains(@corresp,'inscriptio'))">			
				<xsl:variable name="vCorresp">
					<xsl:call-template name="string-replace">
						<xsl:with-param name="string" select="translate(@corresp,'.',' ')"/>
						<xsl:with-param name="replace" select="'_'"/>
						<xsl:with-param name="with" select="' c. '"/>
					</xsl:call-template>
					
					<!-\-<xsl:value-of select="translate(translate(./@corresp,'.',' '),'_',' ')"/>-\->
				</xsl:variable>
				
				<div class="corresp">
					<xsl:text>[</xsl:text>
					<xsl:value-of select="$vCorresp"/>
					<xsl:text>]</xsl:text>
				</div>
			</xsl:if>-->
			
<!--			<xsl:variable name="vCorresp_inscriptio">
				<xsl:call-template name="string-replace">
					<xsl:with-param name="string" select="@corresp"/>
					<xsl:with-param name="replace" select="'_inscriptio_'"/>
					<xsl:with-param name="with" select="' inscriptio '"/>
				</xsl:call-template>
			</xsl:variable>
			
			<xsl:variable name="vCorresp">
				<xsl:call-template name="string-replace">
					<xsl:with-param name="string" select="translate($vCorresp_inscriptio,'.',' ')"/>
					<xsl:with-param name="replace" select="'_'"/>
					<xsl:with-param name="with" select="' c. '"/>
				</xsl:call-template>
				
				<!-\-<xsl:value-of select="translate(translate(./@corresp,'.',' '),'_',' ')"/>-\->
			</xsl:variable>
			
			<div class="corresp">
				<xsl:text>[</xsl:text>
				<xsl:value-of select="$vCorresp"/>
				<xsl:text>]</xsl:text>
			</div>-->
			<!--<br/>-->
		</xsl:if>

		<span class="abTEXT" lang="la">
			<xsl:apply-templates/>
		</span>
		<br/>

		<span class="page-break">
			<xsl:text> </xsl:text> <!-- <span> muss gefüllt sein, sonst landet der restliche Output des Templates darin (Wieso auch immer...) / Wird nur beim Druck ausgegeben! => Hier vllt sowas wie "BK_..." ausgeben lassen, um Orientierung mit Ausdrucken zu erleichtern?! -->
		</span>

	</xsl:template>
	<xsl:template match="tei:body/tei:ab[@type='meta-text']">

		<br/>
		<xsl:if test="count(@corresp)>0">
			<xsl:choose>
				<xsl:when test="not(contains(@corresp,'inscriptio')) and not(contains(@corresp,'incipit'))">
					<xsl:variable name="vCorresp">
						<xsl:call-template name="string-replace">
							<xsl:with-param name="string" select="translate(@corresp,'.',' ')"/>
							<xsl:with-param name="replace" select="'_'"/>
							<xsl:with-param name="with" select="' c. '"/>
						</xsl:call-template>
						
						<!--<xsl:value-of select="translate(translate(./@corresp,'.',' '),'_',' ')"/>-->
					</xsl:variable>
					
					<div class="corresp">
						<xsl:text>[</xsl:text>
						<xsl:value-of select="$vCorresp"/>
						<xsl:text>]</xsl:text>
					</div>
				</xsl:when>
				<xsl:when test="contains(@corresp,'inscriptio')">
					<!-- inscriptio entfernen -->
					
					<!-- inscriptio finden, delimiter vor und anch isncriptio finden, text vor und nach delimiter übernehmen -->
					<xsl:variable name="vInscriptioBefore_mitRest">
						<xsl:value-of select="substring-before(@corresp,'inscriptio')"/>
					</xsl:variable>
					<xsl:variable name="vInscriptioBefore_nurRest">
						<xsl:call-template name="tLastSubstringAfter">
							<xsl:with-param name="pString" select="$vInscriptioBefore_mitRest"/>
							<xsl:with-param name="pCharacter" select="' '"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="vInscriptioBefore">
						<xsl:value-of select="substring($vInscriptioBefore_mitRest, 1, string-length($vInscriptioBefore_mitRest) - string-length($vInscriptioBefore_nurRest))"/>
					</xsl:variable>
					<xsl:variable name="vInscriptioAfter">
						<xsl:value-of select="substring-after(substring-after(@corresp,'inscriptio'),' ')"/>
					</xsl:variable>
					
					<xsl:variable name="vCorrespOhne">
						<!-- corresp ohne Einzel-Einträge, die "inscriptio" oder "incipit" beinhalten -->
						<xsl:value-of select="$vInscriptioBefore"/>
						<xsl:value-of select="$vInscriptioAfter"/>
					</xsl:variable>
					
					<xsl:variable name="vCorrespOhne2">
						<xsl:call-template name="string-replace">
							<xsl:with-param name="string" select="translate($vCorrespOhne,'.',' ')"/>
							<xsl:with-param name="replace" select="'_'"/>
							<xsl:with-param name="with" select="' c. '"/>
						</xsl:call-template>
					</xsl:variable>
					
					
					<!-- Ausgabe -->
					<xsl:if test="string-length($vCorrespOhne2) &gt; 0">
						<div class="corresp">
							<xsl:text>[</xsl:text>
							<xsl:value-of select="$vCorrespOhne2"/>
							<xsl:text>]</xsl:text>
						</div>
					</xsl:if>
				</xsl:when>
				<xsl:when test="contains(@corresp,'incipit')">
					<!-- incipit entfernen -->
					<!-- incipit finden, delimiter vor und anch isncriptio finden, text vor und nach delimiter übernehmen -->
					<xsl:variable name="vInscriptioBefore_mitRest">
						<xsl:value-of select="substring-before(@corresp,'incipit')"/>
					</xsl:variable>
					<xsl:variable name="vInscriptioBefore_nurRest">
						<xsl:call-template name="tLastSubstringAfter">
							<xsl:with-param name="pString" select="$vInscriptioBefore_mitRest"/>
							<xsl:with-param name="pCharacter" select="' '"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="vInscriptioBefore">
						<xsl:value-of select="substring($vInscriptioBefore_mitRest, 1, string-length($vInscriptioBefore_mitRest) - string-length($vInscriptioBefore_nurRest))"/>
					</xsl:variable>
					<xsl:variable name="vInscriptioAfter">
						<xsl:value-of select="substring-after(substring-after(@corresp,'incipit'),' ')"/>
					</xsl:variable>
					
					<xsl:variable name="vCorrespOhne">
						<!-- corresp ohne Einzel-Einträge, die "inscriptio" oder "incipit" beinhalten -->
						<xsl:value-of select="$vInscriptioBefore"/>
						<xsl:value-of select="$vInscriptioAfter"/>
					</xsl:variable>
					
					<xsl:variable name="vCorrespOhne2">
						<xsl:call-template name="string-replace">
							<xsl:with-param name="string" select="translate($vCorrespOhne,'.',' ')"/>
							<xsl:with-param name="replace" select="'_'"/>
							<xsl:with-param name="with" select="' c. '"/>
						</xsl:call-template>
					</xsl:variable>
					
					
					<!-- Ausgabe -->
					<xsl:if test="string-length($vCorrespOhne2) &gt; 0">
						<div class="corresp">
							<xsl:text>[</xsl:text>
							<xsl:value-of select="$vCorrespOhne2"/>
							<xsl:text>]</xsl:text>
						</div>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<!-- ??? -->
				</xsl:otherwise>
			</xsl:choose>
			
			
<!--			<xsl:if test="not(contains(@corresp,'inscriptio'))">			
				<xsl:variable name="vCorresp">
					<xsl:call-template name="string-replace">
						<xsl:with-param name="string" select="translate(@corresp,'.',' ')"/>
						<xsl:with-param name="replace" select="'_'"/>
						<xsl:with-param name="with" select="' c. '"/>
					</xsl:call-template>
					
					<!-\-<xsl:value-of select="translate(translate(./@corresp,'.',' '),'_',' ')"/>-\->
				</xsl:variable>
				
				<div class="corresp">
					<xsl:text>[</xsl:text>
					<xsl:value-of select="$vCorresp"/>
					<xsl:text>]</xsl:text>
				</div>
			</xsl:if>-->
			
			<!--			<xsl:variable name="vCorresp_inscriptio">
				<xsl:call-template name="string-replace">
					<xsl:with-param name="string" select="@corresp"/>
					<xsl:with-param name="replace" select="'_inscriptio_'"/>
					<xsl:with-param name="with" select="' inscriptio '"/>
				</xsl:call-template>
			</xsl:variable>
			
			<xsl:variable name="vCorresp">
				<xsl:call-template name="string-replace">
					<xsl:with-param name="string" select="translate($vCorresp_inscriptio,'.',' ')"/>
					<xsl:with-param name="replace" select="'_'"/>
					<xsl:with-param name="with" select="' c. '"/>
				</xsl:call-template>
				
				<!-\-<xsl:value-of select="translate(translate(./@corresp,'.',' '),'_',' ')"/>-\->
			</xsl:variable>
			
			<div class="corresp">
				<xsl:text>[</xsl:text>
				<xsl:value-of select="$vCorresp"/>
				<xsl:text>]</xsl:text>
			</div>-->
			<!--<br/>-->
		</xsl:if>
		<span class="abMETA" lang="la">
			<xsl:attribute name="id">
				<xsl:value-of select="@xml:id"/>
			</xsl:attribute>
			
			<xsl:choose>
				<xsl:when test="@rend='red'">
					<span style="color: #b92900;">
						<xsl:apply-templates/>
					</span>
				</xsl:when>
				<xsl:when test="@rend='default'">
					<span style="color: black;">
						<xsl:apply-templates/>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>

		</span>
		<!--<br/>-->
	</xsl:template>

	<!--<xsl:template match="//tei:seg[@type[.='titulus' or .='numDenom' or .='num']][@rend[.='majuscule red']]"> 19.12.2014-->
	<!--<xsl:template match="//tei:seg[@type[.='titulus' or .='numDenom' or .='num']][@rend[.='red']]"> 19.12.2014-->

		<xsl:template match="//tei:seg[@type[.='numDenom' or .='num']]">
<!--		<b>
			<xsl:apply-templates/>
		</b>-->

<!--		<span class="abMETA" lang="la">
			<xsl:apply-templates/>
		</span>-->
			
			<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="tei:lb">
		<!-- <lb> ignorieren ?!? -->


		<!-- BAUSTELLE: =><lb> ignorieren! -->
<!--		<xsl:choose>
			<xsl:when test="current()[@break='no']">
				<xsl:text>-</xsl:text>
				<br/>
			</xsl:when>
			<xsl:otherwise>
				<br/>
			</xsl:otherwise>
		</xsl:choose>-->
	</xsl:template>
	<xsl:template match="tei:lb[parent::node()[@place='margin']]">
	</xsl:template>

	<xsl:template match="tei:cb">
<!--		<xsl:choose>
			<xsl:when test="current()[@break='no']">
				<xsl:text>-</xsl:text>
				<br/>
			</xsl:when>
			<xsl:otherwise>
				<br/>
			</xsl:otherwise>
		</xsl:choose> 19.12.2014-->
		<xsl:if test="not(current()[@break='no'])">
			<xsl:text> </xsl:text>
		</xsl:if>
		<span class="folio">
			<xsl:choose>
				<!--<xsl:when test="substring(@n,2,1)='r'">-->
				<!--<xsl:when test="contains(@n,'r')">-->
				<!--<xsl:when test="substring(@n,2,1)='r'">-->
				<xsl:when test="string-length(translate(@n,'r',''))!=string-length(@n)">
					<!-- recto -->
					<xsl:text>[fol. </xsl:text>
					<xsl:value-of select="./@n"/>
					<xsl:text>]</xsl:text>
				</xsl:when>
				<!--<xsl:when test="substring(@n,2,1)='v'">-->
				<xsl:when test="string-length(translate(@n,'v',''))!=string-length(@n)">
					<!-- verso -->
					<xsl:text>[fol. </xsl:text>
					<xsl:value-of select="./@n"/>
					<xsl:text>]</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<!-- sonst -->
					<xsl:text>[p. </xsl:text>
					<xsl:value-of select="./@n"/>
					<xsl:text>]</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</span>
		<xsl:if test="not(current()[@break='no'])">
			<xsl:text> </xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="tei:milestone">
<!--		<br/>
		<br/> <!-\- zusätzlich => 18.12.2014 hinzugefügt -\->-->
		
		
		<span class="milestone">
			<xsl:attribute name="id">
				<!--<xsl:value-of select="translate(translate(translate(@n,'.','_'),'[',''),']','')"/>-->
				<xsl:value-of select="translate(@n,'.','_')"/>
			</xsl:attribute>
			<xsl:text> [</xsl:text>
			<xsl:value-of select="translate(translate(./@n,'.',' '),'_',' ')"/>
			<xsl:text>] </xsl:text>
		</span>
		
		<!--<br/>-->
	</xsl:template>


	<!-- Typ-Unterscheidung hinzufügen!!! -->
	<!--
            Die einzelnen Typen sollen optisch unterscheidbar sein, ohne daß man Farbe verwenden muß.
            Alle größer und fett; zusätzlich zur Unterscheidung verschiedene Größen/Schrifttypen?
        -->
	<!--<xsl:template match="//tei:seg[substring-before(@type,'-')='initial']">-->
	<!--<xsl:template match="//tei:seg[string-length(translate(@type,'initial',''))!=string-length(@type)]">-->
	<xsl:template match="tei:seg[@type='initial']">
		<xsl:element name="span"> <!-- div vs. span?! -->
			<xsl:attribute name="class">initial</xsl:attribute>


			<xsl:attribute name="title">
				<xsl:text>Initiale</xsl:text>
				<xsl:if test="contains(@type,'-')">
					<xsl:text>, Typ </xsl:text>
					<xsl:value-of select="substring-after(@type, '-')"/>
				</xsl:if>
			</xsl:attribute>



<!--			<xsl:element name="span">
				<xsl:attribute name="class">initialTYP</xsl:attribute>

				<xsl:value-of select="substring-after(@type, '-')"/>
			</xsl:element>-->
			<xsl:element name="span">
				<xsl:attribute name="class">initialABC</xsl:attribute>
				<!--<xsl:value-of select="."/>-->
				
				<xsl:choose>
					<xsl:when test="@rend='red'">
						<span style="color: #b92900;">
							<xsl:apply-templates select="node()"/>
						</span>
					</xsl:when>
					<xsl:when test="@rend='default'">						
						<span style="color: black;">
							<xsl:apply-templates select="node()"/>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="node()"/>
					</xsl:otherwise>
				</xsl:choose>
				
				
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="tei:seg[@type='versalie']">
		<!-- BAUSTELLE: VERSALIEN => Gibt es bisher noch nicht?! -->
		<span class="versalie">
			<xsl:value-of select="."/>
		</span>
	</xsl:template>

	<xsl:template match="tei:cit">
		<xsl:apply-templates select="tei:quote"/>
		<xsl:apply-templates select="tei:ref"/>
	</xsl:template>

	<xsl:template match="tei:cit/tei:quote">
		<span class="quote">
			<xsl:text>&#8222;</xsl:text>
		</span>
		<xsl:apply-templates select="./node()"/>
		<span class="quote">
			<xsl:text>&#8220;</xsl:text>
		</span>

	</xsl:template>

	<xsl:template match="tei:cit/tei:ref">
		<xsl:variable name="vIndex">
			<xsl:call-template name="indexOf">
				<xsl:with-param name="pSeq" select="//tei:cit/tei:ref"/>
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>

<!--		<a href="#{generate-id()}" id="{generate-id()}-L" class="noteLink" title="{.}">
			<!-\-<sup>[<xsl:value-of select="$refIndex"/>]</sup>-\->
			<sup><xsl:value-of select="$vIndex"/><xsl:if test="$vIndex=''"><xsl:text>{NoIndex}</xsl:text></xsl:if></sup>
		</a>-->
		
		<xsl:variable name="vBezug" select="."/>
		
		<span class="annotation">
			<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="annotation-link ssdone">
				<xsl:value-of select="$vIndex"/>
				<xsl:if test="$vIndex=''">
					<xsl:text>{NoIndex}</xsl:text>
				</xsl:if>
			</a>
			<div class="annotation-content">
				<a class="ssdone" href="#{generate-id($vBezug)}">
<!--					<xsl:value-of select="$vIndex"/>
					<xsl:if test="$vIndex=''">
						<xsl:text>{NoIndex}</xsl:text>
					</xsl:if>
					<xsl:text>: </xsl:text>-->
					<xsl:call-template name="tTooltip">
						<xsl:with-param name="pNode" select="."/>
					</xsl:call-template>
				</a>
			</div>
		</span>
	</xsl:template>

	<!-- Hinzufügung durch DT am 27.08.2014, um auf externe Ressourcen wie die dMGH verlinken zu können (modifiziert durch NG am 04.09.2014: um mehrdeutige Regeln zu beseitigen => [@type] => tei:ref auf type-Attribut prüfen - Template muss möglicherweise noch ansich mit anderem ref-Template abgeglichen/angepasst werden)  -->
	<xsl:template match="tei:ref[@type]">
		<xsl:choose>
			<xsl:when test="@type='external'">
				<a>
					<xsl:attribute name="target">_blank</xsl:attribute>
					<xsl:attribute name="title">Externer Link</xsl:attribute>
					<xsl:attribute name="href">
						<xsl:value-of select="@target"/>
					</xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</xsl:when>
			<!-- mögliche andere Fälle wären Personen oder Orte - Normdaten! -->
		</xsl:choose>
	</xsl:template>
	
	
	<xsl:template match="tei:handShift">
		
		<xsl:call-template name="tFunoVerweis_alphabetisch">
			<xsl:with-param name="pBezug" select="."/>
		</xsl:call-template>
		
<!--		<!-\- Bezugsknoten -\->
		<xsl:variable name="vBezug" select="."/>
		
		<!-\- Text für Tooltip erstellen -\->
		<xsl:variable name="vFunoText">
			<xsl:call-template name="tFunoText_alphabetisch">
				<xsl:with-param name="pNode" select="$vBezug"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="vIndex">
			<xsl:call-template name="indexOf_a">
				<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
				<xsl:with-param name="pNode" select="$vBezug"/>
			</xsl:call-template>
		</xsl:variable>
		
		<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="noteLink">
			<xsl:attribute name="title">
				<xsl:call-template name="tTooltip">
					<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"/>
				</xsl:call-template>
			</xsl:attribute>
			<sup>
				<xsl:value-of select="$vIndex"/>
				<xsl:if test="$vIndex=''">
					<xsl:text>{NoIndex}</xsl:text>
				</xsl:if>
			</sup>
		</a>-->
		
	</xsl:template>
	

	<!--<xsl:template match="//tei:note[not(@type='editorial')]">-->
	<xsl:template match="tei:note[not(@type='editorial')][ancestor::tei:body]">
		<xsl:variable name="vIndex">
			<xsl:call-template name="indexOf_a">
				<!--<xsl:with-param name="pSeq" select="$funoSicNote"/>-->
				<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="vBezug" select="."/>

		<!--<a href="#{generate-id()}" id="{generate-id()}-L" class="noteLink" title="{.}">-->
<!--		<a href="#{generate-id()}" id="{generate-id()}-L" class="noteLink">
			<xsl:attribute name="title">
				<xsl:call-template name="tTooltip">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:attribute>
			<!-\-<sup>[<xsl:value-of select="$noteIndex"/>]</sup>-\->
			<sup><xsl:value-of select="$vIndex"/><xsl:if test="$vIndex=''"><xsl:text>{NoIndex}</xsl:text></xsl:if></sup>
		</a>-->
		
		<span class="annotation">
			<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="annotation-link ssdone">
				<xsl:value-of select="$vIndex"/>
				<xsl:if test="$vIndex=''">
					<xsl:text>{NoIndex}</xsl:text>
				</xsl:if>
			</a>
			<div class="annotation-content">
				<a class="ssdone" href="#{generate-id($vBezug)}">
<!--					<xsl:value-of select="$vIndex"/>
					<xsl:if test="$vIndex=''">
						<xsl:text>{NoIndex}</xsl:text>
					</xsl:if>
					<xsl:text>: </xsl:text>-->
					<xsl:call-template name="tTooltip">
						<xsl:with-param name="pNode" select="."/>
					</xsl:call-template>
				</a>
			</div>
		</span>
	</xsl:template>

	<!--<xsl:template match="//tei:note[@type='editorial'][not(@target)]">-->
	<xsl:template match="tei:note[@type='editorial'][not(@target)][ancestor::tei:body]">
		<xsl:variable name="vIndex">
			<xsl:call-template name="indexOf_a">
				<!--<xsl:with-param name="pSeq" select="$funoSicNote"/>-->
				<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="vBezug" select="."/>

		<!--<a href="#{generate-id()}" id="{generate-id()}-L" class="noteLink" title="{.}">-->
<!--		<a href="#{generate-id()}" id="{generate-id()}-L" class="noteLink">
			<xsl:attribute name="title">
				<xsl:call-template name="tTooltip">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:attribute>
			<!-\-<sup>[<xsl:value-of select="$noteIndex"/>]</sup>-\->
			<sup><xsl:value-of select="$vIndex"/><xsl:if test="$vIndex=''"><xsl:text>{NoIndex(note)}</xsl:text></xsl:if></sup>
		</a>-->
		
		<span class="annotation">
			<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="annotation-link ssdone">
				<xsl:value-of select="$vIndex"/>
				<xsl:if test="$vIndex=''">
					<xsl:text>{NoIndex}</xsl:text>
				</xsl:if>
			</a>
			<div class="annotation-content">
				<a class="ssdone" href="#{generate-id($vBezug)}">
<!--					<xsl:value-of select="$vIndex"/>
					<xsl:if test="$vIndex=''">
						<xsl:text>{NoIndex}</xsl:text>
					</xsl:if>
					<xsl:text>: </xsl:text>-->
					<xsl:call-template name="tTooltip">
						<xsl:with-param name="pNode" select="."/>
					</xsl:call-template>
				</a>
			</div>
		</span>
	</xsl:template>

<!--	<xsl:template match="//tei:note[@type='editorial'][@target]">
		<!-\- Note=“editorial“: als Fußnoten (Buchstaben) anzeigen. ??? -\->
		<!-\- als Teil von "Erstreckungsfußnote" -\->
		<xsl:variable name="noteIndex">
			<xsl:call-template name="indexOf_a">
				<xsl:with-param name="pSeq" select="$funoSicNote"/>
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="vPrecSeg" select="preceding-sibling::node()[1][name()='span'][@xml:id]"/>
		<xsl:variable name="vBezug">
			<xsl:value-of select="$vPrecSeg/text()[1]"/>
			<xsl:value-of select="$vPrecSeg/tei:add"/>
			<xsl:value-of select="substring-before($vPrecSeg/text()[last()],' ')"/>
			<xsl:text>...</xsl:text>
			<xsl:value-of select="substring-after($vPrecSeg/text()[last()],' ')"/>
			<xsl:text>: </xsl:text>
			<xsl:value-of select="."/>
		</xsl:variable>

		<a href="#{generate-id()}" id="{generate-id()}-L" class="noteLink">
			<xsl:attribute name="title">
<!-\-				<xsl:call-template name="tTooltip">
					<xsl:with-param name="pNode" select="$vBezug"/>
				</xsl:call-template>-\->
			</xsl:attribute>
			<sup>[<xsl:value-of select="$noteIndex"/>]</sup>
		</a>
	</xsl:template>-->
	<xsl:template match="tei:note[@type='editorial'][@target]">
		<!-- als Teil von "Erstreckungsfußnote" -->
		<xsl:variable name="vIndex">
			<xsl:call-template name="indexOf_a">
				<!--<xsl:with-param name="pSeq" select="$funoSicNote"/>-->
				<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="vPrecSeg" select="preceding-sibling::node()[1][name()='span'][@xml:id]"/>
		<xsl:variable name="vBezug">
			<xsl:value-of select="$vPrecSeg/text()[1]"/>
			<xsl:value-of select="$vPrecSeg/tei:add"/>
			<xsl:value-of select="substring-before($vPrecSeg/text()[last()],' ')"/>
			<xsl:text>...</xsl:text>
			<xsl:value-of select="substring-after($vPrecSeg/text()[last()],' ')"/>
			<xsl:text>: </xsl:text>
			<xsl:value-of select="."/>
		</xsl:variable>

		<a href="#{generate-id()}" id="{generate-id()}-L" class="noteLink">
			<xsl:attribute name="title">
<!--								<xsl:call-template name="tTooltip">
					<xsl:with-param name="pNode" select="$vBezug"/>
				</xsl:call-template>-->
			</xsl:attribute>
			<!--<sup>[<xsl:value-of select="$noteIndex"/>]</sup>-->
			<sup><xsl:value-of select="$vIndex"/><xsl:if test="$vIndex=''"><xsl:text>{NoIndex}</xsl:text></xsl:if></sup>
		</a>
	</xsl:template>


	<xsl:template match="tei:note[@type='comment']">
		<xsl:variable name="vIndex">
			<xsl:call-template name="indexOf_a">
				<!--<xsl:with-param name="pSeq" select="$funoSicNote"/>-->
				<xsl:with-param name="pSeq" select="$funoNumerisch"/>
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="vBezug" select="."/>

		<!--<a href="#{generate-id()}" id="{generate-id()}-L" class="noteLink" title="{.}">-->
<!--		<a href="#{generate-id()}" id="{generate-id()}-L" class="noteLink">
			<xsl:attribute name="title">
				<xsl:call-template name="tTooltip">
					<xsl:with-param name="pNode" select="."/>
				</xsl:call-template>
			</xsl:attribute>
			<sup><xsl:value-of select="$vIndex"/><xsl:if test="$vIndex=''"><xsl:text>{NoIndex}</xsl:text></xsl:if></sup>
		</a>-->
		
		<span class="annotation">
			<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="annotation-link ssdone">
				<xsl:value-of select="$vIndex"/>
				<xsl:if test="$vIndex=''">
					<xsl:text>{NoIndex}</xsl:text>
				</xsl:if>
			</a>
			<div class="annotation-content">
				<a class="ssdone" href="#{generate-id($vBezug)}">
<!--					<xsl:value-of select="$vIndex"/>
					<xsl:if test="$vIndex=''">
						<xsl:text>{NoIndex}</xsl:text>
					</xsl:if>
					<xsl:text>: </xsl:text>-->
					<xsl:call-template name="tTooltip">
						<xsl:with-param name="pNode" select="."/>
					</xsl:call-template>
				</a>
			</div>
		</span>
		
	</xsl:template>

	<xsl:template match="tei:sic">

<!--		<xsl:variable name="vNoteFolgt">
			<xsl:call-template name="tNoteFolgt">
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>

		<!-\-<xsl:value-of select="."/>-\->
		<xsl:apply-templates select="./node()"/>

		<xsl:choose>
			<xsl:when test="$vNoteFolgt='true'">
				<!-\- mit <note> -\->
				<!-\- => keine eigene Fußnote generieren -\->
			</xsl:when>
			<xsl:otherwise>
				<!-\- ohne <note> -\->
				<!-\- => Fußnote generieren -\->
				<xsl:variable name="vIndex">
					<xsl:call-template name="indexOf_a">
						<!-\-<xsl:with-param name="pSeq" select="$funoSicNote"/>-\->
						<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
						<xsl:with-param name="pNode" select="."/>
					</xsl:call-template>
				</xsl:variable>

				<!-\-<xsl:apply-templates select="node()"/> <!-\\- Beobachten: Könnte problematisch sein?! -\\->-\->
				<a href="#{generate-id()}" id="{generate-id()}-L" class="noteLink" title="Sic Hs.">
					<!-\-<sup>[<xsl:value-of select="$sicIndex"/>]</sup>-\->
					<sup><xsl:value-of select="$vIndex"/><xsl:if test="$vIndex=''"><xsl:text>{NoIndex}</xsl:text></xsl:if></sup>
				</a>
			</xsl:otherwise>
		</xsl:choose>-->

		<xsl:variable name="vNoteFolgt">
			<xsl:call-template name="tNoteFolgt">
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>
		
		<!--<xsl:value-of select="."/>-->
		<xsl:apply-templates select="./node()"/>
		<xsl:text> [!]</xsl:text>
		
<!--		<xsl:choose>
			<xsl:when test="$vNoteFolgt='true'">
				<!-\- mit <note> -\->
				<!-\- => keine eigene Fußnote generieren -\->
			</xsl:when>
			<xsl:otherwise>
				<!-\- ohne <note> -\->
				<!-\- => Fußnote generieren -\->
				<xsl:variable name="vIndex">
					<xsl:call-template name="indexOf_a">
						<!-\-<xsl:with-param name="pSeq" select="$funoSicNote"/>-\->
						<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
						<xsl:with-param name="pNode" select="."/>
					</xsl:call-template>
				</xsl:variable>
				
				<!-\-<xsl:apply-templates select="node()"/> <!-\\- Beobachten: Könnte problematisch sein?! -\\->-\->
				<a href="#{generate-id()}" id="{generate-id()}-L" class="noteLink" title="Sic Hs.">
					<!-\-<sup>[<xsl:value-of select="$sicIndex"/>]</sup>-\->
					<sup><xsl:value-of select="$vIndex"/><xsl:if test="$vIndex=''"><xsl:text>{NoIndex}</xsl:text></xsl:if></sup>
				</a>
			</xsl:otherwise>
		</xsl:choose>-->

	</xsl:template>

	<!--

	10.06.2015 => alle Veränderungen an text() deaktivieren => kein Textverlust!

	<!-\-11.12.2014TESTWEISE<xsl:template match="//text()[preceding-sibling::*[1][local-name(.)='subst' or local-name(.)='mod' or local-name(.)='add' or local-name(.)='del']]">-\->
	<!-\-<xsl:template match="//text()[preceding-sibling::node()[not(local-name(.)='metamark' or local-name(.)='lb')][1][local-name(.)='subst' or local-name(.)='mod' or local-name(.)='add' or local-name(.)='del']]"> 16.04.2015 -\->
		<xsl:template match="//text()[preceding-sibling::node()[not(local-name(.)='metamark' or local-name(.)='lb')][1][local-name(.)='subst' or local-name(.)='mod' or local-name(.)='add']]">
		<!-\-<xsl:template match="//text()[preceding-sibling::node()[not(local-name(.)='metamark' or local-name(.)='lb')][1][local-name(.)='subst' or local-name(.)='mod' or local-name(.)='add' or local-name(.)='del']][not(local-name(parent::*/parent::*)='choice')]">-\->
		<!-\- Text NACH subst/mod/add -\->
		<!-\- behandelt gegebenenfalls auch nachfolgende Wortzusammenfügungen -\->

		<!-\-<xsl:text>{StrNachSubstAddMod}</xsl:text> <!-\\- TESTWEISE -\\->-\->

		<!-\-<xsl:text>{TextNachEle}</xsl:text>-\->

		<xsl:variable name="vMitNote">
			<xsl:call-template name="tNoteFolgt">
				<!-\-<xsl:with-param name="pNode" select="./preceding-sibling::*[1]"/>-\->
				<xsl:with-param name="pNode" select="./preceding-sibling::node()[not(local-name(.)='metamark' or local-name(.)='lb')][1]"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$vMitNote='true'">
				<!-\- mit <note> -\->

				<!-\- => Verweis auf Fußnote erfolgt durch <note> -\->
				<!-\- => Unterstellung: <note> steht an der richtigen Stelle -\->
				<!-\-<xsl:apply-templates/>-\->

				<xsl:value-of select="."/>
			</xsl:when>
			<xsl:otherwise>
				<!-\- ohne <note> -\->

				<xsl:choose>
					<xsl:when test="substring(.,1,1)=' '">
						<!-\- wenn erstes Zeichen ein Leerzeichen -\->
						<!-\- text() beinhaltet kein Wortende am Anfang! -\->
						<!-\-<xsl:text>{Leerz.}</xsl:text>-\->

						<xsl:value-of select="."/>
					</xsl:when>
					<xsl:otherwise>
						<!-\- text() enthält Wortende am Anfang! -\->
						<!-\-<xsl:text>{Wortende}</xsl:text>-\->

						<!-\- => Verweis nach Wort setzen -\->

<!-\-						<xsl:variable name="vText">
							<xsl:choose>
								<xsl:when test="string-length(translate(.,' ',''))!=string-length(.)">
									<!-\\- Leerzeichen in "erstem"/diesem text() -\\->
									<xsl:value-of select="."/>
								</xsl:when>
								<xsl:otherwise>
									<!-\\- Leerzeichen folgt irgendwann -\\->
									<xsl:value-of select="concat(.,./following-sibling::text())"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>

						<xsl:variable name="vWortteil" select="substring-before($vText,' ')" /> 19.03.2015-\->
						<xsl:variable name="vWortteil">
							<xsl:call-template name="tFollowingWortteil">
								<xsl:with-param name="pFollowingTextThis" select="./preceding::*[1]"/>
								<xsl:with-param name="pFollowingTextBeforeNode" select="''"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="vStringNachWortteil">
							<!-\- Substring vWortteil aus gesamtem nachfoglenden Text entfernen -\->
							<xsl:value-of select="substring(.,1+string-length($vWortteil))"/>
						</xsl:variable>

						<!-\-<xsl:text>{$vWortteil}</xsl:text> <!-\\- TESTWEISE -\\->-\->
						<xsl:value-of select="$vWortteil"/>
						<!-\-<xsl:text>{/$vWortteil}</xsl:text> <!-\\- TESTWEISE -\\->-\->

						<!-\-<xsl:text>{VerweisFuno}</xsl:text> <!-\\- TESTWEISE -\\->-\->

						<!-\- "Bezugsknoten" -\->
						<!-\-<xsl:variable name="vPrecSib1" select="preceding-sibling::*[1]"/>-\->
						<xsl:variable name="vPrecSib1" select="./preceding-sibling::node()[not(local-name(.)='metamark' or local-name(.)='lb')][1]"/>

						<!-\- Text für Tooltip erstellen -\->
						<xsl:variable name="vFunoText">
							<xsl:call-template name="tFunoText_alphabetisch">
								<xsl:with-param name="pNode" select="$vPrecSib1"/>
							</xsl:call-template>
						</xsl:variable>

						<xsl:variable name="vIndex">
							<xsl:call-template name="indexOf_a">
								<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
								<xsl:with-param name="pNode" select="$vPrecSib1"/>
							</xsl:call-template>
						</xsl:variable>

						<!-\-<a href="#{generate-id()}" id="{generate-id()}-L" class="noteLink">-\->
						<a href="#{generate-id($vPrecSib1)}" id="{generate-id($vPrecSib1)}-L" class="noteLink">
							<xsl:attribute name="title">
								<xsl:call-template name="tTooltip">
									<!-\-<xsl:with-param name="pNode" select="./preceding-sibling::*[1]"/>-\->
									<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"/>
								</xsl:call-template>
							</xsl:attribute>
							<sup><xsl:value-of select="$vIndex"/><xsl:if test="$vIndex=''"><xsl:text>{NoIndex}</xsl:text></xsl:if></sup>
						</a>
						<!-\-<xsl:text>{/VerweisFuno}</xsl:text> <!-\\- TESTWEISE -\\->-\->

						<!-\-<xsl:text>{$vStringNachWortteil}</xsl:text> <!-\\- TESTWEISE -\\->-\->
						<xsl:value-of select="$vStringNachWortteil"/>
						<!-\-<xsl:text>{/$vStringNachWortteil}</xsl:text> <!-\\- TESTWEISE -\\->-\->
					</xsl:otherwise>
				</xsl:choose>


			</xsl:otherwise>
		</xsl:choose>

		<!-\-<xsl:text>{/StrNachSubstAddMod}</xsl:text> <!-\\- TESTWEISE -\\->-\->
	</xsl:template>-->

	<!-- <subst> -->

	<xsl:template match="tei:subst">

		<xsl:variable name="vNoteFolgt">
			<xsl:call-template name="tNoteFolgt">
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>

		<!-- Bezugsknoten -->
		<xsl:variable name="vBezug" select="."/>

		<!-- Text für Tooltip erstellen -->
		<xsl:variable name="vFunoText">
			<xsl:call-template name="tFunoText_alphabetisch">
				<xsl:with-param name="pNode" select="$vBezug"/>
			</xsl:call-template>
		</xsl:variable>

		<!-- Position ermitteln -->
		<xsl:variable name="vIndex">
			<xsl:call-template name="indexOf_a">
				<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
				<xsl:with-param name="pNode" select="$vBezug"/>
			</xsl:call-template>
		</xsl:variable>

		<!-- Variablen/Mengen für Hand A-W bzw. Hand X-Z -->
		<xsl:variable name="vHandABC" select="'ABCDEFGHIJKLMNOPQRSTUVW'"/>
		<xsl:variable name="vHandXYZ" select="'XYZ'"/>

		<!--<span class="debug"><xsl:text>{subst}</xsl:text></span>-->

		<xsl:choose>
			<xsl:when test="not(tei:add/@hand)">
				<!-- keine Hand -->
				<xsl:apply-templates select="tei:add"/>
			</xsl:when>
			<xsl:when test="string-length(tei:add/@hand)!=string-length(translate(tei:add/@hand,$vHandABC,''))">
				<!-- entspricht "normaler" Hand -->
				<xsl:apply-templates select="tei:add"/>
			</xsl:when>
			<xsl:when test="string-length(tei:add/@hand)!=string-length(translate(tei:add/@hand,$vHandXYZ,''))">
				<!-- entspricht "spezieller" Hand -->
				<xsl:apply-templates select="tei:del"/>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="$vNoteFolgt='true'">
				<!-- nachfolgende <note> setzt Fußnotenverweis -->

				<xsl:if test="string-length(@hand)!=string-length(translate(@hand,$vHandXYZ,''))">
					<xsl:apply-templates select="tei:del"/>
				</xsl:if>

			</xsl:when>
			<xsl:otherwise>
<!--				<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="noteLink">
					<xsl:attribute name="title">
						<xsl:call-template name="tTooltip">
							<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"/>
						</xsl:call-template>
					</xsl:attribute>
					<sup>
						<xsl:value-of select="$vIndex"/>
						<xsl:if test="$vIndex=''">
							<xsl:text>{NoIndex}</xsl:text>
						</xsl:if>
					</sup>
				</a>-->
				
				<xsl:call-template name="tFunoVerweis_alphabetisch">
					<xsl:with-param name="pBezug" select="$vBezug"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template match="tei:add[parent::tei:subst]">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="tei:del[parent::tei:subst]">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- </subst> -->

	<!-- <add> -->

	<xsl:template match="tei:add[not(parent::*[local-name(.)='subst'] and not(parent::*[local-name(.)='num']))]">
		<!--<xsl:text>{add-oP}</xsl:text> <!-\- TESTWEISE -\->-->

		<xsl:variable name="vNoteFolgt">
			<!-- ermittelt, ob eine <note> angehängt ist -->
			<xsl:call-template name="tNoteFolgt">
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="vLeerzeichenDavor">
			<!-- Leerzeichen vor Element? -->
			<xsl:call-template name="tLeerzeichenDavor">
				<xsl:with-param name="pNode" select="current()"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="vLeerzeichenDanach">
			<!-- Leerzeichen nach Element? -->
			<xsl:call-template name="tLeerzeichenDanach">
				<xsl:with-param name="pNode" select="current()"/>
			</xsl:call-template>
		</xsl:variable>

		<!-- Bezugsknoten -->
		<xsl:variable name="vBezug" select="."/>

		<!-- Text für Tooltip erstellen -->
		<xsl:variable name="vFunoText">
			<xsl:call-template name="tFunoText_alphabetisch">
				<xsl:with-param name="pNode" select="$vBezug"/>
			</xsl:call-template>
		</xsl:variable>

		<!-- Position ermitteln -->
		<xsl:variable name="vIndex">
			<xsl:call-template name="indexOf_a">
				<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
				<xsl:with-param name="pNode" select="$vBezug"/>
			</xsl:call-template>
		</xsl:variable>

		<!-- Variablen/Mengen für Hand A-W bzw. Hand X-Z -->
		<xsl:variable name="vHandABC" select="'ABCDEFGHIJKLMNOPQRSTUVW'"/>
		<xsl:variable name="vHandXYZ" select="'XYZ'"/>

		<xsl:choose>
			<xsl:when test="$vNoteFolgt='true'">
				<!-- <note> folgt => Fußnote wird bereits gesetzt -->


				<xsl:if test="not(string-length(@hand)!=string-length(translate(@hand,$vHandXYZ,'')))">
					<xsl:apply-templates select="node()"/>
				</xsl:if>


				<!--<span class="debug"><xsl:text>{!funoFolgt!}</xsl:text></span> <!-\- TESTWEISE -\->-->

			</xsl:when>
			<xsl:otherwise>
				<!-- es folgt keine <note> = automatische Fußnote wird generiert -->

				<xsl:choose>
					<xsl:when test="not(@hand)">
						<!-- keine Hand -->

						<xsl:choose>
							<xsl:when test="$vLeerzeichenDavor='false' and $vLeerzeichenDanach='false'">
								<!-- befindet sich in Wort (kein Leerzeichen davor und kein Leerzeichen danach -->

								<xsl:apply-templates select="./node()"/>

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='false'">
								<!-- befindet sich am Wortanfang (Leerzeichen davor) -->

								<xsl:apply-templates select="./node()"/>

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='false' and $vLeerzeichenDanach='true'">
								<!-- befindet sich am Wortende (Leerzeichen danach) -->

								<xsl:apply-templates select="./node()"/>

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='true'">
								<!-- steht alleine (Leerzeichen davor und Leerzeichen danach) -->

								<xsl:apply-templates select="./node()"/>

							</xsl:when>
							<xsl:otherwise>
								<span class="debug">
									<xsl:text>{TEST-add-FEHLER-hand0-lz:</xsl:text>
									<xsl:text>$vLeerzeichenDavor=</xsl:text><xsl:value-of select="$vLeerzeichenDavor"/>
									<xsl:text>|</xsl:text>
									<xsl:text>$vLeerzeichenDanach=</xsl:text><xsl:value-of select="$vLeerzeichenDanach"/>
									<xsl:text>###</xsl:text>
									<xsl:value-of select="preceding-sibling::text()[1]"/>
									<xsl:text>|</xsl:text>
									<xsl:value-of select="following-sibling::text()[1]"/>
									<xsl:text>}</xsl:text>
								</span>
							</xsl:otherwise>
						</xsl:choose>
						
						<xsl:call-template name="tFunoVerweis_alphabetisch">
							<xsl:with-param name="pBezug" select="$vBezug"/>
						</xsl:call-template>

<!--						<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L"
							class="noteLink">
							<xsl:attribute name="title">
								<xsl:call-template name="tTooltip">
									<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"
									/>
								</xsl:call-template>
							</xsl:attribute>
							<sup>
								<xsl:value-of select="$vIndex"/>
								<xsl:if test="$vIndex=''">
									<xsl:text>{NoIndex}</xsl:text>
								</xsl:if>
							</sup>
						</a>-->

					</xsl:when>
					<xsl:when test="string-length(@hand)!=string-length(translate(@hand,$vHandABC,''))">
						<!-- entspricht "normaler" Hand -->

						<xsl:choose>
							<xsl:when test="$vLeerzeichenDavor='false' and $vLeerzeichenDanach='false'">
								<!-- befindet sich in Wort (kein Leerzeichen davor und kein Leerzeichen danach -->

								<xsl:apply-templates select="./node()"/>

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='false'">
								<!-- befindet sich am Wortanfang (Leerzeichen davor) -->

								<xsl:apply-templates select="./node()"/>

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='false' and $vLeerzeichenDanach='true'">
								<!-- befindet sich am Wortende (Leerzeichen danach) -->

								<xsl:apply-templates select="./node()"/>

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='true'">
								<!-- steht alleine (Leerzeichen davor und Leerzeichen danach) -->

								<xsl:apply-templates select="./node()"/>

							</xsl:when>
							<xsl:otherwise>
								<span class="debug"><xsl:text>{TEST-add-FEHLER-handABC-lz}</xsl:text></span>
							</xsl:otherwise>
						</xsl:choose>
						
						<xsl:call-template name="tFunoVerweis_alphabetisch">
							<xsl:with-param name="pBezug" select="$vBezug"/>
						</xsl:call-template>

<!--						<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L"
							class="noteLink">
							<xsl:attribute name="title">
								<xsl:call-template name="tTooltip">
									<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"
									/>
								</xsl:call-template>
							</xsl:attribute>
							<sup>
								<xsl:value-of select="$vIndex"/>
								<xsl:if test="$vIndex=''">
									<xsl:text>{NoIndex}</xsl:text>
								</xsl:if>
							</sup>
						</a>-->

					</xsl:when>
					<xsl:when test="string-length(@hand)!=string-length(translate(@hand,$vHandXYZ,''))">
						<!-- entspricht "spezieller" Hand -->

						<xsl:choose>
							<xsl:when test="$vLeerzeichenDavor='false' and $vLeerzeichenDanach='false'">
								<!-- befindet sich in Wort (kein Leerzeichen davor und kein Leerzeichen danach -->

								<!--<xsl:apply-templates select="./node()"/>-->

								<xsl:call-template name="tFunoVerweis_alphabetisch">
									<xsl:with-param name="pBezug" select="$vBezug"/>
								</xsl:call-template>

<!--								<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L"
									class="noteLink">
									<xsl:attribute name="title">
										<xsl:call-template name="tTooltip">
											<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"
											/>
										</xsl:call-template>
									</xsl:attribute>
									<sup>
										<xsl:value-of select="$vIndex"/>
										<xsl:if test="$vIndex=''">
											<xsl:text>{NoIndex}</xsl:text>
										</xsl:if>
									</sup>
								</a>-->

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='false'">
								<!-- befindet sich am Wortanfang (Leerzeichen davor) -->

								<!--<xsl:apply-templates select="./node()"/>-->
								
								
								<xsl:call-template name="tFunoVerweis_alphabetisch">
									<xsl:with-param name="pBezug" select="$vBezug"/>
								</xsl:call-template>

<!--								<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L"
									class="noteLink">
									<xsl:attribute name="title">
										<xsl:call-template name="tTooltip">
											<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"
											/>
										</xsl:call-template>
									</xsl:attribute>
									<sup>
										<xsl:value-of select="$vIndex"/>
										<xsl:if test="$vIndex=''">
											<xsl:text>{NoIndex}</xsl:text>
										</xsl:if>
									</sup>
								</a>-->

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='false' and $vLeerzeichenDanach='true'">
								<!-- befindet sich am Wortende (Leerzeichen danach) -->
								
								<xsl:call-template name="tFunoVerweis_alphabetisch">
									<xsl:with-param name="pBezug" select="$vBezug"/>
								</xsl:call-template>

<!--								<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L"
									class="noteLink">
									<xsl:attribute name="title">
										<xsl:call-template name="tTooltip">
											<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"
											/>
										</xsl:call-template>
									</xsl:attribute>
									<sup>
										<xsl:value-of select="$vIndex"/>
										<xsl:if test="$vIndex=''">
											<xsl:text>{NoIndex}</xsl:text>
										</xsl:if>
									</sup>
								</a>-->

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='true'">
								<!-- steht alleine (Leerzeichen davor und Leerzeichen danach) -->
								
								<xsl:call-template name="tFunoVerweis_alphabetisch">
									<xsl:with-param name="pBezug" select="$vBezug"/>
								</xsl:call-template>

<!--								<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L"
									class="noteLink">
									<xsl:attribute name="title">
										<xsl:call-template name="tTooltip">
											<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"
											/>
										</xsl:call-template>
									</xsl:attribute>
									<sup>
										<xsl:value-of select="$vIndex"/>
										<xsl:if test="$vIndex=''">
											<xsl:text>{NoIndex}</xsl:text>
										</xsl:if>
									</sup>
								</a>-->
							</xsl:when>
							<xsl:otherwise>
								<span class="debug"><xsl:text>{TEST-add-FEHLER-handXYZ-lz}</xsl:text></span>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:when>
					<xsl:otherwise>
						<span class="debug"><xsl:text>{TEST-add-FEHLER-hand?}</xsl:text></span>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!-- </add> -->

	<!-- <mod> -->

	<xsl:template match="tei:mod">
		<!--<xsl:text>{mod}</xsl:text> <!-\- TESTWEISE -\->-->

		<xsl:variable name="vNoteFolgt">
			<xsl:call-template name="tNoteFolgt">
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>

		<!-- Bezugsknoten -->
		<xsl:variable name="vBezug" select="."/>

		<!-- Text für Tooltip erstellen -->
		<xsl:variable name="vFunoText">
			<xsl:call-template name="tFunoText_alphabetisch">
				<xsl:with-param name="pNode" select="$vBezug"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="vIndex">
			<xsl:call-template name="indexOf_a">
				<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
				<xsl:with-param name="pNode" select="$vBezug"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:apply-templates select="node()"/>

		<xsl:if test="$vNoteFolgt='false'">
<!--			<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="noteLink">
				<xsl:attribute name="title">
					<xsl:call-template name="tTooltip">
						<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"/>
					</xsl:call-template>
				</xsl:attribute>
				<sup>
					<xsl:value-of select="$vIndex"/>
					<xsl:if test="$vIndex=''">
						<xsl:text>{NoIndex}</xsl:text>
					</xsl:if>
				</sup>
			</a>-->
			
			<xsl:call-template name="tFunoVerweis_alphabetisch">
				<xsl:with-param name="pBezug" select="$vBezug"/>
			</xsl:call-template>
		</xsl:if>

	</xsl:template>

	<!-- </mod> -->


	<xsl:template match="tei:num">
		<!--<xsl:text>{ab_num}</xsl:text> <!-\- TESTWEISE -\->-->
<!--		<xsl:value-of select="text()"/>
		<xsl:apply-templates select="tei:add"/>-->
		<xsl:apply-templates select="current()/node()"/>
		<!--<xsl:text>{/ab_num}</xsl:text> <!-\- TESTWEISE -\->-->
	</xsl:template>
	<xsl:template match="tei:num/tei:hi[@rend='super']">
		<super>
			<xsl:apply-templates select="current()/node()"/>
		</super>
	</xsl:template>

<!--	<xsl:template match="//tei:num/tei:add">
		<!-\-<xsl:text>{ab_num_add}</xsl:text> <!-\\- TESTWEISE -\\->-\->
		<!-\-<sup>-\->
			<!-\-<xsl:value-of select="."/>-\->
			<xsl:apply-templates select="current()/node()"/>
		<!-\-</sup>-\->
		<!-\-<xsl:text>{/ab_num_add}</xsl:text> <!-\\- TESTWEISE -\\->-\->
	</xsl:template>-->

<!--	<xsl:template match="//tei:add[not(parent::*[local-name(.)='subst']) and not(parent::*[local-name(.)='num'])]/text()">
		<!-\-<xsl:text>{add-text}</xsl:text> <!-\\- TESTWEISE -\\->-\->
		<xsl:value-of select="."/>
		<!-\-<xsl:text>{/add-text}</xsl:text> <!-\\- TESTWEISE -\\->-\->
	</xsl:template>-->

	<xsl:template match="tei:del[not(parent::*[local-name(.)='subst'])]">

		<xsl:variable name="vNoteFolgt">
			<xsl:call-template name="tNoteFolgt">
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>

		<!-- Variablen/Mengen für Hand A-W bzw. Hand X-Z -->
		<xsl:variable name="vHandABC" select="'ABCDEFGHIJKLMNOPQRSTUVW'"/>
		<xsl:variable name="vHandXYZ" select="'XYZ'"/>


		<!-- TESTWEISE -->
		<xsl:if test="current()='h'">
			<xsl:variable name="test" select="''"></xsl:variable>
		</xsl:if>


		<xsl:choose>
			<xsl:when test="count(./node())=0">
				<!-- Sonderfall bei <del>:  leeres Element -->
				<!-- Bezugsknoten -->

				<xsl:call-template name="tPrintXtimes">
					<xsl:with-param name="pPrintWhat" select="'+'"/>
					<xsl:with-param name="pPrintHowManyTimes" select="current()/@quantity"/>
				</xsl:call-template>

			</xsl:when>
			<xsl:when test="$vNoteFolgt='true'">
				<!-- Note folgt => Fußnote wird darüber erzeugt -->


				<xsl:if test="string-length(@hand)!=string-length(translate(@hand,$vHandXYZ,''))">
					<xsl:apply-templates select="node()"/>
				</xsl:if>

			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="not(@hand)">
						<!-- ohne Hand -->


						<xsl:choose>
							<xsl:when test="count(current()/preceding-sibling::node())=0">
								<xsl:text>#</xsl:text>
							</xsl:when>
							<xsl:when test="count(current()/preceding-sibling::*)>0">

							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="normalize-space(current()/preceding-sibling::node())=''">
									<xsl:text>#</xsl:text>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>

						<!-- Bezugsknoten -->
						<xsl:variable name="vBezug" select="."/>

						<!-- Text für Tooltip erstellen -->
						<xsl:variable name="vFunoText">
							<xsl:call-template name="tFunoText_alphabetisch">
								<xsl:with-param name="pNode" select="$vBezug"/>
							</xsl:call-template>
						</xsl:variable>

						<xsl:variable name="vIndex">
							<xsl:call-template name="indexOf_a">
								<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
								<xsl:with-param name="pNode" select="$vBezug"/>
							</xsl:call-template>
						</xsl:variable>
						
						<xsl:call-template name="tFunoVerweis_alphabetisch">
							<xsl:with-param name="pBezug" select="$vBezug"/>
						</xsl:call-template>

<!--						<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="noteLink">
							<xsl:attribute name="title">
								<xsl:call-template name="tTooltip">
									<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"/>
								</xsl:call-template>
							</xsl:attribute>
							<sup>
								<xsl:value-of select="$vIndex"/>
								<xsl:if test="$vIndex=''">
									<xsl:text>{NoIndex}</xsl:text>
								</xsl:if>
							</sup>
						</a>-->

					</xsl:when>
					<xsl:when test="string-length(@hand)!=string-length(translate(@hand,$vHandABC,''))">
						<!-- normale Hand -->


						<xsl:choose>
							<xsl:when test="count(current()/preceding-sibling::node())=0">
								<xsl:text>#</xsl:text>
							</xsl:when>
							<xsl:when test="count(current()/preceding-sibling::*)>0">

							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="normalize-space(current()/preceding-sibling::node())=''">
									<xsl:text>#</xsl:text>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>

						<!-- Bezugsknoten -->
						<xsl:variable name="vBezug" select="."/>

						<!-- Text für Tooltip erstellen -->
						<xsl:variable name="vFunoText">
							<xsl:call-template name="tFunoText_alphabetisch">
								<xsl:with-param name="pNode" select="$vBezug"/>
							</xsl:call-template>
						</xsl:variable>

						<xsl:variable name="vIndex">
							<xsl:call-template name="indexOf_a">
								<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
								<xsl:with-param name="pNode" select="$vBezug"/>
							</xsl:call-template>
						</xsl:variable>
						
						<xsl:call-template name="tFunoVerweis_alphabetisch">
							<xsl:with-param name="pBezug" select="$vBezug"/>
						</xsl:call-template>

<!--						<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="noteLink">
							<xsl:attribute name="title">
								<xsl:call-template name="tTooltip">
									<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"/>
								</xsl:call-template>
							</xsl:attribute>
							<sup>
								<xsl:value-of select="$vIndex"/>
								<xsl:if test="$vIndex=''">
									<xsl:text>{NoIndex}</xsl:text>
								</xsl:if>
							</sup>
						</a>-->

					</xsl:when>
					<xsl:when test="string-length(@hand)!=string-length(translate(@hand,$vHandXYZ,''))">
						<!-- spezielle Hand -->
						<xsl:apply-templates select="current()/node()"/>

						<!-- Bezugsknoten -->
						<xsl:variable name="vBezug" select="."/>

						<!-- Text für Tooltip erstellen -->
						<xsl:variable name="vFunoText">
							<xsl:call-template name="tFunoText_alphabetisch">
								<xsl:with-param name="pNode" select="$vBezug"/>
							</xsl:call-template>
						</xsl:variable>

						<xsl:variable name="vIndex">
							<xsl:call-template name="indexOf_a">
								<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
								<xsl:with-param name="pNode" select="$vBezug"/>
							</xsl:call-template>
						</xsl:variable>
						
						<xsl:call-template name="tFunoVerweis_alphabetisch">
							<xsl:with-param name="pBezug" select="$vBezug"/>
						</xsl:call-template>

<!--						<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="noteLink">
							<xsl:attribute name="title">
								<xsl:call-template name="tTooltip">
									<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"/>
								</xsl:call-template>
							</xsl:attribute>
							<sup>
								<xsl:value-of select="$vIndex"/>
								<xsl:if test="$vIndex=''">
									<xsl:text>{NoIndex}</xsl:text>
								</xsl:if>
							</sup>
						</a>-->

					</xsl:when>
					<xsl:otherwise>
						<span class="debug"><xsl:text>{FEHLER in del}</xsl:text></span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>

		<!--

		<xsl:choose>
			<xsl:when test="count(./node())=0">
				<!-\- Sonderfall bei <del>:  leeres Element -\->
				<!-\- Bezugsknoten -\->

				<xsl:call-template name="tPrintXtimes">
					<xsl:with-param name="pPrintWhat" select="'+'"/>
					<xsl:with-param name="pPrintHowManyTimes" select="current()/@quantity"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="count(following-sibling::node())=0">
				<!-\- wenn kein Element oder text() nachfolgt -\->

				<!-\- Bezugsknoten -\->
				<xsl:variable name="vBezug" select="."/>

				<!-\- Text für Tooltip erstellen -\->
				<xsl:variable name="vFunoText">
					<xsl:call-template name="tFunoText_alphabetisch">
						<xsl:with-param name="pNode" select="$vBezug"/>
					</xsl:call-template>
				</xsl:variable>

				<xsl:variable name="vIndex">
					<xsl:call-template name="indexOf_a">
						<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
						<xsl:with-param name="pNode" select="$vBezug"/>
					</xsl:call-template>
				</xsl:variable>

				<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="noteLink">
					<xsl:attribute name="title">
						<xsl:call-template name="tTooltip">
							<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"/>
						</xsl:call-template>
					</xsl:attribute>
					<sup>
						<xsl:value-of select="$vIndex"/>
						<xsl:if test="$vIndex=''">
							<xsl:text>{NoIndex}</xsl:text>
						</xsl:if>
					</sup>
				</a>
			</xsl:when>
<!-\-			<xsl:when
				test="(following-sibling::node()[1]=following-sibling::text()[1]) and (substring(following-sibling::node()[1],1,1)!=' ')">



			</xsl:when>-\->
			<xsl:otherwise>
				<!-\- wenn ein node() nachfolgt -\->

				<xsl:choose>
					<xsl:when test="$vNoteFolgt='true'">
						<!-\- mit <note> -\->
					</xsl:when>
					<xsl:otherwise>
						<!-\- ohne <note> -\->

						<!-\- Wort vollständig -\->
						<!-\- Bezugsknoten -\->
						<xsl:variable name="vBezug" select="."/>

						<!-\- Text für Tooltip erstellen -\->
						<xsl:variable name="vFunoText">
							<xsl:call-template name="tFunoText_alphabetisch">
								<xsl:with-param name="pNode" select="$vBezug"/>
							</xsl:call-template>
						</xsl:variable>

						<xsl:variable name="vIndex">
							<xsl:call-template name="indexOf_a">
								<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
								<xsl:with-param name="pNode" select="$vBezug"/>
							</xsl:call-template>
						</xsl:variable>

						<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L"
							class="noteLink">
							<xsl:attribute name="title">
								<xsl:call-template name="tTooltip">
									<xsl:with-param name="pNode"
										select="exslt:node-set($vFunoText)"/>
								</xsl:call-template>
							</xsl:attribute>
							<sup>
								<xsl:value-of select="$vIndex"/>
								<xsl:if test="$vIndex=''">
									<xsl:text>{NoIndex}</xsl:text>
								</xsl:if>
							</sup>
						</a>

						<!-\-

												<xsl:variable name="vLeerzeichenFolgt">
							<xsl:call-template name="tLeerzeichenDanach">
								<xsl:with-param name="pNode" select="."/>
							</xsl:call-template>
						</xsl:variable>

						<xsl:choose>
							<xsl:when test="$vLeerzeichenFolgt='false'">
								<!-\\- Wortende folgt in nächstem nachfolgenden Text -\\->
								<!-\\-<xsl:text>{unv.}</xsl:text>-\\->



							</xsl:when>
							<xsl:otherwise>
								<!-\\- Wort vollständig -\\->
								<!-\\- Bezugsknoten -\\->
								<xsl:variable name="vBezug" select="."/>

								<!-\\- Text für Tooltip erstellen -\\->
								<xsl:variable name="vFunoText">
									<xsl:call-template name="tFunoText_alphabetisch">
										<xsl:with-param name="pNode" select="$vBezug"/>
									</xsl:call-template>
								</xsl:variable>

								<xsl:variable name="vIndex">
									<xsl:call-template name="indexOf_a">
										<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
										<xsl:with-param name="pNode" select="$vBezug"/>
									</xsl:call-template>
								</xsl:variable>

								<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L"
									class="noteLink">
									<xsl:attribute name="title">
										<xsl:call-template name="tTooltip">
											<xsl:with-param name="pNode"
												select="exslt:node-set($vFunoText)"/>
										</xsl:call-template>
									</xsl:attribute>
									<sup>
										<xsl:value-of select="$vIndex"/>
										<xsl:if test="$vIndex=''">
											<xsl:text>{NoIndex}</xsl:text>
										</xsl:if>
									</sup>
								</a>
							</xsl:otherwise>
						</xsl:choose>-\->
					</xsl:otherwise>
				</xsl:choose>

			</xsl:otherwise>
		</xsl:choose>
		-->
	</xsl:template>
	
	<xsl:template match="tei:abbr">
		<xsl:apply-templates select="node()"/>
	</xsl:template>

	<xsl:template match="tei:choice">

<!--		<span title="{./tei:abbr/text()}">
			<!-\-<xsl:value-of select="./tei:expan/text()"/>-\->
			<xsl:apply-templates select="./tei:expan/node()"/>
			<xsl:text> (</xsl:text>
			<!-\-<xsl:value-of select="./tei:abbr/text()"/>-\->
			<xsl:apply-templates select="./tei:abbr/node()"/>
			<xsl:text>.)</xsl:text>
		</span>-->
		
<!--		<span title="gek. {./tei:abbr/node()}" style="">
			<!-\-<xsl:value-of select="./tei:expan/text()"/>-\->
			<xsl:apply-templates select="./tei:expan/node()"/>
<!-\-			<xsl:text> (</xsl:text>
			<!-\\-<xsl:value-of select="./tei:abbr/text()"/>-\\->
			<xsl:apply-templates select="./tei:abbr/node()"/>
			<xsl:text>.)</xsl:text>-\->
		</span>-->
		
		
		<xsl:apply-templates select="./tei:expan/node()"/>
		
		<!-- Bezugsknoten -->
		<xsl:variable name="vBezug" select="."/>
		
<!--		<!-\- Text für Tooltip erstellen -\->
		<xsl:variable name="vFunoText">
			<xsl:call-template name="tFunoText_alphabetisch">
				<xsl:with-param name="pNode" select="$vBezug"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="vIndex">
			<xsl:call-template name="indexOf_a">
				<!-\-<xsl:with-param name="pSeq" select="$funoSicNote"/>-\->
				<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
				<xsl:with-param name="pNode" select="$vBezug"/>
			</xsl:call-template>
		</xsl:variable>-->
		
		<xsl:call-template name="tFunoVerweis_alphabetisch">
			<xsl:with-param name="pBezug" select="$vBezug"/>
		</xsl:call-template>
		
<!--		<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="noteLink">
			<xsl:attribute name="title">
				<xsl:call-template name="tTooltip">
					<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"/>
				</xsl:call-template>
			</xsl:attribute>
			<sup><xsl:value-of select="$vIndex"/><xsl:if test="$vIndex=''"><xsl:text>{NoIndex}</xsl:text></xsl:if></sup>
		</a>-->
		
	</xsl:template>

	<xsl:template match="tei:unclear[count(tei:gap)>0]">
		<xsl:text>...</xsl:text>


		<!-- Bezugsknoten -->
		<xsl:variable name="vBezug" select="."/>

		<!-- Text für Tooltip erstellen -->
		<xsl:variable name="vFunoText">
			<xsl:call-template name="tFunoText_alphabetisch">
				<xsl:with-param name="pNode" select="$vBezug"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="vIndex">
			<xsl:call-template name="indexOf_a">
				<!--<xsl:with-param name="pSeq" select="$funoSicNote"/>-->
				<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
				<xsl:with-param name="pNode" select="$vBezug"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:call-template name="tFunoVerweis_alphabetisch">
			<xsl:with-param name="pBezug" select="$vBezug"/>
		</xsl:call-template>

<!--		<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="noteLink">
			<xsl:attribute name="title">
				<xsl:call-template name="tTooltip">
					<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"/>
				</xsl:call-template>
			</xsl:attribute>
			<sup><xsl:value-of select="$vIndex"/><xsl:if test="$vIndex=''"><xsl:text>{NoIndex}</xsl:text></xsl:if></sup>
		</a>-->
	</xsl:template>

	<xsl:template match="tei:unclear[count(tei:gap)=0]">
<!--		<span class="unclear" title="{following-sibling::*[1][name()='note']}">
			<xsl:apply-templates select="node()"/>
		</span>-->
<!-- 16.04.2015
			<u>
			<xsl:apply-templates select="node()"/>
		</u>-->

		<xsl:text>[</xsl:text>
			<xsl:apply-templates select="node()"/>
		<xsl:text>]</xsl:text>
	</xsl:template>

	<xsl:template match="tei:gap">
		<!--<xsl:text>...</xsl:text>-->

		<xsl:text>[</xsl:text>
		<xsl:call-template name="tPrintXtimes">
			<xsl:with-param name="pPrintWhat" select="' .'"/>
			<xsl:with-param name="pPrintHowManyTimes" select="current()/@quantity"/>
		</xsl:call-template>
		<xsl:text> ]</xsl:text>



		<!-- 16.04.2015
		<xsl:variable name="vNoteFolgt">
			<xsl:call-template name="tNoteFolgt">
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>


		<xsl:variable name="vLeerzeichenDavor">
			<xsl:call-template name="tLeerzeichenDavor">
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="vLeerzeichenDanach">
			<xsl:call-template name="tLeerzeichenDanach">
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$vLeerzeichenDavor=$vLeerzeichenDanach and $vLeerzeichenDavor='true'">

				<!-\-
					-	wenn <gap> alleinstehendes Element, d.h. Leerzeichen vor und hinter <gap>:
						Fußnotenzeichen an „…“ hängen, Wortlaut der Anmerkung:
							„ca. [n] Buchstaben [unit=“chars“] / Worte [unit=“words“] unleserlich“  (bei n>1); bzw.
							„ca. 1 Buchstabe [unit=“chars“] / Wort [unit=“words“] unleserlich“ (bei n=1).
				-\->

				<xsl:choose>
					<xsl:when test="$vNoteFolgt='true'">

					</xsl:when>
					<xsl:otherwise>
						<!-\- Index mit Hyperlink auf Fußnote anhängen -\->

						<!-\- Bezugsknoten -\->
						<xsl:variable name="vBezug" select="."/>

						<!-\- Text für Tooltip erstellen -\->
						<xsl:variable name="vFunoText">
							<xsl:call-template name="tFunoText_alphabetisch">
								<xsl:with-param name="pNode" select="$vBezug"/>
							</xsl:call-template>
						</xsl:variable>

						<xsl:variable name="vIndex">
							<xsl:call-template name="indexOf_a">
								<!-\-<xsl:with-param name="pSeq" select="$funoSicNote"/>-\->
								<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
								<xsl:with-param name="pNode" select="$vBezug"/>
							</xsl:call-template>
						</xsl:variable>

						<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="noteLink">
							<xsl:attribute name="title">
								<xsl:call-template name="tTooltip">
									<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"/>
								</xsl:call-template>
							</xsl:attribute>
							<sup><xsl:value-of select="$vIndex"/><xsl:if test="$vIndex=''"><xsl:text>{NoIndex}</xsl:text></xsl:if></sup>
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>

			<xsl:otherwise>

				<!-\-
					-	wenn <gap> innerhalb eines Wortes steht: An der Stelle von <gap> „…“ in das Wort hineinsetzen (ohne Leerzeichenabstand) und Fußnote an dieses Wort anhängen:
						„ca. [n] Buchstabe[n] am unleserlich“
				-\->
				<xsl:text>...</xsl:text>

				<!-\- ACHTUNG: Link für Fußnote muss über nachfolgenden text() erzeugt werden! -\->
			</xsl:otherwise>
		</xsl:choose>

-->


	</xsl:template>

	<xsl:template match="tei:expan">
<!--		<i>
			<xsl:apply-templates select="node()"/>
		</i>-->
		<xsl:apply-templates select="node()"/>
	</xsl:template>

	<xsl:template match="tei:ex">
		<span class="textItalic">
			<xsl:apply-templates select="node()"/>
		</span>
	</xsl:template>

	<xsl:template match="tei:space">

		<xsl:variable name="vNoteFolgt">
			<!-- ermittelt, ob eine <note> angehängt ist -->
			<xsl:call-template name="tNoteFolgt">
				<xsl:with-param name="pNode" select="."/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:text> - - - </xsl:text>

		<xsl:choose>
			<xsl:when test="$vNoteFolgt='true'">
				<!-- kein Verweis, falls noch <note> (=eigener Verweis) folgt -->
			</xsl:when>
			<xsl:otherwise>
				
				<xsl:call-template name="tFunoVerweis_alphabetisch">
					<xsl:with-param name="pBezug" select="."/>
				</xsl:call-template>
				
<!--
				<!-\- Index mit Hyperlink auf Fußnote anhängen -\->
				<!-\- Bezugsknoten -\->
				<xsl:variable name="vBezug" select="."/>

				<!-\- Text für Tooltip erstellen -\->
				<xsl:variable name="vFunoText">
					<xsl:call-template name="tFunoText_alphabetisch">
						<xsl:with-param name="pNode" select="$vBezug"/>
					</xsl:call-template>
				</xsl:variable>

				<xsl:variable name="vIndex">
					<xsl:call-template name="indexOf_a">
						<!-\-<xsl:with-param name="pSeq" select="$funoSicNote"/>-\->
						<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
						<xsl:with-param name="pNode" select="$vBezug"/>
					</xsl:call-template>
				</xsl:variable>

				<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="noteLink">
					<xsl:attribute name="title">
						<xsl:call-template name="tTooltip">
							<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"/>
						</xsl:call-template>
					</xsl:attribute>
					<sup><xsl:value-of select="$vIndex"/><xsl:if test="$vIndex=''"><xsl:text>{NoIndex}</xsl:text></xsl:if></sup>
				</a>
-->
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template match="tei:date">
		<xsl:apply-templates select="node()"/>
	</xsl:template>
	
	<xsl:template match="tei:locus">
		<xsl:apply-templates select="node()"/>
	</xsl:template>
	
	<xsl:template match="tei:persName">
		<xsl:apply-templates select="node()"/>
	</xsl:template>
	
	<xsl:template match="tei:placeName">
		<xsl:apply-templates select="node()"/>
	</xsl:template>
	
	<xsl:template match="tei:fw[@type='catch']">
		<xsl:apply-templates select="node()"/>
	</xsl:template>	

	<xsl:template match="text()[ancestor::tei:ab]">
		<xsl:variable name="tText">
			<xsl:call-template name="tPlatzhalterVerarbeiten">
				<xsl:with-param name="pText" select="."/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:value-of select="$tText"/>
	</xsl:template>

	<xsl:template match="tei:metamark">
		<!-- metamark vorerst ignorieren -->
	</xsl:template>

	<xsl:template match="tei:hi[@rend='super']">
		<!--  -->
		<span class="hiSuper"><xsl:value-of select="."/></span>
	</xsl:template>

<!--	<xsl:template match="//tei:seg[@xml:id]">
		<!-\- "Erstreckungsfußnoten" -\->

		<xsl:variable name="before">
			<xsl:sequence select="normalize-space(substring-before(text()[last()],' '))"/>
		</xsl:variable>
		<xsl:variable name="after">
			<xsl:sequence select="substring-after(text()[last()],' ')"/>
		</xsl:variable>

		<xsl:value-of select="node()[1]"/>
		<xsl:apply-templates select="tei:add"/>
		<xsl:value-of select="$before"/>
		<xsl:apply-templates select="following-sibling::node()[1][name()='note']"/>
		<xsl:value-of select="$after"/>

	</xsl:template>-->
	<xsl:template match="tei:span[@xml:id]">
		<!-- "Erstreckungsfußnoten" -->

		<xsl:variable name="before">
			<!--<xsl:sequence select="normalize-space(substring-before(text()[last()],' '))"/>-->
			<xsl:value-of select="normalize-space(substring-before(text()[last()],' '))"/>
		</xsl:variable>
		<xsl:variable name="after">
			<!--<xsl:sequence select="substring-after(text()[last()],' ')"/>-->
			<xsl:value-of select="substring-after(text()[last()],' ')"/>
		</xsl:variable>

		<xsl:value-of select="node()[1]"/>
		<xsl:apply-templates select="tei:add"/>
		<xsl:value-of select="$before"/>
		<xsl:apply-templates select="following-sibling::node()[1][name()='note']"/>
		<xsl:value-of select="$after"/>

	</xsl:template>


	<!-- ################################# zusätzliche "Funktionen"/Templates -->

	<xsl:template name="tFunoVerweis_alphabetisch">
		<xsl:param name="pBezug"/>
		
		
		<!-- Bezugsknoten -->
		<xsl:variable name="vBezug" select="$pBezug"/>
		
		<!-- Text für Tooltip erstellen -->
		<xsl:variable name="vFunoText">
			<xsl:call-template name="tFunoText_alphabetisch">
				<xsl:with-param name="pNode" select="$vBezug"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="vIndex">
			<xsl:call-template name="indexOf_a">
				<xsl:with-param name="pSeq" select="$funoAlphabetisch"/>
				<xsl:with-param name="pNode" select="$vBezug"/>
			</xsl:call-template>
		</xsl:variable>
		
		<span class="annotation">
			<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="annotation-link ssdone">
				<xsl:value-of select="$vIndex"/>
				<xsl:if test="$vIndex=''">
					<xsl:text>{NoIndex}</xsl:text>
				</xsl:if>
			</a>
			<div class="annotation-content">
				<a class="ssdone" href="#{generate-id($vBezug)}">
<!--					<xsl:value-of select="$vIndex"/>
					<xsl:if test="$vIndex=''">
						<xsl:text>{NoIndex}</xsl:text>
					</xsl:if>
					<xsl:text>: </xsl:text>-->
					<xsl:call-template name="tTooltip">
						<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"/>
					</xsl:call-template>
				</a>
			</div>
		</span>

		
<!--		<a href="#{generate-id($vBezug)}" id="{generate-id($vBezug)}-L" class="noteLink">
			<xsl:attribute name="title">
				<xsl:call-template name="tTooltip">
					<xsl:with-param name="pNode" select="exslt:node-set($vFunoText)"/>
				</xsl:call-template>
			</xsl:attribute>
			<sup>
				<xsl:value-of select="$vIndex"/>
				<xsl:if test="$vIndex=''">
					<xsl:text>{NoIndex}</xsl:text>
				</xsl:if>
			</sup>
		</a>-->
	</xsl:template>

	<xsl:template name="tFunoText_alphabetisch">
		<xsl:param name="pNode"/>
		<xsl:choose>

			<!-- ############################################################## <subst> ############################################################## -->

			<xsl:when test="local-name($pNode)='subst'">
				<!--<xsl:text>{subst}</xsl:text> <!-\- TESTWEISE -\->-->
			<xsl:call-template name="tFunoText_alphabetisch_subst">
				<xsl:with-param name="pNode" select="$pNode"/>
			</xsl:call-template>
			</xsl:when>

			<!-- ############################################################## <mod> ############################################################## -->

			<xsl:when test="local-name($pNode)='mod'">
				<xsl:call-template name="tFunoText_alphabetisch_mod">
					<xsl:with-param name="pNode" select="$pNode"/>
				</xsl:call-template>
			</xsl:when>

			<!-- ############################################################## <add> ############################################################## -->

			<xsl:when test="local-name($pNode)='add'">
				<!--<xsl:text>{add}</xsl:text> <!-\- TESTWEISE -\->-->
				<xsl:call-template name="tFunoText_alphabetisch_add">
					<xsl:with-param name="pNode" select="$pNode"/>
				</xsl:call-template>
			</xsl:when>

			<!-- ############################################################## <del> ############################################################## -->

			<xsl:when test="local-name($pNode)='del'">
				<!--<xsl:text>{del}</xsl:text> <!-\- TESTWEISE -\->-->
				<xsl:call-template name="tFunoText_alphabetisch_del">
					<xsl:with-param name="pNode" select="$pNode"/>
				</xsl:call-template>
			</xsl:when>

			<!-- ############################################################## <note> ############################################################## -->

			<xsl:when test="local-name($pNode)='note'">
				<!--<xsl:text>{note}</xsl:text> <!-\- TESTWEISE -\->-->
				<xsl:call-template name="tFunoText_alphabetisch_note">
					<xsl:with-param name="pNode" select="$pNode"/>
				</xsl:call-template>
			</xsl:when>

			<!-- ############################################################## <sic> ############################################################## -->

			<xsl:when test="local-name($pNode)='sic'">
				<!--<xsl:text>{sic}</xsl:text> <!-\- TESTWEISE -\->-->
				<xsl:call-template name="tFunoText_alphabetisch_sic">
					<xsl:with-param name="pNode" select="$pNode"/>
				</xsl:call-template>
			</xsl:when>

			<!-- ############################################################## <space> ############################################################## -->

			<xsl:when test="local-name($pNode)='space'">
				<!--<xsl:text>{space}</xsl:text> <!-\- TESTWEISE -\->-->
				<xsl:call-template name="tFunoText_alphabetisch_space">
					<xsl:with-param name="pNode" select="$pNode"/>
				</xsl:call-template>
			</xsl:when>

			<!-- ############################################################## <unclear> ############################################################## -->

			<xsl:when test="local-name($pNode)='unclear'">
				<!--<xsl:text>{unclear}</xsl:text> <!-\- TESTWEISE -\->-->
				<xsl:call-template name="tFunoText_alphabetisch_unclear">
					<xsl:with-param name="pNode" select="$pNode"/>
				</xsl:call-template>
			</xsl:when>
			
			<!-- ############################################################## <choice> ############################################################## -->
			
			<xsl:when test="local-name($pNode)='choice'">
				<!--<xsl:text>{choice}</xsl:text> <!-\- TESTWEISE -\->-->
				<xsl:call-template name="tFunoText_alphabetisch_choice">
					<xsl:with-param name="pNode" select="$pNode"/>
				</xsl:call-template>
			</xsl:when>
			
			<!-- ############################################################## <handShift> ############################################################## -->
			
			<xsl:when test="local-name($pNode)='handShift'">
				<!--<xsl:text>{handShift}</xsl:text> <!-\- TESTWEISE -\->-->
				<xsl:call-template name="tFunoText_alphabetisch_handShift">
					<xsl:with-param name="pNode" select="$pNode"/>
				</xsl:call-template>
			</xsl:when>
			
		</xsl:choose>
	</xsl:template>

	<xsl:template name="tFunoText_alphabetisch_subst">

		<xsl:param name="pNode"/>

		<xsl:variable name="vWortUmKnoten">
			<xsl:call-template name="tGanzesWort_subst">
				<xsl:with-param name="pNode" select="$pNode"/>
				<xsl:with-param name="pWortMitte" select="$pNode/tei:del"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="vWortUmKnoten_add">
			<xsl:call-template name="tGanzesWort">
				<xsl:with-param name="pNode" select="$pNode"/>
				<xsl:with-param name="pWortMitte" select="$pNode/tei:add"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="vWortUmKnoten_del">
			<xsl:call-template name="tGanzesWort_subst">
				<xsl:with-param name="pNode" select="$pNode"/>
				<xsl:with-param name="pWortMitte" select="$pNode/tei:del"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="vLeerzeichenDavor">
			<xsl:call-template name="tLeerzeichenDavor">
				<xsl:with-param name="pNode" select="$pNode"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="vLeerzeichenDanach">
			<xsl:call-template name="tLeerzeichenDanach">
				<xsl:with-param name="pNode" select="$pNode"/>
			</xsl:call-template>
		</xsl:variable>


		<!-- Variablen/Mengen für Hand A-W bzw. Hand X-Z -->
		<xsl:variable name="vHandABC" select="'ABCDEFGHIJKLMNOPQRSTUVW'"/>
		<xsl:variable name="vHandXYZ" select="'XYZ'"/>


		<xsl:choose>
			<xsl:when test="not($pNode/tei:add/@hand)">
				<!-- keine Hand zugewiesen -->

				<xsl:if test="contains($pNode/tei:add,' ')">
					<span class="textItalic"><xsl:value-of select="$vWortUmKnoten_add"/></span>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
					<xsl:text>mit Einfügungszeichen </xsl:text>
				</xsl:if>
				<xsl:if test="$pNode/tei:add/@rend='default'">
					<xsl:text>in Texttinte </xsl:text>
				</xsl:if>
				<xsl:text>korr. aus </xsl:text>
				<span class="textItalic"><xsl:value-of select="$vWortUmKnoten_del"/></span>

			</xsl:when>
			<xsl:when test="string-length($pNode/tei:add/@hand)!=string-length(translate($pNode/tei:add/@hand,$vHandABC,''))">
				<!-- "normale" Hand -->

				<xsl:if test="contains($pNode/tei:add,' ')">
					<span class="textItalic"><xsl:value-of select="$vWortUmKnoten_add"/></span>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:text>von Hand </xsl:text>
				<xsl:value-of select="$pNode/tei:add/@hand"/>
				<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
					<xsl:text> mit Einfügungszeichen</xsl:text>
				</xsl:if>
				<xsl:if test="$pNode/tei:add/@rend='default'">
					<xsl:text> in Texttinte</xsl:text>
				</xsl:if>
				<xsl:text> korr. aus </xsl:text>
				<span class="textItalic"><xsl:value-of select="$vWortUmKnoten_del"/></span>

			</xsl:when>
			<xsl:when test="string-length($pNode/tei:add/@hand)!=string-length(translate($pNode/tei:add/@hand,$vHandXYZ,''))">
				<!-- "spezielle" Hand -->

				<xsl:if test="contains($pNode/tei:del,' ')">
					<span class="textItalic"><xsl:value-of select="$vWortUmKnoten_del"/></span>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:text>von Hand </xsl:text>
				<xsl:value-of select="$pNode/tei:add/@hand"/>
				<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
					<xsl:text> mit Einfügungszeichen</xsl:text>
				</xsl:if>
				<xsl:if test="$pNode/tei:add/@rend='default'">
					<xsl:text> in Texttinte</xsl:text>
				</xsl:if>
				<xsl:text> korr. zu </xsl:text>
				<span class="textItalic"><xsl:value-of select="$vWortUmKnoten_add"/></span>

			</xsl:when>
		</xsl:choose>

	</xsl:template>


	<xsl:template name="tFunoText_alphabetisch_mod">
		<xsl:param name="pNode"/>

		<xsl:variable name="vLeerzeichenDavor">
			<xsl:call-template name="tLeerzeichenDavor">
				<xsl:with-param name="pNode" select="$pNode"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="vLeerzeichenDanach">
			<xsl:call-template name="tLeerzeichenDanach">
				<xsl:with-param name="pNode" select="$pNode"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='true'">
				<!-- wenn vor und nach <mod> kein Leerzeichen => <mod> umschließt ganzes Wort -->
				<xsl:text>korr. (?)</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<!-- <mod> innerhalb eines Wortes -->
				<span class="textItalic"><xsl:apply-templates select="$pNode/node()"/></span><xsl:text> korr. (?)</xsl:text>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="tFunoText_alphabetisch_add">
		<xsl:param name="pNode"/>

		<!-- erzeugt Fußnotentext für <add> -->


				<xsl:variable name="vLeerzeichenDavorOderDanach">
					<xsl:call-template name="tLeerzeichenDavorOderDanach">
						<xsl:with-param name="pNode" select="$pNode"/>
					</xsl:call-template>
				</xsl:variable>

				<xsl:variable name="vLeerzeichenDavor">
					<xsl:call-template name="tLeerzeichenDavor">
						<xsl:with-param name="pNode" select="$pNode"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="vLeerzeichenDanach">
					<xsl:call-template name="tLeerzeichenDanach">
						<xsl:with-param name="pNode" select="$pNode"/>
					</xsl:call-template>
				</xsl:variable>

				<xsl:variable name="vWortUmKnoten">
					<xsl:call-template name="tGanzesWort">
						<xsl:with-param name="pNode" select="$pNode"/>
						<xsl:with-param name="pWortMitte" select="$pNode"/>
					</xsl:call-template>
				</xsl:variable>

				<!-- Variablen/Mengen für Hand A-W bzw. Hand X-Z -->
				<xsl:variable name="vHandABC" select="'ABCDEFGHIJKLMNOPQRSTUVW'"/>
				<xsl:variable name="vHandXYZ" select="'XYZ'"/>

				<xsl:choose>
					<xsl:when test="not($pNode/@hand)">
						<!-- #################### keine Hand zugewiesen #################### -->

						<xsl:choose>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='true'">
								<!-- steht alleine/ganzes Wort ergänzt -->

								<!--<span class="debug"><xsl:text>{add_tt}</xsl:text></span>-->

								<span class="textItalic"><xsl:apply-templates select="$pNode/node()"/></span>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen</xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/@rend='default'">
									<xsl:text> in Texttinte</xsl:text>
								</xsl:if>
								<xsl:text> ergänzt</xsl:text>

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='false'">
								<!-- am Wortanfang -->

								<!--<span class="debug"><xsl:text>{add_tf}</xsl:text></span>-->

<!--								<xsl:if test="contains($pNode,' ')">
									<i><xsl:value-of select="$vWortUmKnoten"/></i>
									<xsl:text> </xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen </xsl:text>
								</xsl:if>
								<xsl:text>korr. aus </xsl:text>
								<i>
									<xsl:call-template name="tPrecedingWortteil_fromThis">
										<xsl:with-param name="pPrecedingTextThis" select="$pNode"/>
										<xsl:with-param name="pPrecedingTextBeforeNode" select="''"/>
									</xsl:call-template>

									<!-\-<span class="debug"><xsl:text>{</xsl:text></span>-\->

									<xsl:call-template name="tFollowingWortteil_fromThis">
										<xsl:with-param name="pFollowingTextThis" select="$pNode"/>
										<xsl:with-param name="pFollowingTextBeforeNode" select="''"/>
									</xsl:call-template>

									<!-\-<span class="debug"><xsl:text>}</xsl:text></span>-\->
								</i>
								<xsl:if test="current()[@rend='default']">
									<xsl:text>- korr. in Texttinte</xsl:text>
								</xsl:if>-->

								<span class="textItalic"><xsl:apply-templates select="$pNode/node()"/></span>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen</xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/@rend='default'">
									<xsl:text> in Texttinte</xsl:text>
								</xsl:if>
								<xsl:text> ergänzt</xsl:text>

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='false' and $vLeerzeichenDanach='true'">
								<!-- am Wortende -->

								<!--<span class="debug"><xsl:text>{add_ft}</xsl:text></span>-->

<!--								<xsl:if test="contains($pNode,' ')">
									<i><xsl:value-of select="$vWortUmKnoten"/></i>
									<xsl:text> </xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen </xsl:text>
								</xsl:if>
								<xsl:text>korr. aus </xsl:text>
								<i>
									<!-\-<span class="debug"><xsl:text>{</xsl:text></span>-\->

									<xsl:call-template name="tPrecedingWortteil_fromThis">
										<xsl:with-param name="pPrecedingTextThis" select="$pNode"/>
										<xsl:with-param name="pPrecedingTextBeforeNode" select="''"/>
									</xsl:call-template>

									<!-\-<span class="debug"><xsl:text>}</xsl:text></span>-\->

									<xsl:call-template name="tFollowingWortteil_fromThis">
										<xsl:with-param name="pFollowingTextThis" select="$pNode"/>
										<xsl:with-param name="pFollowingTextBeforeNode" select="''"/>
									</xsl:call-template>


								</i>
								<xsl:if test="current()[@rend='default']">
									<xsl:text> - korr. in Texttinte</xsl:text>
								</xsl:if>-->

								<span class="textItalic"><xsl:apply-templates select="$pNode/node()"/></span>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen</xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/@rend='default'">
									<xsl:text> in Texttinte</xsl:text>
								</xsl:if>
								<xsl:text> ergänzt</xsl:text>

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='false' and $vLeerzeichenDanach='false'">
								<!-- im Wort -->

								<!--<span class="debug"><xsl:text>{add_ff}</xsl:text></span>-->

<!--								<xsl:if test="contains($pNode,' ')">
									<i><xsl:value-of select="$vWortUmKnoten"/></i>
									<xsl:text> </xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen </xsl:text>
								</xsl:if>
								<xsl:text>korr. aus </xsl:text>
								<i>
									<xsl:call-template name="tPrecedingWortteil_fromThis">
										<xsl:with-param name="pPrecedingTextThis" select="$pNode"/>
										<xsl:with-param name="pPrecedingTextBeforeNode" select="''"/>
									</xsl:call-template>
									<xsl:call-template name="tFollowingWortteil_fromThis">
										<xsl:with-param name="pFollowingTextThis" select="$pNode"/>
										<xsl:with-param name="pFollowingTextBeforeNode" select="''"/>
									</xsl:call-template>
								</i>
								<xsl:if test="current()[@rend='default']">
									<xsl:text> - korr. in Texttinte</xsl:text>
								</xsl:if>-->

								<span class="textItalic"><xsl:apply-templates select="$pNode/node()"/></span>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen</xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/@rend='default'">
									<xsl:text> in Texttinte</xsl:text>
								</xsl:if>
								<xsl:text> ergänzt</xsl:text>

							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="string-length($pNode/@hand)!=string-length(translate($pNode/@hand,$vHandABC,''))">
						<!-- #################### "normale" Hand #################### -->

						<xsl:choose>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='true'">
								<!-- steht alleine/ganzes Wort ergänzt -->

								<!--<span class="debug"><xsl:text>{add-A-tt}</xsl:text></span>-->

								<span class="textItalic"><xsl:apply-templates select="$pNode/node()"/></span>
								<xsl:text> von Hand </xsl:text>
								<xsl:value-of select="$pNode/@hand"/>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen</xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/@rend='default'">
									<xsl:text> in Texttinte</xsl:text>
								</xsl:if>
								<xsl:text> ergänzt</xsl:text>




							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='false'">
								<!-- am Wortanfang -->

								<!--<span class="debug"><xsl:text>{add-A-tf}</xsl:text></span>-->

								<span class="textItalic"><xsl:apply-templates select="$pNode/node()"/></span>
								<xsl:text> von Hand </xsl:text>
								<xsl:value-of select="$pNode/@hand"/>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen</xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/@rend='default'">
									<xsl:text> in Texttinte</xsl:text>
								</xsl:if>
								<xsl:text> ergänzt</xsl:text>




<!--								<xsl:if test="contains($pNode,' ')">
									<i><xsl:value-of select="$vWortUmKnoten"/></i>
									<xsl:text> </xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen </xsl:text>
								</xsl:if>
								<xsl:text>korr. aus </xsl:text>
								<i>
									<xsl:call-template name="tPrecedingWortteil_fromThis">
										<xsl:with-param name="pPrecedingTextThis" select="$pNode"/>
										<xsl:with-param name="pPrecedingTextBeforeNode" select="''"/>
									</xsl:call-template>

									<!-\-<span class="debug"><xsl:text>{</xsl:text></span>-\->

									<xsl:call-template name="tFollowingWortteil_fromThis">
										<xsl:with-param name="pFollowingTextThis" select="$pNode"/>
										<xsl:with-param name="pFollowingTextBeforeNode" select="''"/>
									</xsl:call-template>
								</i>-->
							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='false' and $vLeerzeichenDanach='true'">
								<!-- am Wortende -->

								<!--<span class="debug"><xsl:text>{add-A-ft}</xsl:text></span>-->

								<span class="textItalic"><xsl:apply-templates select="$pNode/node()"/></span>
								<xsl:text> von Hand </xsl:text>
								<xsl:value-of select="$pNode/@hand"/>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen</xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/@rend='default'">
									<xsl:text> in Texttinte</xsl:text>
								</xsl:if>
								<xsl:text> ergänzt</xsl:text>


<!--								<xsl:if test="contains($pNode,' ')">
									<i><xsl:value-of select="$vWortUmKnoten"/></i>
									<xsl:text> </xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen </xsl:text>
								</xsl:if>
								<xsl:text>korr. aus </xsl:text>
								<i>
									<xsl:call-template name="tPrecedingWortteil_fromThis">
										<xsl:with-param name="pPrecedingTextThis" select="$pNode"/>
										<xsl:with-param name="pPrecedingTextBeforeNode" select="''"/>
									</xsl:call-template>

									<!-\-<span class="debug"><xsl:text>{</xsl:text></span>-\->

									<xsl:call-template name="tFollowingWortteil_fromThis">
										<xsl:with-param name="pFollowingTextThis" select="$pNode"/>
										<xsl:with-param name="pFollowingTextBeforeNode" select="''"/>
									</xsl:call-template>
								</i>-->
							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='false' and $vLeerzeichenDanach='false'">
								<!-- im Wort -->

								<!--<span class="debug"><xsl:text>{add-A-ff}</xsl:text></span>-->

								<span class="textItalic"><xsl:apply-templates select="$pNode/node()"/></span>
								<xsl:text> von Hand </xsl:text>
								<xsl:value-of select="$pNode/@hand"/>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen</xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/@rend='default'">
									<xsl:text> in Texttinte</xsl:text>
								</xsl:if>
								<xsl:text> ergänzt</xsl:text>



<!--								<xsl:if test="contains($pNode,' ')">
									<i><xsl:value-of select="$vWortUmKnoten"/></i>
									<xsl:text> </xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen </xsl:text>
								</xsl:if>
								<xsl:text>korr. aus </xsl:text>
								<i>
									<xsl:call-template name="tPrecedingWortteil_fromThis">
										<xsl:with-param name="pPrecedingTextThis" select="$pNode"/>
										<xsl:with-param name="pPrecedingTextBeforeNode" select="''"/>
									</xsl:call-template>

									<!-\-<span class="debug"><xsl:text>{</xsl:text></span>-\->

									<xsl:call-template name="tFollowingWortteil_fromThis">
										<xsl:with-param name="pFollowingTextThis" select="$pNode"/>
										<xsl:with-param name="pFollowingTextBeforeNode" select="''"/>
									</xsl:call-template>
								</i>-->
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="string-length($pNode/@hand)!=string-length(translate($pNode/@hand,$vHandXYZ,''))">
						<!-- #################### "spezielle" Hand #################### -->

						<xsl:choose>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='true'">
								<!-- steht alleine/ganzes Wort ergänzt -->

								<!--<span class="debug"><xsl:text>{tt}</xsl:text></span>-->

								<xsl:text>folgt von Hand </xsl:text>
								<xsl:value-of select="$pNode/@hand"/>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen</xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/@rend='default'">
									<xsl:text> in Texttinte</xsl:text>
								</xsl:if>
								<xsl:text> ergänztes </xsl:text>
								<span class="textItalic"><xsl:apply-templates select="$pNode/node()"/></span>

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='false'">
								<!-- am Wortanfang -->

								<!--<span class="debug"><xsl:text>{tf}</xsl:text></span>-->


								<xsl:text>von Hand </xsl:text>
								<xsl:value-of select="@hand"/>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen</xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/@rend='default'">
									<xsl:text> in Texttinte</xsl:text>
								</xsl:if>
								<xsl:text> korr. zu </xsl:text>
								<span class="textItalic"><xsl:value-of select="$vWortUmKnoten"/></span>

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='false' and $vLeerzeichenDanach='true'">
								<!-- am Wortende -->

								<!--<span class="debug"><xsl:text>{ft}</xsl:text></span>-->

								<xsl:text>von Hand </xsl:text>
								<xsl:value-of select="$pNode/@hand"/>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen</xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/@rend='default'">
									<xsl:text> in Texttinte</xsl:text>
								</xsl:if>
								<xsl:text> korr. zu </xsl:text>
								<span class="textItalic"><xsl:value-of select="$vWortUmKnoten"/></span>

							</xsl:when>
							<xsl:when test="$vLeerzeichenDavor='false' and $vLeerzeichenDanach='false'">
								<!-- im Wort -->

								<!--<span class="debug"><xsl:text>{ff}</xsl:text></span>-->

								<xsl:text>von Hand </xsl:text>
								<xsl:value-of select="$pNode/@hand"/>
								<xsl:if test="$pNode/following-sibling::*[1][local-name(.)='metamark']">
									<xsl:text> mit Einfügungszeichen</xsl:text>
								</xsl:if>
								<xsl:if test="$pNode/@rend='default'">
									<xsl:text> in Texttinte</xsl:text>
								</xsl:if>
								<xsl:text> korr. zu </xsl:text>
								<span class="textItalic"><xsl:value-of select="$vWortUmKnoten"/></span>

							</xsl:when>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
	</xsl:template>


	<xsl:template name="tFunoText_alphabetisch_del">
		<xsl:param name="pNode"/>
				<!--
				<xsl:variable name="vLeerzeichenDavor">
					<xsl:call-template name="tLeerzeichenDavor">
						<xsl:with-param name="pNode" select="$pNode"/>
					</xsl:call-template>
				</xsl:variable>

				<xsl:variable name="vLeerzeichenDanach">
					<xsl:call-template name="tLeerzeichenDanach">
						<xsl:with-param name="pNode" select="$pNode"/>
					</xsl:call-template>
				</xsl:variable>

				<xsl:choose>
					<xsl:when test="count($pNode/node())=0">

					</xsl:when>

					<xsl:when test="count($pNode/node())>0">
						<!-\- nicht leer -\->
						<xsl:choose>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='true'">
								<!-\- ganzes Wort getilgt -\->
<!-\-								=> Fußnotenzeichen an vorangehendes Wort hängen, Wortlaut der Anmerkung:
								„Es folgt getilgtes [del]“   -\->

								<xsl:text>folgt </xsl:text>
								<xsl:if test="@hand">
									<xsl:text>von Hand </xsl:text>
									<xsl:value-of select="@hand"/>
								</xsl:if>
								<xsl:text> getilgtes </xsl:text>
								<i><xsl:apply-templates select="$pNode/node()"/></i>
							</xsl:when>

							<xsl:otherwise>
								<!-\- im Wort getilgt -\->
								<!-\-								=> Wort ohne <del> im Text ausgeben und daran ein Fußnotenzeichen anhängen mit Wortlaut:
									„korr. aus [Wort mit <del>]“-\->


								<xsl:text>korr. </xsl:text>
								<xsl:if test="@hand">
									<xsl:text>von Hand </xsl:text>
									<xsl:value-of select="@hand"/>
								</xsl:if>
								<xsl:text> aus </xsl:text>
								<i>
									<xsl:call-template name="tGanzesWort">
										<xsl:with-param name="pNode" select="$pNode"/>
										<xsl:with-param name="pWortMitte" select="$pNode"/>
									</xsl:call-template>
								</i>

							</xsl:otherwise>

						</xsl:choose>
					</xsl:when>
				</xsl:choose>-->




		<xsl:variable name="vLeerzeichenDavor">
			<xsl:call-template name="tLeerzeichenDavor">
				<xsl:with-param name="pNode" select="$pNode"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="vLeerzeichenDanach">
			<xsl:call-template name="tLeerzeichenDanach">
				<xsl:with-param name="pNode" select="$pNode"/>
			</xsl:call-template>
		</xsl:variable>


		<!-- Variablen/Mengen für Hand A-W bzw. Hand X-Z -->
		<xsl:variable name="vHandABC" select="'ABCDEFGHIJKLMNOPQRSTUVW'"/>
		<xsl:variable name="vHandXYZ" select="'XYZ'"/>





		<xsl:choose>
			<xsl:when test="count($pNode/node())=0">
				<!-- leer -->
			</xsl:when>

			<xsl:when test="count($pNode/node())>0">
				<!-- nicht leer -->

				<xsl:choose>
					<xsl:when test="not($pNode/@hand)">
						<!-- #################### keine Hand angegeben #################### -->

						<xsl:choose>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='true'">
								<!-- ganzes Wort getilgt -->
								<xsl:text>folgt getilgtes </xsl:text>
								<span class="textItalic"><xsl:value-of select="$pNode"/></span>
							</xsl:when>
							<xsl:when test="($vLeerzeichenDavor='false' and $vLeerzeichenDanach='false') or ($vLeerzeichenDavor='true' and $vLeerzeichenDanach='false') or ($vLeerzeichenDavor='false' and $vLeerzeichenDanach='true')">
								<!-- Teil des Wortes getilgt -->
								<xsl:text>korr. aus </xsl:text>
								<span class="textItalic">
									<xsl:call-template name="tGanzesWort">
										<xsl:with-param name="pNode" select="$pNode"/>
										<xsl:with-param name="pWortMitte" select="$pNode"/>
									</xsl:call-template>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<!-- ??? -->
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>

					<xsl:when test="string-length($pNode/@hand)!=string-length(translate($pNode/@hand,$vHandABC,''))">
						<!-- #################### entspricht "normaler" Hand #################### -->

						<xsl:choose>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='true'">
								<!-- ganzes Wort getilgt -->
								<xsl:text>folgt von Hand </xsl:text>
								<xsl:value-of select="$pNode/@hand"/>
								<xsl:text> getilgtes </xsl:text>
								<span class="textItalic"><xsl:apply-templates select="$pNode/node()"/></span>
							</xsl:when>
							<xsl:when test="($vLeerzeichenDavor='false' and $vLeerzeichenDanach='false') or ($vLeerzeichenDavor='true' and $vLeerzeichenDanach='false') or ($vLeerzeichenDavor='false' and $vLeerzeichenDanach='true')">
								<!-- Teil des Wortes getilgt -->

<!--								<span class="debug"><xsl:text>{</xsl:text></span>
								<xsl:value-of select="$vLeerzeichenDavor"/>
								<xsl:text>|</xsl:text>
								<xsl:value-of select="$vLeerzeichenDanach"/>
								<span class="debug"><xsl:text>}</xsl:text></span>-->


								<xsl:text>korr. von Hand </xsl:text>
								<xsl:apply-templates select="$pNode/@hand"/>
								<xsl:text> aus </xsl:text>
								<span class="textItalic">
									<xsl:call-template name="tGanzesWort">
										<xsl:with-param name="pNode" select="$pNode"/>
										<xsl:with-param name="pWortMitte" select="$pNode"/>
									</xsl:call-template>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<!-- ??? -->
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>

					<xsl:when test="string-length($pNode/@hand)!=string-length(translate($pNode/@hand,$vHandXYZ,''))">
						<!-- #################### entspricht "spezieller" Hand #################### -->

						<xsl:choose>
							<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='true'">
								<!-- ganzes Wort getilgt -->
								<xsl:text>von Hand </xsl:text>
								<xsl:value-of select="$pNode/@hand"/>
								<xsl:text> getilgt </xsl:text>
							</xsl:when>
							<xsl:when test="($vLeerzeichenDavor='false' and $vLeerzeichenDanach='false') or ($vLeerzeichenDavor='true' and $vLeerzeichenDanach='false') or ($vLeerzeichenDavor='false' and $vLeerzeichenDanach='true')">
								<!-- Teil des Wortes getilgt -->
								<xsl:text>korr. von Hand </xsl:text>
								<xsl:apply-templates select="$pNode/@hand"/>
								<xsl:text> zu </xsl:text>
								<span class="textItalic">
									<xsl:call-template name="tGanzesWort">
										<xsl:with-param name="pNode" select="$pNode"/>
										<xsl:with-param name="pWortMitte" select="''"/>
									</xsl:call-template>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<!-- ??? -->
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>


		<!--
		<xsl:choose>
			<xsl:when test="count($pNode/node())=0">
				<!-\- leer -\->
			</xsl:when>

			<xsl:when test="count($pNode/node())>0">
				<!-\- nicht leer -\->
				<xsl:choose>
					<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='true'">
						<!-\- ganzes Wort getilgt -\->

						<xsl:choose>
							<xsl:when test="not($pNode/@hand)">
								<!-\- keine Hand -\->
								<!-\- => Fußnotenzeichen an vorangehendes Wort hängen, Wortlaut der Anmerkung: „Es folgt getilgtes [del]“   -\->
								<xsl:text>Es folgt getilgtes </xsl:text>
								<i><xsl:value-of select="$pNode"/></i>
							</xsl:when>
							<xsl:when test="string-length($pNode/@hand)!=string-length(translate($pNode/@hand,$vHandABC,''))">
								<!-\- entspricht "normaler" Hand -\->
								<xsl:text>folgt von Hand </xsl:text>
								<xsl:value-of select="$pNode/@hand"/>
								<xsl:text> getilgtes </xsl:text>
								<i><xsl:apply-templates select="$pNode/node()"/></i>
								<!-\-
						o	ganzes Wort getilgt, d.h. Leerzeichen vor und hinter <del/>:
							Fußnotenzeichen an vorangehendes Wort hängen, Wortlaut der Anmerkung:
							„folgt von Hand B getilgtes [del]“
						-\->
							</xsl:when>
							<xsl:when test="string-length($pNode/@hand)!=string-length(translate($pNode/@hand,$vHandXYZ,''))">
								<!-\- entspricht "spezieller" Hand -\->

								<xsl:text>von Hand </xsl:text>
								<xsl:value-of select="$pNode/@hand"/>
								<xsl:text> getilgt </xsl:text>
								<!-\-

						o	ganzes Wort getilgt, d.h. Leerzeichen vor und hinter <del/>: Inhalt von <del> im Haupttext anzeigen, daran Fußnote mit Text:
							„von Hand X getilgt“
						-\->
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>FEHLER IN 'del'</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when
						test="$vLeerzeichenDavor='true' or $vLeerzeichenDanach='false'">
						<!-\- im Wort getilgt -\->
						<xsl:choose>
							<xsl:when test="not($pNode/@hand)">
								<!-\- keine Hand -\->
								<!-\-								=> Wort ohne <del> im Text ausgeben und daran ein Fußnotenzeichen anhängen mit Wortlaut:
									„korr. aus [Wort mit <del>]“-\->
								<xsl:text>korr. aus </xsl:text>
								<i>
									<xsl:call-template name="tGanzesWort">
										<xsl:with-param name="pNode" select="$pNode"/>
										<xsl:with-param name="pWortMitte" select="$pNode"/>
									</xsl:call-template>
								</i>
							</xsl:when>
							<xsl:when test="string-length($pNode/@hand)!=string-length(translate($pNode/@hand,$vHandABC,''))">
								<!-\- entspricht "normaler" Hand -\->
								<!-\-
						o	Buchstaben innerhalb des Wortes getilgt, d.h. <del/> wird nicht von zwei Leerzeichen davor und danach eingefaßt:
							Wort ohne <del> im Text ausgeben und daran ein Fußnotenzeichen anhängen mit Wortlaut:
							„korr. von Hand B aus [Wort mit <del>]“
						-\->

								<xsl:text>korr. von Hand </xsl:text>
								<xsl:apply-templates select="$pNode/@hand"/>
								<xsl:text> aus </xsl:text>
								<i>
									<xsl:call-template name="tGanzesWort">
										<xsl:with-param name="pNode" select="$pNode"/>
										<xsl:with-param name="pWortMitte" select="$pNode"/>
									</xsl:call-template>
								</i>


							</xsl:when>
							<xsl:when test="string-length($pNode/@hand)!=string-length(translate($pNode/@hand,$vHandXYZ,''))">
								<!-\- entspricht "spezieller" Hand -\->

								<xsl:text>korr. von Hand </xsl:text>
								<xsl:apply-templates select="$pNode/@hand"/>
								<xsl:text> zu </xsl:text>
								<i>
									<xsl:call-template name="tGanzesWort">
										<xsl:with-param name="pNode" select="$pNode"/>
										<xsl:with-param name="pWortMitte" select="''"/>
									</xsl:call-template>
								</i>

								<!-\-
						o	Buchstaben innerhalb des Wortes getilgt, d.h. <del/> wird nicht von zwei Leerzeichen davor und danach eingefaßt: Wort mit <del> im Haupttext anzeigen und daran eine Fußnoten anhängen mit Text:
							„korr. von Hand X zu [Wort ohne Inhalt von <del>]“
						-\->
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>FEHLER IN 'del'</xsl:text>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:when>
					<xsl:when
						test="$vLeerzeichenDavor='false' or $vLeerzeichenDanach='true'">
						<!-\- im Wort getilgt -\->
						<xsl:choose>
							<xsl:when test="not($pNode/@hand)">
								<!-\- keine Hand -\->
								<!-\-								=> Wort ohne <del> im Text ausgeben und daran ein Fußnotenzeichen anhängen mit Wortlaut:
									„korr. aus [Wort mit <del>]“-\->
								<xsl:text>korr. aus </xsl:text>
								<i>
									<xsl:call-template name="tGanzesWort">
										<xsl:with-param name="pNode" select="$pNode"/>
										<xsl:with-param name="pWortMitte" select="$pNode"/>
									</xsl:call-template>
								</i>
							</xsl:when>
							<xsl:when test="string-length($pNode/@hand)!=string-length(translate($pNode/@hand,$vHandABC,''))">
								<!-\- entspricht "normaler" Hand -\->
								<!-\-
						o	Buchstaben innerhalb des Wortes getilgt, d.h. <del/> wird nicht von zwei Leerzeichen davor und danach eingefaßt:
							Wort ohne <del> im Text ausgeben und daran ein Fußnotenzeichen anhängen mit Wortlaut:
							„korr. von Hand B aus [Wort mit <del>]“
						-\->

								<xsl:text>korr. von Hand </xsl:text>
								<xsl:apply-templates select="$pNode/@hand"/>
								<xsl:text> aus </xsl:text>
								<xsl:call-template name="tGanzesWort">
									<xsl:with-param name="pNode" select="$pNode"/>
									<xsl:with-param name="pWortMitte" select="$pNode"/>
								</xsl:call-template>


							</xsl:when>
							<xsl:when test="string-length($pNode/@hand)!=string-length(translate($pNode/@hand,$vHandXYZ,''))">
								<!-\- entspricht "spezieller" Hand -\->

								<xsl:text>korr. von Hand </xsl:text>
								<xsl:apply-templates select="$pNode/@hand"/>
								<xsl:text> zu </xsl:text>
								<xsl:call-template name="tGanzesWort">
									<xsl:with-param name="pNode" select="$pNode"/>
									<xsl:with-param name="pWortMitte" select="''"/>
								</xsl:call-template>

								<!-\-
						o	Buchstaben innerhalb des Wortes getilgt, d.h. <del/> wird nicht von zwei Leerzeichen davor und danach eingefaßt: Wort mit <del> im Haupttext anzeigen und daran eine Fußnoten anhängen mit Text:
							„korr. von Hand X zu [Wort ohne Inhalt von <del>]“
						-\->
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>FEHLER IN 'del'</xsl:text>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:when>
					<xsl:when
						test="$vLeerzeichenDavor='false' or $vLeerzeichenDanach='false'">
						<!-\- im Wort getilgt -\->
						<xsl:choose>
							<xsl:when test="not($pNode/@hand)">
								<!-\- keine Hand -\->
								<!-\-								=> Wort ohne <del> im Text ausgeben und daran ein Fußnotenzeichen anhängen mit Wortlaut:
									„korr. aus [Wort mit <del>]“-\->
								<xsl:text>korr. aus </xsl:text>
								<i>
									<xsl:call-template name="tGanzesWort">
										<xsl:with-param name="pNode" select="$pNode"/>
										<xsl:with-param name="pWortMitte" select="$pNode"/>
									</xsl:call-template>
								</i>
							</xsl:when>
							<xsl:when test="string-length($pNode/@hand)!=string-length(translate($pNode/@hand,$vHandABC,''))">
								<!-\- entspricht "normaler" Hand -\->
								<!-\-
						o	Buchstaben innerhalb des Wortes getilgt, d.h. <del/> wird nicht von zwei Leerzeichen davor und danach eingefaßt:
							Wort ohne <del> im Text ausgeben und daran ein Fußnotenzeichen anhängen mit Wortlaut:
							„korr. von Hand B aus [Wort mit <del>]“
						-\->

								<xsl:text>korr. von Hand </xsl:text>
								<xsl:apply-templates select="$pNode/@hand"/>
								<xsl:text> aus </xsl:text>
								<xsl:call-template name="tGanzesWort">
									<xsl:with-param name="pNode" select="$pNode"/>
									<xsl:with-param name="pWortMitte" select="$pNode"/>
								</xsl:call-template>


							</xsl:when>
							<xsl:when test="string-length($pNode/@hand)!=string-length(translate($pNode/@hand,$vHandXYZ,''))">
								<!-\- entspricht "spezieller" Hand -\->

								<xsl:text>korr. von Hand </xsl:text>
								<xsl:apply-templates select="$pNode/@hand"/>
								<xsl:text> zu </xsl:text>
								<xsl:call-template name="tGanzesWort">
									<xsl:with-param name="pNode" select="$pNode"/>
									<xsl:with-param name="pWortMitte" select="''"/>
								</xsl:call-template>

								<!-\-
						o	Buchstaben innerhalb des Wortes getilgt, d.h. <del/> wird nicht von zwei Leerzeichen davor und danach eingefaßt: Wort mit <del> im Haupttext anzeigen und daran eine Fußnoten anhängen mit Text:
							„korr. von Hand X zu [Wort ohne Inhalt von <del>]“
						-\->
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>FEHLER IN 'del'</xsl:text>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:when>

				</xsl:choose>
			</xsl:when>
		</xsl:choose>-->
	</xsl:template>

	<xsl:template name="tFunoText_alphabetisch_note">
		<xsl:param name="pNode"/>

		<xsl:if test="@target">
			<xsl:variable name="vPrecSeg" select="$pNode/preceding-sibling::node()[1][local-name(.)='span'][@xml:id]"/>
			<xsl:variable name="vBezug">
				<xsl:value-of select="$vPrecSeg/text()[1]"/>
				<xsl:value-of select="$vPrecSeg/tei:add"/>
				<xsl:value-of select="substring-before($vPrecSeg/text()[last()],' ')"/>
				<xsl:text>...</xsl:text>
				<xsl:value-of select="substring-after($vPrecSeg/text()[last()],' ')"/>
				<xsl:text>: </xsl:text>
			</xsl:variable>
			<xsl:value-of select="$vBezug"/>
		</xsl:if>
		<xsl:apply-templates select="$pNode/node()"/>
	</xsl:template>

	<xsl:template name="tFunoText_alphabetisch_sic">
		<xsl:param name="pNode"/>

		<xsl:text>sic Hs.</xsl:text>
	</xsl:template>

	<xsl:template name="tFunoText_alphabetisch_space">
		<xsl:param name="pNode"/>

		<xsl:text>Lücke von ca. </xsl:text>
		<xsl:value-of select="$pNode/@quantity"/>
		<xsl:text> </xsl:text>
		<xsl:choose>
			<xsl:when test="$pNode/@unit='chars'">
				<xsl:choose>
					<xsl:when test="$pNode/@quantity='1'">
						<!-- Singular -->
						<xsl:text>Buchstaben</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<!-- Plural -->
						<xsl:text>Buchstaben</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$pNode/@unit='words'">
				<xsl:choose>
					<xsl:when test="$pNode/@quantity='1'">
						<!-- Singular -->
						<xsl:text>Wort</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<!-- Plural -->
						<xsl:text>Wörtern</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$pNode/@quantity='1'">
						<!-- Singular -->
						<xsl:text>Einheit</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<!-- Plural -->
						<xsl:text>Einheiten</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="tFunoText_alphabetisch_unclear">
		<xsl:param name="pNode"/>

		<xsl:text>Lücke von ca. </xsl:text>
		<xsl:value-of select="$pNode/@quantity"/>
		<xsl:choose>
			<xsl:when test="$pNode/@unit='chars'">
				<xsl:choose>
					<xsl:when test="$pNode/@quantity='1'">
						<!-- Singular -->
						<xsl:text>Buchstaben</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<!-- Plural -->
						<xsl:text>Buchstaben</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$pNode/@unit='words'">
				<xsl:choose>
					<xsl:when test="$pNode/@quantity='1'">
						<!-- Singular -->
						<xsl:text>Wort</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<!-- Plural -->
						<xsl:text>Wörtern</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$pNode/@quantity='1'">
						<!-- Singular -->
						<xsl:text>Einheit</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<!-- Plural -->
						<xsl:text>Einheiten</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
	
	<xsl:template name="tFunoText_alphabetisch_choice">
		<xsl:param name="pNode"/>
		
		<xsl:text>gek. </xsl:text>
		<span class="textItalic">
			<xsl:value-of select="$pNode/tei:abbr"/>
		</span>
			
	</xsl:template>
	
	<xsl:template name="tFunoText_alphabetisch_handShift">
		<xsl:param name="pNode"/>
		
		<xsl:text>Im folgenden Schreiberwechsel zu Hand </xsl:text>
		<span class="textItalic">
			<xsl:value-of select="$pNode/@new"/>
		</span>
		<xsl:text>.</xsl:text>
		
	</xsl:template>



	<xsl:template name="tFunoText_numerisch">
		<xsl:param name="pNode"/>
		<xsl:choose>
			<xsl:when test="local-name($pNode)='note'">
				<!--<xsl:text>{note @type=comment}</xsl:text> <!-\- TESTWEISE -\->-->
				<xsl:apply-templates select="$pNode/node()"/>
			</xsl:when>
			<xsl:when test="local-name($pNode)='ref'">
				<!--<xsl:text>{ref}</xsl:text> <!-\- TESTWEISE -\->-->
				<xsl:apply-templates select="$pNode/node()"/>
			</xsl:when>

		</xsl:choose>
	</xsl:template>

	<xsl:template name="tMengenangabe">
		<xsl:param name="pNode"/>

		<!-- BSP: "5 Wörter"/"1 Buchstabe"/"2 Einheiten" -->
		<xsl:value-of select="$pNode/@quantity"/>
		<xsl:text> </xsl:text>
		<xsl:choose>
			<xsl:when test="$pNode/@unit='chars'">
				<xsl:choose>
					<xsl:when test="$pNode/@quantity='1'">
						<xsl:text>Buchstabe</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>Buchstaben</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$pNode/@unit='words'">
				<xsl:choose>
					<xsl:when test="$pNode/@quantity='1'">
						<xsl:text>Wort</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>Wörter</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$pNode/@quantity='1'">
						<xsl:text>Einheit</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>Einheiten</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="tTooltip">
		<!-- Tooltip/Title in <a> aufhübschen -->
		<xsl:param name="pNode"/>

		<xsl:for-each select="$pNode/node()">
			<!--<xsl:value-of select="."/>-->

			<xsl:choose>
				<!--<xsl:when test="./child::node()">-->
				<xsl:when test="node()">
					<xsl:call-template name="tTooltip">
						<xsl:with-param name="pNode" select="."/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="contains(.,'&#xA;')">
							<!-- Zeilenumbruchszeichen ersetzen! -->
							<xsl:variable name="vOhneZeilenumbruch">
								<xsl:call-template name="string-replace">
									<xsl:with-param name="string" select="."/>
									<xsl:with-param name="replace" select="'&#xA;'"/>
									<xsl:with-param name="with" select="' '"/>
								</xsl:call-template>
							</xsl:variable>

							<xsl:variable name="vLeerzeichenReduziert">
								<xsl:call-template name="tKillWhitespace">
									<xsl:with-param name="pText" select="$vOhneZeilenumbruch"/>
								</xsl:call-template>
							</xsl:variable>

							<xsl:value-of select="$vLeerzeichenReduziert"/>

						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="."/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

	</xsl:template>

	<xsl:template name="tKillWhitespace">
		<!-- entfernt unnötige Leerzeichen aus Text-Element -->
		<xsl:param name="pText"/>

		<xsl:variable name="vLeerzeichenHalbiert">
			<xsl:call-template name="string-replace">
				<xsl:with-param name="string" select="$pText"/>
				<xsl:with-param name="replace" select="'  '"/>
				<xsl:with-param name="with" select="' '"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="string-length($vLeerzeichenHalbiert)!=string-length($pText)">
				<!-- noch doppelte Leerzeichen vorhanden -->

				<xsl:call-template name="tKillWhitespace">
					<xsl:with-param name="pText" select="$vLeerzeichenHalbiert"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- keine doppelten Leerzeichen mehr vorhanden -->
				<xsl:value-of select="$pText"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>


<!--	<xsl:template name="tLeerzeichenDavorOderDanach">
		<xsl:param name="pNode"/>

		<xsl:value-of select="(substring($pNode/preceding-sibling::text()[1],string-length($pNode/preceding-sibling::text()[1]),1)!=' ') and (substring($pNode/following-sibling::text()[1],string-length($pNode/following-sibling::text()[1]),1)!=' ')"/>

		<!-\- (substring(preceding-sibling::text()[1],string-length(preceding-sibling::text()[1]),1)!=' ') and (substring(following-sibling::text()[1],string-length(following-sibling::text()[1]),1)!=' ') -\->
	</xsl:template>-->

	<xsl:template name="tLeerzeichenDavorOderDanach">
		<xsl:param name="pNode"/>

		<xsl:variable name="vLeerzeichenDavor">
			<xsl:call-template name="tLeerzeichenDavor">
				<xsl:with-param name="pNode" select="$pNode"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="vLeerzeichenDanach">
			<xsl:call-template name="tLeerzeichenDanach">
				<xsl:with-param name="pNode" select="$pNode"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$vLeerzeichenDavor='true'">
				<xsl:value-of select="true()"/>
			</xsl:when>
			<xsl:when test="$vLeerzeichenDanach='true'">
				<xsl:value-of select="true()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="false()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="tLeerzeichenDavorUndDanach">
		<xsl:param name="pNode"/>

		<xsl:variable name="vLeerzeichenDavor">
			<xsl:call-template name="tLeerzeichenDavor">
				<xsl:with-param name="pNode" select="$pNode"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="vLeerzeichenDanach">
			<xsl:call-template name="tLeerzeichenDanach">
				<xsl:with-param name="pNode" select="$pNode"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$vLeerzeichenDavor='true' and $vLeerzeichenDanach='true'">
				<xsl:value-of select="true()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="false()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="tGanzesWort">
		<xsl:param name="pNode"/>
		<xsl:param name="pWortMitte"/>

		<xsl:variable name="vPrecedingWortteil">
			<xsl:call-template name="tPrecedingWortteil">
				<xsl:with-param name="pPrecedingTextThis" select="$pNode/preceding::text()[1]"/>
				<xsl:with-param name="pPrecedingTextBeforeNode" select="''"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="vFollowingWortteil">
			<xsl:call-template name="tFollowingWortteil">
				<xsl:with-param name="pFollowingTextThis" select="$pNode/following::text()[1]"/>
				<xsl:with-param name="pFollowingTextBeforeNode" select="''"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:value-of select="$vPrecedingWortteil"/>
		<xsl:if test="string-length($pWortMitte)>0">
			<xsl:choose>
				<xsl:when test="count($pWortMitte/*)>0">
					<xsl:apply-templates select="$pWortMitte/node()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="count($pWortMitte/node())=0">
							<xsl:text>#</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$pWortMitte"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:value-of select="$vFollowingWortteil"/>
	</xsl:template>

	<xsl:template name="tGanzesWort_subst">
		<xsl:param name="pNode"/>
		<xsl:param name="pWortMitte"/>

		<xsl:variable name="vPrecedingWortteil">
			<xsl:call-template name="tPrecedingWortteil">
				<xsl:with-param name="pPrecedingTextThis" select="$pNode/preceding::text()[1]"/>
				<xsl:with-param name="pPrecedingTextBeforeNode" select="''"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="vFollowingWortteil">
			<xsl:call-template name="tFollowingWortteil">
				<xsl:with-param name="pFollowingTextThis" select="$pNode/following::text()[1]"/>
				<xsl:with-param name="pFollowingTextBeforeNode" select="''"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:value-of select="$vPrecedingWortteil"/>
<!--		<xsl:if test="string-length($pWortMitte)>0">-->
			<xsl:choose>
				<xsl:when test="count($pWortMitte/*)>0">
					<xsl:apply-templates select="$pWortMitte/node()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="count($pWortMitte/node())=0">
							<xsl:text>#</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$pWortMitte"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		<!--</xsl:if>-->
		<xsl:value-of select="$vFollowingWortteil"/>
	</xsl:template>

	<xsl:template name="tPrecedingWortteil_fromThis">
		<xsl:param name="pPrecedingTextThis"/>
		<xsl:param name="pPrecedingTextBeforeNode"/>

		<!-- use as first instance of tPrecedingWortteil -->

		<!-- BAUSTELLE: testes -->
		<!-- 1) erstes Element wird zum Teil wiederholt! -->
		<!-- 2) Was passiert, wenn das (erste) Element selbst schon ein Leerzeichen beinhaltet?! => !!!!!!!!!!!!!!!!!!! -->

		<!--<span class="debug"><xsl:text>{</xsl:text></span>-->

		<xsl:choose>
			<xsl:when test="contains($pPrecedingTextThis,' ')">

				<xsl:variable name="vSubstringAfterLast">
					<xsl:call-template name="tSubstringAfterLast">
						<xsl:with-param name="pString" select="$pPrecedingTextThis"/>
						<xsl:with-param name="pString2" select="' '"/>
					</xsl:call-template>
				</xsl:variable>

				<xsl:value-of select="$vSubstringAfterLast"/>
				<xsl:value-of select="$pPrecedingTextBeforeNode"/>
			</xsl:when>
			<xsl:when test="contains($pPrecedingTextThis,'&#xa;')">

				<xsl:variable name="vSubstringAfterLast">
					<xsl:call-template name="tSubstringAfterLast">
						<xsl:with-param name="pString" select="$pPrecedingTextThis"/>
						<xsl:with-param name="pString2" select="'&#xa;'"/>
					</xsl:call-template>
				</xsl:variable>

				<xsl:value-of select="$vSubstringAfterLast"/>
				<xsl:value-of select="$pPrecedingTextBeforeNode"/>
			</xsl:when>


			<xsl:otherwise>

				<xsl:call-template name="tPrecedingWortteil">
					<xsl:with-param name="pPrecedingTextThis" select="$pPrecedingTextThis/preceding::text()[local-name(.)!='note'][1]"/>
<!--					<xsl:with-param name="pPrecedingTextBeforeNode">
						<xsl:choose>
							<xsl:when test="count($pPrecedingTextThis/node())>0">
								<xsl:apply-templates select="$pPrecedingTextThis/node()"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$pPrecedingTextThis"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="$pPrecedingTextBeforeNode"/>
					</xsl:with-param>-->
					<xsl:with-param name="pPrecedingTextBeforeNode" select="''"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

		<!--<span class="debug"><xsl:text>}</xsl:text></span>-->
	</xsl:template>

	<xsl:template name="tFollowingWortteil_fromThis">
		<xsl:param name="pFollowingTextThis"/>
		<xsl:param name="pFollowingTextBeforeNode"/>

		<!-- use as first instance of tFollowingWortteil -->

		<xsl:choose>
			<xsl:when test="contains($pFollowingTextThis,' ')">
				<xsl:variable name="vSubstringBefore">
					<!--<xsl:value-of select="substring-before($pFollowingTextThis,' ')"/>-->
					<!--<xsl:value-of select="substring-before(concat($pFollowingTextThis,' '),' ')"/>-->
					<!--<xsl:value-of select="substring($pFollowingTextThis,1,1)"/>-->
					<xsl:value-of select="normalize-space(substring-before($pFollowingTextThis,' '))"/>
				</xsl:variable>

				<xsl:value-of select="$pFollowingTextBeforeNode"/>
				<xsl:value-of select="$vSubstringBefore"/>
			</xsl:when>
			<xsl:when test="contains($pFollowingTextThis,'&#xa;')">
				<xsl:variable name="vSubstringBefore">
					<xsl:value-of select="normalize-space(substring-before($pFollowingTextThis,'&#xa;'))"/>
				</xsl:variable>

				<xsl:value-of select="$pFollowingTextBeforeNode"/>
				<xsl:value-of select="$vSubstringBefore"/>
			</xsl:when>

			<xsl:otherwise>
				<xsl:call-template name="tFollowingWortteil">
					<xsl:with-param name="pFollowingTextThis" select="$pFollowingTextThis/following::text()[local-name(.)!='note'][1]"/>
<!--					<xsl:with-param name="pPrecedingTextBeforeNode">
						<xsl:value-of select="$pFollowingTextBeforeNode"/>
						<xsl:choose>
							<xsl:when test="count($pFollowingTextThis/node())>0">
								<xsl:apply-templates select="$pFollowingTextThis/node()"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$pFollowingTextThis"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>-->
					<xsl:with-param name="pFollowingTextBeforeNode" select="''"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="tPrecedingWortteil">
		<xsl:param name="pPrecedingTextThis"/>
		<xsl:param name="pPrecedingTextBeforeNode"/>

		<!-- BAUSTELLE: testes -->
		<!-- 2) Was passiert, wenn das (erste) Element selbst schon ein Leerzeichen beinhaltet?! => !!!!!!!!!!!!!!!!!!! -->
		<!-- 3) <lb>-Problematik -->

		<!--<span class="debug"><xsl:text>{</xsl:text></span>-->

		<xsl:choose>
			<xsl:when test="contains($pPrecedingTextThis,' ')">

				<xsl:variable name="vSubstringAfterLast">
					<xsl:call-template name="tSubstringAfterLast">
						<xsl:with-param name="pString" select="$pPrecedingTextThis"/>
						<xsl:with-param name="pString2" select="' '"/>
					</xsl:call-template>
				</xsl:variable>

				<xsl:value-of select="$vSubstringAfterLast"/>
				<xsl:value-of select="$pPrecedingTextBeforeNode"/>
			</xsl:when>
			<xsl:when test="contains($pPrecedingTextThis,'&#xa;')">

				<xsl:variable name="vSubstringAfterLast">
					<xsl:call-template name="tSubstringAfterLast">
						<xsl:with-param name="pString" select="$pPrecedingTextThis"/>
						<xsl:with-param name="pString2" select="'&#xa;'"/>
					</xsl:call-template>
				</xsl:variable>

				<xsl:value-of select="$vSubstringAfterLast"/>
				<xsl:value-of select="$pPrecedingTextBeforeNode"/>
			</xsl:when>
			<xsl:otherwise>

				<!-- can't be "produced" in with-param...for unknown reason -->
				<xsl:variable name="vPrecedingTextBeforeNode">
					<xsl:choose>
						<xsl:when test="count($pPrecedingTextThis/node())>0">
							<xsl:apply-templates select="$pPrecedingTextThis/node()"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$pPrecedingTextThis"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="$pPrecedingTextBeforeNode"/>
				</xsl:variable>

				<xsl:call-template name="tPrecedingWortteil">
					<xsl:with-param name="pPrecedingTextThis" select="$pPrecedingTextThis/preceding::text()[local-name(.)!='note'][1]"/>
<!--					<xsl:with-param name="pPrecedingTextBeforeNode">
						<xsl:choose>
							<xsl:when test="count($pPrecedingTextThis/node())>0">
								<xsl:apply-templates select="$pPrecedingTextThis/node()"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$pPrecedingTextThis"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="$pPrecedingTextBeforeNode"/>
					</xsl:with-param>-->
					<xsl:with-param name="pPrecedingTextBeforeNode" select="$vPrecedingTextBeforeNode"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

		<!--<span class="debug"><xsl:text>}</xsl:text></span>-->
	</xsl:template>

	<xsl:template name="tFollowingWortteil">
		<xsl:param name="pFollowingTextThis"/>
		<xsl:param name="pFollowingTextBeforeNode"/>

		<xsl:choose>
			<xsl:when test="contains($pFollowingTextThis,' ')">
				<xsl:variable name="vSubstringBefore">
					<!--<xsl:value-of select="substring-before($pFollowingTextThis,' ')"/>-->
					<!--<xsl:value-of select="substring-before(concat($pFollowingTextThis,' '),' ')"/>-->
					<!--<xsl:value-of select="substring($pFollowingTextThis,1,1)"/>-->
					<xsl:value-of select="normalize-space(substring-before($pFollowingTextThis,' '))"/>
				</xsl:variable>

				<xsl:value-of select="$pFollowingTextBeforeNode"/>
				<xsl:value-of select="$vSubstringBefore"/>
			</xsl:when>
			<xsl:when test="contains($pFollowingTextThis,'&#xa;')">
				<xsl:variable name="vSubstringBefore">
					<xsl:value-of select="normalize-space(substring-before($pFollowingTextThis,'&#xa;'))"/>
				</xsl:variable>

				<xsl:value-of select="$pFollowingTextBeforeNode"/>
				<xsl:value-of select="$vSubstringBefore"/>
			</xsl:when>



			<xsl:otherwise>

<!--				<xsl:variable name="test" select="$pFollowingTextThis/self::*"/>
				<xsl:variable name="test2" select="$pFollowingTextThis/self::node()"/>

				<xsl:variable name="test3" select="$pFollowingTextThis"/>

				<xsl:variable name="test4">
					<xsl:value-of select="$pFollowingTextThis"/>
				</xsl:variable>
				<xsl:variable name="test5">
					<xsl:value-of select="$pFollowingTextThis/node()"/>
				</xsl:variable>
				<xsl:variable name="test6">
					<xsl:value-of select="exslt:node-set($pFollowingTextThis)"/>
				</xsl:variable>
				<xsl:variable name="test7">
					<xsl:value-of select="exslt:node-set($pFollowingTextThis/node())"/>
				</xsl:variable>-->


				<!-- can't be "produced" in with-param...for unknown reason -->
				<xsl:variable name="vFollowingTextBeforeNode">
					<xsl:value-of select="$pFollowingTextBeforeNode"/>
					<xsl:choose>
						<xsl:when test="count($pFollowingTextThis/node())>0">
							<xsl:apply-templates select="$pFollowingTextThis/node()"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$pFollowingTextThis"/>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:variable>

				<xsl:call-template name="tFollowingWortteil">
					<xsl:with-param name="pFollowingTextThis" select="$pFollowingTextThis/following::text()[local-name(.)!='note'][1]"/>
<!--					<xsl:with-param name="pPrecedingTextBeforeNode">
<!-\-						<xsl:value-of select="$pFollowingTextBeforeNode"/>
						<xsl:choose>
							<xsl:when test="count($pFollowingTextThis/node())>0">
								<xsl:apply-templates select="$pFollowingTextThis/node()"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$pFollowingTextThis"/>
							</xsl:otherwise>
						</xsl:choose>-\->
						<xsl:value-of select="$test8"/>
					</xsl:with-param>-->
					<xsl:with-param name="pFollowingTextBeforeNode" select="$vFollowingTextBeforeNode"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="tSubstringAfterLast">
		<xsl:param name="pString"/>
		<xsl:param name="pString2"/>

		<xsl:choose>
			<xsl:when test="contains($pString,$pString2)">
				<!-- pString2 in pString enthalten -->

				<xsl:variable name="vSubstringAfter" select="substring-after($pString,$pString2)"/>
				<xsl:choose>
					<xsl:when test="contains($vSubstringAfter,$pString2)">
						<!-- weiterer pString2 in pString bzw. vSubstringAfter enthalten -->
						<!-- => Rekursion => tSubstringAfterLast nochmals mit gekürztem String aufrufen -->
						<xsl:call-template name="tSubstringAfterLast">
							<xsl:with-param name="pString" select="$vSubstringAfter"/>
							<xsl:with-param name="pString2" select="$pString2"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<!-- letzter SubstringAfter erreicht -->
						<xsl:value-of select="$vSubstringAfter"/>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:when>
			<xsl:otherwise>
				<!-- falls pString2 gar nicht in pString enthalten ist -->
				<!-- ??? wie wird das in der normalen Substring-After Funktion gelöst?! => entsprechend anapssen? => empty string -->
				<xsl:text></xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>



	<xsl:template name="tWortUmKnoten">
		<!-- gibt das Wort aus, innerhalb dessen sich die getaggte Zeichenkette/das getaggte Zeichen befinden => ACHTUNG: Benötigt text() vor und nach Knoten!-->
		<xsl:param name="pKnoten"></xsl:param>


<!--		<xsl:call-template name="LastSubstringAfter">
			<!-\-<xsl:with-param name="pString" select="."/>-\->
			<xsl:with-param name="pString" select="./preceding-sibling::text()[1]"/>
			<xsl:with-param name="pCharacter"><xsl:text> </xsl:text></xsl:with-param>
		</xsl:call-template>-->

<!--		<xsl:if test="not(substring($pKnoten/text(),1,1)=' ')">
			<!-\- für Fälle wie "<add> habere</add>" deutet das Leerzeichen darauf hin, dass sich der Wortanfang innerhalb des Elements/Knotens befindet bzw. erst nach eben diesem Leerzeichen folgt -\->
			<xsl:call-template name="LastSubstringAfter">
				<!-\-<xsl:with-param name="pString" select="."/>-\->
				<xsl:with-param name="pString" select="./preceding-sibling::text()[1]"/>
				<xsl:with-param name="pCharacter"><xsl:text> </xsl:text></xsl:with-param>
			</xsl:call-template>
		</xsl:if>-->

		<xsl:variable name="vVorWort">
			<!-- BAUSTELLE: Es wird nicht EINDEUTIG, dass text()[1] sich direkt vor dem Knoten befindet! Könnte sich auch um den ersten text() hinter/in einem anderen Element handeln?!? -->
			<!-- ODER: Doch?! Wäre ja auch okay, wenn es sich auf irgendwelchen Text bezieht...oder?! -->
			<!-- im Moment würde vermutlich ein anderes Element mit Text bzw. der Text darin nicht in den Test mit einbezogen?!? -->

			<!--<xsl:text>{vVorWort}</xsl:text> <!-\- TESTWEISE -\->-->

			<xsl:choose>
				<!--<xsl:when test="local-name($pKnoten/parent::*)='subst' or local-name($pKnoten/parent::*)='num'"> 19.12.2014, 17:30-->
				<xsl:when test="(local-name($pKnoten/parent::*)='subst' or local-name($pKnoten/parent::*)='num') and (local-name($pKnoten)='add' or local-name($pKnoten)='del')">
					<!-- text()/Sibling eine Ebene höher -->
					<xsl:choose>
						<xsl:when test="string-length($pKnoten/parent::*/preceding-sibling::text()[1])=string-length(translate($pKnoten/parent::*/preceding-sibling::text()[1],' ',''))">
							<!-- kein Leerzeichen => vorhergehender text() gehört vermutlich auch noch dazu -->
							<xsl:value-of select="concat($pKnoten/parent::*/preceding-sibling::text()[1],$pKnoten/parent::*/preceding-sibling::text()[2])"/> <!-- BAUSTELLE: NICHT VOLLSTÄNDIG! -->
						</xsl:when>
						<xsl:otherwise>
							<!-- Leerzeichen => beinhaltet gesamten Wortanfang (bis bzw. ab Leerzeichen) -->
							<xsl:value-of select="$pKnoten/parent::*/preceding-sibling::text()[1]"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- text()/Sibling auf der selben Ebene -->
					<xsl:choose>
						<xsl:when test="string-length($pKnoten/parent::*/preceding-sibling::text()[1])=string-length(translate($pKnoten/parent::*/preceding-sibling::text()[1],' ',''))">
							<!-- kein Leerzeichen => vorhergehender text() gehört vermutlich auch noch dazu -->
							<xsl:value-of select="concat($pKnoten/preceding-sibling::text()[2],$pKnoten/preceding-sibling::text()[1],'')"/> <!-- BAUSTELLE: NICHT VOLLSTÄNDIG! -->
						</xsl:when>
						<xsl:otherwise>
							<!-- Leerzeichen => beinhaltet gesamten Wortanfang (bis bzw. ab Leerzeichen) -->
							<xsl:value-of select="$pKnoten/preceding-sibling::text()[1]"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>

			<!--<xsl:text>{/vVorWort}</xsl:text> <!-\- TESTWEISE -\->-->
		</xsl:variable>

		<xsl:variable name="vWortUmKnoten">

			<!--<xsl:text>{vWortUmKnoten}</xsl:text> <!-\- TESTWEISE -\->-->

			<xsl:choose>
				<!--<xsl:when test="substring($pKnoten/preceding-sibling::text()[1],string-length($pKnoten/preceding-sibling::text()[1]),1)=' '">-->
				<xsl:when test="substring($vVorWort,string-length($vVorWort),1)=' '">
					<!--  -->

					<!--<xsl:text>{' '}</xsl:text> <!-\- TESTWEISE -\->-->
				</xsl:when>
				<xsl:when test="not(substring($pKnoten/text(),1,1)=' ')">
					<!-- für Fälle wie "<add> habere</add>" deutet das Leerzeichen darauf hin, dass sich der Wortanfang innerhalb des Elements/Knotens befindet bzw. erst nach eben diesem Leerzeichen folgt -->
					<xsl:variable name="vWortanfang">
						<xsl:call-template name="tLastSubstringAfter">
							<!--<xsl:with-param name="pString" select="."/>-->
							<!--<xsl:with-param name="pString" select="./preceding-sibling::text()[1]"/>-->
							<xsl:with-param name="pString" select="$vVorWort"/>
							<xsl:with-param name="pCharacter"><xsl:text> </xsl:text></xsl:with-param>
						</xsl:call-template>
					</xsl:variable>

					<!--<xsl:text>{$vWortanfang}</xsl:text>-->
					<xsl:value-of select="exslt:node-set($vWortanfang)//text()"/>
					<!--<xsl:value-of select="exslt:node-set($vWortanfang)"/>-->
					<!--<xsl:text>{/$vWortanfang}</xsl:text>-->
				</xsl:when>
			</xsl:choose>

			<!--<xsl:text>{$pKnoten}</xsl:text>-->

<!--	...doch nicht. Oo 19.12.2014,18:10		<xsl:choose>
				<xsl:when test="(local-name($pKnoten/parent::*)='subst' or local-name($pKnoten/parent::*)='num') and (local-name($pKnoten)='add' or local-name($pKnoten)='del')">
					<!-\- innerhalb <subst> oder <num> -\->

					<xsl:value-of select="$pKnoten"/>
				</xsl:when>
				<xsl:otherwise>
					<!-\- alleinstehend -\->
					<xsl:value-of select="$pKnoten"/>
				</xsl:otherwise>
			</xsl:choose>-->

			<xsl:value-of select="$pKnoten"/>
			<!--<xsl:text>{/$pKnoten}</xsl:text>-->
			<!--<xsl:value-of select="substring-before(./following-sibling::text()[1],' ')"/>-->

			<xsl:variable name="vWortende">
				<xsl:value-of select="substring-before(./following-sibling::text()[1],' ')"/>
			</xsl:variable>
			<!--<xsl:text>{$vWortende}</xsl:text>-->
			<!--<xsl:value-of select="substring-before(./following-sibling::text()[1],' ')"/>-->
			<xsl:value-of select="$vWortende"/>
			<!--<xsl:text>{/$vWortende}</xsl:text>-->


			<!--<xsl:text>{/vWortUmKnoten}</xsl:text> <!-\- TESTWEISE -\->-->

		</xsl:variable>

		<!--<xsl:text>{$vWortUmKnoten}</xsl:text>-->
		<xsl:value-of select="$vWortUmKnoten"/>
		<!--<xsl:text>{/$vWortUmKnoten}</xsl:text>	-->


	</xsl:template>

	<xsl:template name="tNoteFolgt">
		<xsl:param name="pNode"/>
		<!-- WICHTIG: Zu Node/Element zugehörige <note> hängt am Ende des Wortes oder Elements => Es gibt dazwischen im text() kein Leerzeichen (=' ')! -->

		<!--<xsl:variable name="vTextNachKnotenVorNote" select="$pNode/following-sibling::text()"/>-->


		<xsl:choose>
			<xsl:when test="local-name($pNode/following-sibling::node()[local-name(.)!='lb'][1])='note'">
				<!-- <note> folgt direkt -->
				<xsl:value-of select="true()"/>
			</xsl:when>
			<xsl:when test="(string-length($pNode/following-sibling::node()[local-name(.)!='lb'][1])=string-length(translate($pNode/following-sibling::node()[local-name(.)!='lb'][1],' ',''))) and (local-name($pNode/following-sibling::*[local-name(.)!='lb'][1])='note')">
				<!-- BAUSTELLE: explizit!!! text() als erste node() -->
				<!-- nächstes node() ist Text ohne Leerzeichen, darauf folgt als erstes * direkt <note> -->
				<xsl:value-of select="true()"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- BAUSTELLE: <note> direkt nach text() ohne Leerzeichen wird nicht erkannt!! (Wieso auch immer?!?) => bisherige Notlösung: 2. when-Klausel eingefügt, die diesen Fall abdeckt => ABER: nicht optimal! Algorithmus sollte auch so funktionieren?! -->
				<xsl:variable name="vTextNachKnoten" select="$pNode/following-sibling::text()[generate-id($pNode)=generate-id(./preceding-sibling::*[local-name(.)='subst' or local-name(.)='add' or local-name(.)='del' or local-name(.)='mod'][1])]"/>
				<xsl:variable name="vTextNachKnotenSTR" select="string($vTextNachKnoten)"/>

				<xsl:variable name="vTextNachKnotenVorNote">
					<!--<xsl:for-each select="$pNode/following-sibling::text()[generate-id($pNode)=generate-id(preceding-sibling::*[./name()='subst' or ./name()='add' or ./name()='del' or ./name()='mod'][1])][count(./following-sibling::tei:note)>0]">-->
					<!--<xsl:for-each select="$vTextNachKnoten[count(./following-sibling::tei:note)>0]">-->
					<!--<xsl:for-each select="$vTextNachKnoten[count(following-sibling::tei:note[generate-id($pNode)=generate-id(preceding-sibling::*[local-name(.)='subst' or local-name(.)='add' or local-name(.)='del' or local-name(.)='mod'][1])])>0]">-->
					<xsl:for-each select="$vTextNachKnoten[following-sibling::tei:note[generate-id($pNode)=generate-id(preceding-sibling::*[local-name(.)='subst' or local-name(.)='add' or local-name(.)='del' or local-name(.)='mod'][1])]]">

						<xsl:if test="string-length(.)>0">
							<xsl:value-of select="."/>
						</xsl:if>
					</xsl:for-each>

					<!--<xsl:value-of select="$vTextNachKnoten[following-sibling::tei:note[generate-id($pNode)=generate-id(preceding-sibling::*[local-name(.)='subst' or local-name(.)='add' or local-name(.)='del' or local-name(.)='mod'][1])]]"/>-->
				</xsl:variable>

				<xsl:choose>
					<xsl:when test="string-length($vTextNachKnotenVorNote)>0 and string-length($vTextNachKnotenVorNote)=string-length(translate($vTextNachKnotenVorNote,' ',''))">
						<!-- Zeichenkettte nach dem Ersetzen von ' ' durch '' gleich lang => kein ' ' in Zeichenkette vorhanden -->
						<!-- => nächste <note> gehört zu Knoten -->
						<xsl:value-of select="true()"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- ' ' in Zeichenkette vorhanden -->
						<!-- => nächste <note> gehört nicht zu Knoten -->
						<xsl:value-of select="false()"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="tLeerzeichenFolgt">
		<xsl:param name="pNode"/>

		<xsl:variable name="vFollText1" select="$pNode/following-sibling::text()[1]"/>

		<xsl:choose>
			<xsl:when test="substring($vFollText1,1,1)=' '">
				<!-- Leerzeichen ist erstes nachfolgendes Zeichen -->
				<xsl:value-of select="true()"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- Wortrest folgt -->
				<xsl:value-of select="false()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="tLeerzeichenDanach">
		<xsl:param name="pNode"/>

		<xsl:variable name="vFollText1" select="$pNode/following-sibling::text()[1]"/>

		<xsl:variable name="vFollText1FirstLetter" select="substring($vFollText1,1,1)"/>

<!--		<xsl:variable name="vCountNodesFollText1" select="count($vFollText1/node())"/>
		<xsl:variable name="vStringLengthFollText1" select="string-length($vFollText1)"/>-->

		<xsl:choose>
			<xsl:when test="count($vFollText1/node())=0 and string-length($vFollText1) &lt; 1">
				<!-- gar kein node() enthalten (z.B. wenn der zuvor geprüfte Knoten gar keine siblings mehr hat -->
				<!--<xsl:value-of select="false()"/>-->
				<xsl:value-of select="true()"/>
			</xsl:when>
			<xsl:when test="contains($vFollText1,' ')='true' or contains($vFollText1,'&#xA;')='true'">
				<xsl:choose>
					<xsl:when test="$vFollText1FirstLetter=' ' or $vFollText1FirstLetter='&#xA;'">
						<!-- Leerzeichen oder Zeilenumbruch (=Leerzeichen) ist erstes nachfolgendes Zeichen -->
						<xsl:value-of select="true()"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- Wortrest folgt -->
						<xsl:value-of select="false()"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
<!--			<xsl:when test="contains($vFollText1,'&#xA;')='true'">
				<xsl:choose>
					<xsl:when test="$vFollText1FirstLetter=' '">
						<!-\- Leerzeichen ist erstes nachfolgendes Zeichen -\->
						<xsl:value-of select="true()"/>
					</xsl:when>
					<xsl:otherwise>
						<!-\- Wortrest folgt -\->
						<xsl:value-of select="false()"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>-->

			<xsl:otherwise>
				<!-- text() enthält gar kein Leerzeichen => muss in einem späteren text() folgen -->
<!--				<xsl:call-template name="tLeerzeichenDanach">
					<xsl:with-param name="pNode" select="$pNode/following-sibling::text()[1]"/>
				</xsl:call-template>-->

				<xsl:value-of select="false()"/>
			</xsl:otherwise>

<!--			<xsl:when test="contains($vFollText1,' ')='false'">
				<!-\- text() enthält gar kein Leerzeichen => muss in einem späteren text() folgen -\->
				<xsl:call-template name="tLeerzeichenDanach">
					<xsl:with-param name="pNode" select="$pNode/following-sibling::text()[1]"/>
				</xsl:call-template>
			</xsl:when>

			<xsl:otherwise>
				<xsl:text>***FEHLER IN tLeerzeichenDanach***</xsl:text>
			</xsl:otherwise>-->
		</xsl:choose>


	</xsl:template>

	<xsl:template name="tLeerzeichenDavor">
		<xsl:param name="pNode"/>

		<xsl:variable name="vPrecText1" select="$pNode/preceding-sibling::text()[1]"/>

		<xsl:variable name="vPrecText1LastLetter" select="substring($vPrecText1,string-length($vPrecText1),1)"/>


<!--		<xsl:variable name="vCountNodesPrecText1" select="count($vPrecText1/node())"/>
		<xsl:variable name="vStringLengthPrecText1" select="string-length($vPrecText1)"/>-->

		<xsl:choose>
			<xsl:when test="count($vPrecText1/node())=0 and string-length($vPrecText1) &lt; 1">
				<!-- gar kein node() enthalten (z.B. wenn der zuvor geprüfte Knoten gar keine siblings mehr hat -->
				<!--<xsl:value-of select="false()"/>-->
				<xsl:value-of select="true()"/>
			</xsl:when>
			<xsl:when test="contains($vPrecText1,' ')='true' or contains($vPrecText1,'&#xA;')='true'">
				<xsl:choose>
					<xsl:when test="$vPrecText1LastLetter=' ' or $vPrecText1LastLetter='&#xA;'">
						<!-- Leerzeichen oder Zeilenumbruch (=Leerzeichen) ist erstes vorhergehendes Zeichen -->
						<xsl:value-of select="true()"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- Wortrest folgt -->
						<xsl:value-of select="false()"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
<!--			<xsl:when test="contains($vPrecText1,'&#xA;')='true'">
				<xsl:choose>
					<xsl:when test="$vPrecText1LastLetter=' '">
						<!-\- Leerzeichen ist erstes nachfolgendes Zeichen -\->
						<xsl:value-of select="true()"/>
					</xsl:when>
					<xsl:otherwise>
						<!-\- Wortrest folgt -\->
						<xsl:value-of select="false()"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>-->

			<xsl:otherwise>
				<!-- text() enthält gar kein Leerzeichen => muss in einem früheren text() folgen -->
<!--				<xsl:call-template name="tLeerzeichenDavor">
					<xsl:with-param name="pNode" select="$pNode/preceding-sibling::text()[1]"/>
				</xsl:call-template>   ??? Warum habe (/hatte) ich dieses Template rekursiv angelegt?! ??? -->

				<xsl:value-of select="false()"/>
			</xsl:otherwise>

<!--			<xsl:when test="contains($vPrecText1,' ')='false'">
				<!-\- text() enthält gar kein Leerzeichen => muss in einem früheren text() folgen -\->
				<xsl:call-template name="tLeerzeichenDavor">
					<xsl:with-param name="pNode" select="$pNode/preceding-sibling::text()[1]"/>
				</xsl:call-template>
			</xsl:when>

			<xsl:otherwise>
				<xsl:text>***FEHLER IN tLeerzeichenDavor***</xsl:text>
			</xsl:otherwise>-->
		</xsl:choose>







<!--
		<xsl:choose>
			<!-\-<xsl:when test="substring($vPrecText1,string-length($vPrecText1),1)=' '">-\->
			<xsl:when test="$vPrecText1LastLetter=' '">
				<!-\- Leerzeichen ist erstes Zeichen vor Knoten -\->
				<xsl:value-of select="true()"/>
			</xsl:when>
			<xsl:otherwise>
				<!-\- Wortrest davor -\->
				<xsl:value-of select="false()"/>
			</xsl:otherwise>
		</xsl:choose>-->





	</xsl:template>

	<xsl:template name="tRend">
		<!-- @rend ins Deutsche übersetzen -->
		<xsl:param name="pAttribut"/>

		<xsl:choose>
			<xsl:when test="$pAttribut='scratched'">
				<xsl:text>radiert</xsl:text>
			</xsl:when>
			<xsl:when test="$pAttribut='expunged'">
				<xsl:text>expungiert</xsl:text>
			</xsl:when>
			<xsl:when test="$pAttribut='strikethrough'">
				<xsl:text>gestrichen</xsl:text>
			</xsl:when>
			<xsl:when test="$pAttribut='underlined'">
				<xsl:text>durch Unterstreichung getilgt</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="tUnit">
		<!-- @unit ins Deutsche übersetzen -->
		<xsl:param name="pAttribut"/>

		<xsl:choose>
			<xsl:when test="$pAttribut='chars'">
				<xsl:text>Buchstaben</xsl:text>
			</xsl:when>
			<xsl:when test="$pAttribut='pages'">
				<xsl:text>Seiten</xsl:text>
			</xsl:when>
			<xsl:when test="$pAttribut='words'">
				<xsl:text>Wörter</xsl:text>
			</xsl:when>
			<!-- etc. -->
		</xsl:choose>
	</xsl:template>

	<xsl:template name="tPlace">
		<!-- @place ins Deutsche übersetzen -->
		<xsl:param name="pAttribut"/>

		<xsl:choose>
			<xsl:when test="$pAttribut='above'">
				<xsl:text>über der Zeile</xsl:text>
			</xsl:when>
			<xsl:when test="$pAttribut='margin'">
				<xsl:text>am Rand</xsl:text>
			</xsl:when>
			<xsl:when test="$pAttribut='inline'">
				<xsl:text>in der Zeile</xsl:text>
			</xsl:when>
			<xsl:when test="$pAttribut='inspace'">
				<xsl:text>in der Zeile in frei gelassenem Raum</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="tPrintXtimes">
		<xsl:param name="pPrintWhat"/>
		<xsl:param name="pPrintHowManyTimes"/>
		<xsl:param name="pCounter_UseDefault" select="1"/>

		<xsl:choose>
			<xsl:when test="$pCounter_UseDefault &lt; $pPrintHowManyTimes">
				<!-- $pCounter < $pPrintHowManyTimes -->

				<!-- print -->
				<xsl:value-of select="$pPrintWhat"/>

				<!-- call the template once more ... until $pPrintHowManyTimes is reached -->
				<xsl:call-template name="tPrintXtimes">
					<xsl:with-param name="pPrintWhat" select="$pPrintWhat"/>
					<xsl:with-param name="pPrintHowManyTimes" select="$pPrintHowManyTimes"/>
					<xsl:with-param name="pCounter_UseDefault" select="$pCounter_UseDefault+1"/>
				</xsl:call-template>

			</xsl:when>
			<xsl:when test="$pCounter_UseDefault = $pPrintHowManyTimes">
				<!-- $pCounter = $pPrintHowManyTimes -->

				<!-- one last print -->
				<xsl:value-of select="$pPrintWhat"/>

			</xsl:when>
			<xsl:otherwise>
				<!-- $pCounter > $pPrintHowManyTimes -->

				<!-- ...this shouldn't happen... -->

			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="tDate_YYYY-MM-DDtoDD-MM-YYYY">
		<xsl:param name="pDate_YYYY-MM-DD"/>
		<xsl:param name="pDelimiter" select="'/'"/>
		
		<xsl:variable name="vDay">
			<xsl:value-of select="substring($pDate_YYYY-MM-DD,9)"/>
		</xsl:variable>
		<xsl:variable name="vMonth">
			<xsl:value-of select="substring($pDate_YYYY-MM-DD,6,2)"/>
		</xsl:variable>
		<xsl:variable name="vYear">
			<xsl:value-of select="substring($pDate_YYYY-MM-DD,1,4)"/>
		</xsl:variable>
		
		<xsl:value-of select="$vDay"/>
		<xsl:value-of select="$pDelimiter"/>
		<xsl:value-of select="$vMonth"/>
		<xsl:value-of select="$pDelimiter"/>
		<xsl:value-of select="$vYear"/>
	</xsl:template>
	
	<xsl:template name="tDate_isYYYY-MM-DD">
		<xsl:param name="pDate"/>
		<xsl:param name="pDelimiter" select="'-'"/>
		
		<xsl:choose>
			<xsl:when test="substring($pDate,5,1)=$pDelimiter and substring($pDate,8,1)=$pDelimiter">
				<xsl:value-of select="true()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="false()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<xsl:template name="tPlatzhalterVerarbeiten">
		<xsl:param name="pText"/>
		
				
			
		<xsl:variable name="vText1">
			<xsl:call-template name="string-replace">
				<xsl:with-param name="string" select="$pText"/>
				<xsl:with-param name="replace" select="'.:'"/>
				<xsl:with-param name="with" select="'.·.'"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="vText2">
			<xsl:call-template name="string-replace">
				<xsl:with-param name="string" select="$vText1"/>
				<xsl:with-param name="replace" select="';.'"/>
				<xsl:with-param name="with" select="'·,·'"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="vText3">
			<xsl:call-template name="string-replace">
				<xsl:with-param name="string" select="$vText2"/>
				<xsl:with-param name="replace" select="'.'"/>
				<xsl:with-param name="with" select="'·'"/>
			</xsl:call-template>
		</xsl:variable>
		
<!--		<xsl:variable name="vText4">
			<xsl:call-template name="string-replace">
				<xsl:with-param name="string" select="$vText3"/>
				<xsl:with-param name="replace" select="'!'"/>
				<xsl:with-param name="with" select="'.|'"/>
			</xsl:call-template>
		</xsl:variable>-->
		
		<xsl:variable name="vText4">
			<xsl:call-template name="string-replace">
				<xsl:with-param name="string" select="$vText3"/>
				<xsl:with-param name="replace" select="'!'"/>
				<xsl:with-param name="with" select="'.-'"/>
			</xsl:call-template>
		</xsl:variable>
		
		
		<xsl:value-of select="$vText4"/>
		
	</xsl:template>
	
	<xsl:template name="tDate_Vergleich_1vor2">
		<xsl:param name="pDate1_YYYY-MM-DD"/>
		<xsl:param name="pDate2_YYYY-MM-DD"/>
		
		<xsl:variable name="vDate1_isYYY-MM-DD">
			<xsl:call-template name="tDate_isYYYY-MM-DD">
				<xsl:with-param name="pDate" select="$pDate1_YYYY-MM-DD"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="vDate2_isYYY-MM-DD">
			<xsl:call-template name="tDate_isYYYY-MM-DD">
				<xsl:with-param name="pDate" select="$pDate2_YYYY-MM-DD"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="vDay1">
			<xsl:value-of select="substring($pDate1_YYYY-MM-DD,9)"/>
		</xsl:variable>
		<xsl:variable name="vMonth1">
			<xsl:value-of select="substring($pDate1_YYYY-MM-DD,6,2)"/>
		</xsl:variable>
		<xsl:variable name="vYear1">
			<xsl:value-of select="substring($pDate1_YYYY-MM-DD,1,4)"/>
		</xsl:variable>
		
		<xsl:variable name="vDay2">
			<xsl:value-of select="substring($pDate2_YYYY-MM-DD,9)"/>
		</xsl:variable>
		<xsl:variable name="vMonth2">
			<xsl:value-of select="substring($pDate2_YYYY-MM-DD,6,2)"/>
		</xsl:variable>
		<xsl:variable name="vYear2">
			<xsl:value-of select="substring($pDate2_YYYY-MM-DD,1,4)"/>
		</xsl:variable>
		
		
		<xsl:choose>
			<xsl:when test="$vDate1_isYYY-MM-DD='true' and $vDate2_isYYY-MM-DD='true'">
				<xsl:choose>
					<xsl:when test="$vYear1 &lt; $vYear2">
						<xsl:value-of select="true()"/>
					</xsl:when>
					<xsl:when test="$vYear1 = $vYear2">
						<xsl:choose>
							<xsl:when test="$vMonth1 &lt; $vMonth2">
								<xsl:value-of select="true()"/>
							</xsl:when>
							<xsl:when test="$vMonth1 = $vMonth2">
								<xsl:choose>
									<xsl:when test="$vDay1 &lt; $vDay2">
										<xsl:value-of select="true()"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="false()"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="false()"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="false()"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>{Fehler in tDate_Vergleich_1vor2: Bitte übergebene Werte prüfen! (</xsl:text>
					<xsl:value-of select="$pDate1_YYYY-MM-DD"/>
					<xsl:text>|</xsl:text>
					<xsl:value-of select="$pDate2_YYYY-MM-DD"/>
					<xsl:text>)}</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	
	
	<xsl:template match="*">
		<ERROR>
			<xsl:comment>
				<xsl:text>ERROR: element '</xsl:text>
				<xsl:value-of select="local-name()"/>
				<xsl:text>' not handled</xsl:text>
			</xsl:comment>
			<xsl:apply-templates/>
			<xsl:comment>
				<xsl:value-of select="local-name()"/>
			</xsl:comment>
		</ERROR>
	</xsl:template>

</xsl:stylesheet>
