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
                    <listPlace>
                    <xsl:apply-templates></xsl:apply-templates>
                    </listPlace>
                </div>
            </body>
        </text>
        </TEI>
    </xsl:template>
    
    
    <xsl:template match="row">
        <xsl:variable name="PlaceID" select="UID"><!-- replace all non id chracters --></xsl:variable>
        <xsl:variable name="PlaceName" select="Place"></xsl:variable>
        <xsl:variable name="PlaceRegion" select="County"></xsl:variable>
        <xsl:variable name="PlaceCountry" select="Country"></xsl:variable>
        <xsl:variable name="PlaceGeoCoordinate" select="geoCoordinate"></xsl:variable>
        
        
        <place>
            <xsl:attribute name="xml:id"><xsl:value-of select="$PlaceID"/></xsl:attribute>
            <settlement><xsl:value-of select="$PlaceName"/></settlement>
            <region><xsl:value-of select="$PlaceRegion"/></region>
            <country><xsl:value-of select="$PlaceCountry"/></country>
            <location>
                <geo><xsl:value-of select="$PlaceGeoCoordinate"/></geo>
            </location>
        </place>
    </xsl:template>
    
    
    
    
    
    
    
    
    <xsl:template name="teiHeader">
        <teiHeader xml:id="L1916_listplace">
            <fileDesc>
                <titleStmt>
                    <title> List of place names referenced in the Letters of 1916 collection </title>
                    <editor>Susan Schreibman</editor>
                </titleStmt>
                <editionStmt>
                    <p>
                        <!-- A general edition statement has to be added here, same statement for all letters -->
                    </p>
                </editionStmt>
                <publicationStmt>
                    <publisher>
                        <address>
                <name>An Foras Feasa</name>
                <orgName>Maynooth University</orgName>
                <postBox>Co. Kildare</postBox>
                <placeName>
                    <country>IRE</country>
                    <settlement>Maynooth</settlement>
                </placeName>
            </address>
                    </publisher>
                    <idno n="L1916_listplace"/>
                    <availability status="restricted">
                        <p>Copyright &#169; 2015, Letters of 1916, Maynooth</p>
                    </availability>
                    <date when="2015">2015</date>
                </publicationStmt>
                <seriesStmt>
                    <!--to add: -->
                    <p>PUT A STATEMENT, e.g. Machine-readable transcriptions of letters from the Letters
                        of 1916 collection</p>
                </seriesStmt>
                <sourceDesc>
                    <p>Use BoundingBox site for geolocations: <ref
                        target="http://boundingbox.klokantech.com/"/></p>
                    <p>Alternativetely http://hcmc.uvic.ca/people/greg/maps/vertexer/</p>
                </sourceDesc>
            </fileDesc>
            <profileDesc>
                
                <langUsage>
                    <!-- Data from field: Q: English -->
                    <language ident="en">English</language>
                </langUsage>
                
            </profileDesc>
            <encodingDesc>
                <samplingDecl>
                    <!--to add: -->
                    <ab>to ADD: e.g. This electronic transcription was created as part of the
                        crowdsourced project Letters of 1916: creating history.</ab>
                </samplingDecl>
            </encodingDesc>
            
        </teiHeader>
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>