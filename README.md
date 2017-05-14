# 
Used FOP 2.2 to generate.

`atc_2011_ATC_20-248.pdf` is a result, its stored here and named such to match the clickable link to the referenced document from within the result pdf.

# Two steps to generate

Used two steps for generating PDF: 

* xml+xsl --(saxon)--> fo 
* fo --(fop2.2)--> pdf

Example of command:
```
saxonb-xslt -s:task1.xml -xsl:task1.xsl -o:out.fop && /path/to/fop-2.2/fop/fop -fo out.fop -pdf out.pdf
```
