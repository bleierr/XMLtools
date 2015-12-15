<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="1.0">
    <xsl:output method="xml" version="1.0"
        encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements=""/>
    
    <xsl:template match="/tabel">
        <xsl:processing-instruction name="xml">
                <xsl:text>version="1.0" encoding="UTF-8"</xsl:text>
        </xsl:processing-instruction>
        
        <xsl:processing-instruction name="oxygen">
                <xsl:text>RNGSchema="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="xml"</xsl:text>
        </xsl:processing-instruction>
        
        
        <TEI>
            <xsl:call-template name="teiHeader"></xsl:call-template>
            
            <text>
                <body>
                    <div>
                        <listOrg>
                            <xsl:apply-templates></xsl:apply-templates>
                        </listOrg>
                    </div>
                </body>
            </text>
        </TEI>
    </xsl:template>
    
    
    <xsl:template match="row">
        <xsl:variable name="OrgID" select="REF"><!-- replace all non id chracters --></xsl:variable>
        <xsl:variable name="OrgName" select="NAME"></xsl:variable>
        <xsl:variable name="Type" select="TYPE"></xsl:variable>
        <xsl:variable name="Url" select="URL"></xsl:variable>
        <xsl:variable name="OrgPlace" select="Place_Name"></xsl:variable>
        
        
        <org>
            <xsl:attribute name="xml:id"><xsl:value-of select="$OrgID"/></xsl:attribute>
            <orgName>
                <xsl:attribute name="type"><xsl:value-of select="$Type"/></xsl:attribute>
                <xsl:if test="$Url != ''">
                    <xsl:attribute name="ref"><xsl:value-of select="$Url"/></xsl:attribute>
                </xsl:if>
                <xsl:value-of select="$OrgName"/></orgName>
            
         <xsl:if test="$OrgPlace != ''">
           <placeName>
               <xsl:value-of select="$OrgPlace"/>
           </placeName>
         </xsl:if>
            
            
        </org>
    </xsl:template>
    
    
    <xsl:template name="teiHeader">
        <teiHeader xml:id="L1916_listinstitution">
            <fileDesc>
                <titleStmt>
                    <title> List of institutions referenced in the Letters of 1916 collection</title>
                    <editor>Susan Schreibman</editor>
                </titleStmt>
                <editionStmt>
                    <p/>
                </editionStmt>
                <publicationStmt>
                    <publisher>
                        <address>
                        <name>An Foras Feasa</name>
                        <orgName>Maynooth University</orgName>
                        <region>Co. Kildare</region>
                        <placeName>
                            <country>IRE</country>
                            <settlement>Maynooth</settlement>
                        </placeName>
                    </address>
                    </publisher>
                    <idno n="L1916_listinstitution"/>
                    <availability status="restricted">
                        <p>Copyright © 2015, Letters of 1916, Maynooth</p>
                    </availability>
                    <date when="2015">2015</date>
                </publicationStmt>
                <seriesStmt>
                    <p>PUT A STATEMENT, e.g. Machine-readable transcriptions of letters from the Letters of 1916 collection</p>
                </seriesStmt>
                <sourceDesc>
                    <bibl/>
                </sourceDesc>
            </fileDesc>
            <profileDesc>
                <langUsage>
                    <language ident="en-EN">English</language>
                </langUsage>
            </profileDesc>
            <encodingDesc>
                <samplingDecl>
                    <ab>to ADD: e.g. This electronic transcription was created as part of the crowdsourced project Letters of 1916: creating history.</ab>
                </samplingDecl>
            </encodingDesc>
        </teiHeader>
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>