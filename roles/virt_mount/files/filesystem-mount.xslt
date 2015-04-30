<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

  <xsl:strip-space elements="*"/>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="domain/devices/filesystem[target[@dir = 'host-mount']]"/>

  <xsl:template match="domain/devices">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
      <filesystem type="mount" accessmode="mapped">
        <source dir="{$source_dir}"/>
        <target dir="host-mount"/>
      </filesystem>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
