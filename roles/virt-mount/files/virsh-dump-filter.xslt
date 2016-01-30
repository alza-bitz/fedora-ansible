<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

  <xsl:strip-space elements="*"/>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@unit|@placement|@machine|@fallback|@heads|@ram|@vram|@path"/>
  
  <xsl:template match="address|memballoon|serial"/>

  <xsl:template match="controller[@type='pci']"/>

  <xsl:template match="controller[@type='ide']"/>

  <xsl:template match="controller[@type='virtio-serial']"/>

  <xsl:template match="input[@bus='ps2' and @type='keyboard']"/>

  <xsl:template match="filesystem/alias"/>

  <xsl:template match="console/target"/>

  <xsl:template match="interface[@type='user']/model"/>

  <xsl:template match="graphics[@autoport='yes']">
    <graphics>
      <xsl:apply-templates select="@*"/>
        <xsl:attribute name="port">
          <xsl:value-of select="-1"/> 
        </xsl:attribute>
        <xsl:attribute name="tlsPort">
          <xsl:value-of select="-1"/>
        </xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </graphics>
  </xsl:template>

</xsl:stylesheet>
