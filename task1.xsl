<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:wkdoc="http://www.wkpublisher.com/xml-namespaces/document">
	
	<xsl:variable name="heading-font-size" select="12" />
	<xsl:variable name="def-font-size" select="9" />
	<xsl:variable name="h1-font-size" select="12" />
	<xsl:variable name="footer-font-size" select="7" />
	<xsl:variable name="link-color" select="'#0060A3'" />
	<xsl:variable name="footer-border-top-color" select="'#2F64C6'" />
	<xsl:variable name="attach-bgcolor" select="'#FDFBF4'" />
	<xsl:variable name="attach-border-color" select="'#DCDAD5'" />
	<xsl:variable name="td-color" select="'#F8F8F8'" />
	<xsl:variable name="table-border-color" select="'#7A7E7E'" />
	<xsl:variable name="td-border-color" select="'#CBD2D2'" />
	<xsl:variable name="para-margin" select="concat('1','em')" />
	<xsl:variable name="list-indent-step" select="4" />
	<xsl:variable name="list-indent-unit" select="'em'" />
	
    
    <xsl:template match="/atlas-document">
        <fo:root>
            <fo:layout-master-set>
                <!--one master page-->
                <fo:simple-page-master master-name="content"
						page-width="297mm" page-height="210mm">
                    <fo:region-body region-name="main-region"/>
                    <fo:region-after region-name="footer" extent="2em"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="content">
				<fo:static-content flow-name="footer">
					<fo:block 
						border-top-style="solid"
						border-top-color="{$footer-border-top-color}"
						border-width="thin"
						padding-top="0.1em"
						font-size="{$footer-font-size}">
						&#xA9; CCH
					</fo:block>
				</fo:static-content>
                <fo:flow flow-name="main-region" font-size="{$def-font-size}">
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
		<fo:block border="1pt solid {$table-border-color}" border-width="thin" margin="1em 0 0" padding="1em" padding-right="0.4em">
			<xsl:apply-templates  />
		</fo:block>
    </xsl:template>
    
    <xsl:template match="//xhtml:table/xhtml:tr">
		<fo:block start-indent="1.5em" border="1pt solid {$td-border-color}" border-width="thin" padding="2em 0.3em" background-color="{$td-color}">
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
    
    <xsl:template match="//wkdoc:level">
		<fo:block start-indent="0.3em" padding="0.5em 0">
			<xsl:apply-templates />
		</fo:block>
    </xsl:template>
		
    <xsl:template match="//wkdoc:level//para[text()]">
		<xsl:if test="normalize-space(.)!=''">
			<fo:block margin="{$para-margin} 0">
				<xsl:apply-templates />
			</fo:block>
		</xsl:if>
    </xsl:template>
    
    <xsl:template match="//wkdoc:level//bold[text()]">
		<fo:inline font-weight="bold">
			<xsl:apply-templates />
		</fo:inline>
    </xsl:template>
    
    <xsl:template match="//italic[text()]">
		<xsl:message><xsl:text>italic</xsl:text></xsl:message>
		<fo:inline font-style="italic">
			<xsl:apply-templates />
		</fo:inline>
    </xsl:template>
    
    <xsl:template match="//h1[.//text()]">
		<fo:block font-size="{$h1-font-size}" margin="0.5em 0">
			<xsl:apply-templates />
		</fo:block>
    </xsl:template>
    
    <xsl:template match="unordered-list" name="unordered-list">
		<xsl:param name="indent"/>
		<xsl:variable name="current-indent">
			<xsl:choose>
				<xsl:when test="not($indent)"><xsl:value-of select="$list-indent-step"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
<!--
		<xsl:message><xsl:value-of select="$current-indent"/></xsl:message>
-->
		
		<fo:list-block start-indent="{concat($current-indent,$list-indent-unit)}">
			<xsl:for-each select="list-item|unordered-list">
				<xsl:choose>
				<xsl:when test="self::list-item">
					<xsl:call-template name="list-item">
						<xsl:with-param name="indent" select="$current-indent" />
					</xsl:call-template>
<!--
					<xsl:apply-templates select="."/>
-->
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
			</xsl:for-each>
		</fo:list-block>
    </xsl:template>
    
    <xsl:template match="list-item" name="list-item">
		<xsl:param name="indent"/>
		<xsl:variable name="current-indent">
			<xsl:choose>
				<xsl:when test="not($indent)"><xsl:value-of select="$list-indent-step"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="next-indent" select="$current-indent + $list-indent-step" />
		<fo:list-item >
			<fo:list-item-label><fo:block></fo:block></fo:list-item-label>
			<fo:list-item-body>
				<xsl:apply-templates select="node() except unordered-list"/>
				<xsl:for-each select="unordered-list">
					<xsl:call-template name="unordered-list">
						<xsl:with-param name="indent" select="$next-indent" />
					</xsl:call-template>
				</xsl:for-each>
			</fo:list-item-body>
		</fo:list-item>
    </xsl:template>
    
<!--
    <xsl:template match="list-item//para">
		<fo:inline>
			<xsl:apply-templates />
		</fo:inline>
    </xsl:template>
-->
    
</xsl:stylesheet>

