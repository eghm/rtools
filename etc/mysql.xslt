<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" indent="yes"/>
  <xsl:template match="table_data">
    <xsl:copy>
    <xsl:copy-of select="@*"/>
      <xsl:for-each select="row">
        <row>
          <xsl:for-each select="field">
            <xsl:element name="{@name}">
              <xsl:value-of select="."/>
            </xsl:element>
          </xsl:for-each>
        </row>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>

