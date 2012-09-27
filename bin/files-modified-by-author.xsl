<!-- http://svn.haxx.se/users/archive-2011-01/0492.shtml -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 
  <xsl:output method="text"/> 
  <xsl:param name="author">eghm-kuali-m</xsl:param> 
  <xsl:template match="/log/logentry"> 
    <xsl:if test="author=$author"> 
      <xsl:apply-templates select="paths/path[@kind='file']"/> 
    </xsl:if> 
  </xsl:template> 
  <xsl:template match="/log/logentry/paths/path"> 
    <xsl:value-of select="text()"/> 
    <xsl:text>&#x000a;</xsl:text> 
  </xsl:template> 
  <xsl:template match="text()"/> 
</xsl:stylesheet> 

