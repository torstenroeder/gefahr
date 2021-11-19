<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
	xmlns="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">

	<!-- put transformation result in a new file -->
	<xsl:template match="/">
		<xsl:result-document href="tgb_dahl.xml">
			<xsl:apply-templates select="@* | node()"/>
		</xsl:result-document>
	</xsl:template>
	
	<!-- load indices file -->
	<xsl:variable name="indices" select="document('indices.xml')/TEI/text/body"/>

	<!-- expand abbreviations (all explicit) -->
	<xsl:template match="abbr[@ana]">
		<xsl:sequence select="$indices//item[@xml:id=current()/substring(@ana,2)]/*"/>
	</xsl:template>

	<!-- replace facsimile link by proper iiif manifesto link -->
	<xsl:template match="pb/@facs">
		<xsl:attribute name="facs">
			<xsl:analyze-string select="." regex="id512116717/([0-9]{{3}})">
				<xsl:matching-substring>
					<xsl:text>https://images.iiif.slub-dresden.de/iiif/2/data%2Fkitodo%2FBttNach_512116717_2020%2FBttNach_512116717_2020_tif%2Fjpegs%2F00000</xsl:text>
					<xsl:value-of select="regex-group(1)"/>
					<xsl:text>.tif.large.jpg/full/full/0/default.jpg</xsl:text>
				</xsl:matching-substring>
				<xsl:non-matching-substring/>
			</xsl:analyze-string>
		</xsl:attribute>
	</xsl:template>

	<!-- identity transform -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
