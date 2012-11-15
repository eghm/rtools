<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" doctype-system="data.dtd" omit-xml-declaration="yes" />
  <xsl:template match="table_data">
<dataset>
      <xsl:apply-templates/>
</dataset>
  </xsl:template>

  <xsl:template match="row">
    <TABLE_NAME>
      <xsl:for-each select="*">
        <xsl:attribute name="{name()}">
          <xsl:value-of select="text()"/>
        </xsl:attribute>
      </xsl:for-each>
    </TABLE_NAME>
  </xsl:template>
</xsl:stylesheet>
