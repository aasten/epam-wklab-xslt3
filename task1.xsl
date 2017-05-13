<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:template match="/atlas-document">
		<xsl:message>atlas</xsl:message>
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
						border-top-color="#2F64C6"
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
		<fo:block font-size="14" font-weight="900" padding="1em 0">
			<xsl:value-of select="."/>
		</fo:block>
    </xsl:template>
    
    <xsl:template match="//attachment">
		<fo:block-container width="15%">
			<fo:block background-color="#FDFBF4" border-color="#DCDAD5" border-style="solid">
			<fo:inline-container alignment-baseline="middle" inline-progression-dimension="20%">
				<fo:block start-indent="5pt">
					<fo:external-graphic src="filepict.png" height="1.5em" content-height="scale-to-fit"/>
				</fo:block>
			</fo:inline-container>
			<fo:inline-container alignment-baseline="middle" inline-progression-dimension="80%">
				<fo:block>
					<xsl:value-of select=".//description"/>
				</fo:block>
			</fo:inline-container>
			</fo:block>
		</fo:block-container>
		
<!--
		<fo:block-container width="15%">
			<fo:block background-color="#FDFBF4" border-color="#DCDAD5" border-style="solid" padding-bottom="0.3em">
					<fo:external-graphic src="filepict.png" height="1.5em" content-height="scale-to-fit" padding="0.5em 0.3em 0"/>
						<xsl:value-of select=".//description"/>
			</fo:block>
		</fo:block-container>
-->
    </xsl:template>
    
</xsl:stylesheet>

