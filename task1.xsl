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
				  <fo:block>&#xA9; CCH</fo:block>
				</fo:static-content>
                <fo:flow flow-name="main-region">
					<fo:block>
                    <xsl:apply-templates />
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
        
    </xsl:template>
    
</xsl:stylesheet>

