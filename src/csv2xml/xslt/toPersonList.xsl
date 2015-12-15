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
                        <listPerson>
                            <xsl:apply-templates></xsl:apply-templates>
                        </listPerson>
                    </div>
                </body>
            </text>
        </TEI>
    </xsl:template>
    
    
    <xsl:template match="row">
        <xsl:variable name="NameID" select="Person_ID"><!-- replace all non id chracters --></xsl:variable>
        <xsl:variable name="PersonName" select="Person_Name"></xsl:variable>
        <xsl:variable name="Sex" select="Sex"></xsl:variable>
        <xsl:variable name="Birth" select="Birth"></xsl:variable>
        <xsl:variable name="Death" select="Death"></xsl:variable>
        
        
        <person>
            <xsl:attribute name="xml:id"><xsl:value-of select="$NameID"/></xsl:attribute>
            <persName type="default"><xsl:value-of select="$PersonName"/></persName>
            
            <xsl:if test="$Birth!='' and $Birth != '--'">
                <birth>
                    <xsl:attribute name="when"><xsl:value-of select="$Birth"/></xsl:attribute>
                </birth>
            </xsl:if>
            
            <xsl:if test="$Death!='' and $Death != '--'">
                <death>
                    <xsl:attribute name="when"><xsl:value-of select="$Death"/></xsl:attribute>
                </death>
            </xsl:if>
            
            <xsl:if test="$Death!='' and $Death != '--'">
                <sex>
                    <xsl:attribute name="value"><xsl:value-of select="$Sex"/></xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="$Sex = 'M'">
                            <xsl:text>Male</xsl:text>
                        </xsl:when>
                        <xsl:when test="$Sex = 'F'">
                            <xsl:text>Female</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                 </sex>
            </xsl:if>
        </person>
    </xsl:template>
    
    
    <xsl:template name="teiHeader">
        <teiHeader xml:id="L1916_listperson">
            <fileDesc>
                <titleStmt>
                    <title> List of person names referenced in the Letters of 1916
                        collection</title>
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
                    <idno n="L1916_listperson"/>
                    <availability status="restricted">
                        <p>Copyright © 2015, Letters of 1916, Maynooth</p>
                    </availability>
                    <date when="2015">2015</date>
                </publicationStmt>
                <seriesStmt>
                    <p>PUT A STATEMENT, e.g. Machine-readable transcriptions of letters from the
                        Letters of 1916 collection</p>
                </seriesStmt>
                <sourceDesc>
                    <bibl/>
                </sourceDesc>
            </fileDesc>
            <profileDesc>
                <langUsage>
                    <language ident="EN">English</language>
                </langUsage>
            </profileDesc>
            <encodingDesc>
                <samplingDecl>
                    <ab>to ADD: e.g. This electronic transcription was created as part of the
                        crowdsourced project Letters of 1916: creating history.</ab>
                </samplingDecl>
            </encodingDesc>
        </teiHeader>
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>