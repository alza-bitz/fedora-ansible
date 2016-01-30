<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:ovf="http://schemas.dmtf.org/ovf/envelope/1" 
  xmlns:qemu="http://libvirt.org/schemas/domain/qemu/1.0"
  xmlns:vbox="http://www.virtualbox.org/ovf/machine"
  exclude-result-prefixes="ovf">

  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

  <xsl:strip-space elements="*"/>

  <xsl:param name="ovf" select="document($file)"/>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="domain/name/text()">
    <xsl:value-of select="$ovf//vbox:Machine/@name"/>
  </xsl:template>

  <xsl:template match="domain/memory | domain/currentMemory">
    <xsl:copy>
      <xsl:attribute name="unit">M</xsl:attribute>
      <xsl:value-of select="$ovf//ovf:Memory/@RAMSize"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="domain/vcpu/text()">
    <xsl:value-of select="$ovf//ovf:CPU/@count"/>
  </xsl:template>

  <xsl:template match="domain">
    <domain>
      <xsl:copy-of select="namespace::*"/>
      <xsl:apply-templates select="@* | node()[not(self::entry)]"/>
      <qemu:commandline>
        <xsl:for-each select="$ovf//ovf:Forwarding">
          <xsl:if test="@hostport >= 1024">
            <qemu:arg value="-redir"/>
            <qemu:arg value="tcp:{@hostport}::{@guestport}"/>
          </xsl:if>
        </xsl:for-each>
      </qemu:commandline>
    </domain>
  </xsl:template>

</xsl:stylesheet>
