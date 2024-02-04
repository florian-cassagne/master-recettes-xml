<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template name="menu">
    <xsl:param name="niveau-inferieur" select="0" />

    <nav id="menu" class="text-bigger">
      <ul class="flex-row">
        <li><a>
          <xsl:attribute name="href">
            <xsl:if test="$niveau-inferieur">../</xsl:if>
            <xsl:copy-of select="$redirection-accueil"/>
          </xsl:attribute>
          Accueil
        </a></li>
        <li><a>
          <xsl:attribute name="href">
            <xsl:if test="$niveau-inferieur">../</xsl:if>
            <xsl:copy-of select="$redirection-recettes"/>
          </xsl:attribute>
          Recettes
        </a></li>
        <li><a>
          <xsl:attribute name="href">
            <xsl:if test="$niveau-inferieur">../</xsl:if>
            <xsl:copy-of select="$redirection-produits"/>
          </xsl:attribute>
          Produits
        </a></li>
        <li><a>
          <xsl:attribute name="href">
            <xsl:if test="$niveau-inferieur">../</xsl:if>
            <xsl:copy-of select="$redirection-categories"/>
          </xsl:attribute>
          Catégories
        </a></li>
        <li><a>
          <xsl:attribute name="href">
            <xsl:if test="$niveau-inferieur">../</xsl:if>
            <xsl:copy-of select="$redirection-auteurs"/>
          </xsl:attribute>
          Auteurs
        </a></li>
      </ul>
    </nav>
    <p class="separator-large">-</p>
  </xsl:template>
</xsl:stylesheet>