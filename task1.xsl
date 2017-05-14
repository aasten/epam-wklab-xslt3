<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:xhtml="http://www.w3.org/1999/xhtml">
	
	<xsl:variable name="heading-font-size" select="14" />
	<xsl:variable name="attachlink-font-size" select="12" />
	<xsl:variable name="link-color" select="concat('#','0060A3')" />
	<xsl:variable name="footer-border-top-color" select="concat('#','2F64C6')" />
	<xsl:variable name="attach-bgcolor" select="concat('#','FDFBF4')" />
	<xsl:variable name="attach-border-color" select="concat('#','DCDAD5')" />
	<xsl:variable name="td-color" select="concat('#', 'F8F8F8')" />
	<xsl:variable name="table-border-color" select="concat('#','7A7E7E')" />
	<xsl:variable name="td-border-color" select="concat('#','CBD2D2')" />
    
    <xsl:template match="/atlas-document">
        <fo:root>
            <fo:layout-master-set>
                <!--one master page-->
                <fo:simple-page-master master-name="content"
						page-width="297mm" page-height="210mm">
                    <fo:region-body region-name="main-region"/>
                    <fo:region-after region-name="footer" extent="1cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="content">
				<fo:static-content flow-name="footer">
					<fo:block 
						border-top-style="solid"
						border-top-color="{$footer-border-top-color}"
						padding-top="0.1em">
						&#xA9; CCH
					</fo:block>
				</fo:static-content>
                <fo:flow flow-name="main-region">
					<fo:block>
						<xsl:apply-templates />
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
        
    </xsl:template>
    
    <xsl:template match="heading">
		<fo:block font-size="{$heading-font-size}" font-weight="900" padding="1em 0">
			<xsl:value-of select="."/>
		</fo:block>
    </xsl:template>
    
    <xsl:template match="//attachment">
		<xsl:variable name="desclen" select="string-length(.//description)" />
		<xsl:variable name="desc-addon" select="concat(' (','clickable',')')" />
		<xsl:variable name="descwidth-em" select="0.55 * ($desclen + string-length($desc-addon))" />
		<xsl:variable name="pictheight-em" select="1.5" />
		<xsl:variable name="start-indent-em" select="0.5" />
		<xsl:variable name="icon-width-percent" select="100 * ($pictheight-em + $start-indent-em) div $descwidth-em" />
		<fo:block-container width="{$pictheight-em + $descwidth-em}em">
			<fo:block background-color="{$attach-bgcolor}" border-color="{$attach-border-color}" border-style="solid" text-align="left">
				<fo:inline-container alignment-baseline="middle" inline-progression-dimension="{$icon-width-percent}%">
					<fo:block start-indent="{$start-indent-em}em" width="{$pictheight-em}em">
						<fo:external-graphic src="filepict.png" height="{$pictheight-em}em" width="{$pictheight-em}em" content-height="scale-to-fit"/>
					</fo:block>
				</fo:inline-container>
				<fo:inline-container alignment-baseline="middle" inline-progression-dimension="{100 - $icon-width-percent}%">
					<fo:block>
						<fo:basic-link 
							external-destination="url('{@src}')" color="{$link-color}" text-decoration="none" font-weight="bold">
							
							<xsl:value-of select=".//description" />
							<xsl:value-of select="$desc-addon" />
						</fo:basic-link>
					</fo:block>
				</fo:inline-container>
			</fo:block>
		</fo:block-container>
    </xsl:template>
    
    <xsl:template match="//xhtml:table">
		<fo:block border="1pt solid {$table-border-color}" padding="1em" margin="1em 0">
			<xsl:apply-templates  />
		</fo:block>
    </xsl:template>
    
    <xsl:template match="//xhtml:table/xhtml:tr">
		<fo:block start-indent="1em" border="1pt solid {$td-border-color}" border-width="thin" padding="2em 0.3em" background-color="{$td-color}">
			<xsl:apply-templates />
		</fo:block>
    </xsl:template>
    
    <xsl:template match="//xhtml:td/note/para/bold">
		<fo:inline>
			<xsl:value-of select="." />
		</fo:inline>
    </xsl:template>
    
    <xsl:template match="//wlink">
		<fo:basic-link external-destination="url('{@target-url}')" color="{$link-color}" text-decoration="none">
			<xsl:value-of select="." />
		</fo:basic-link>
    </xsl:template>
    
    <xsl:template match="//cite-ref">
		<xsl:variable name="href" select="concat('http:&#47;&#47;google.com&#47;?q=',@search-value)" />
		<fo:basic-link external-destination="{$href}" color="{$link-color}" text-decoration="none" font-weight="bold">
			<xsl:value-of select="." />
		</fo:basic-link>
    </xsl:template>
    
    
</xsl:stylesheet>

