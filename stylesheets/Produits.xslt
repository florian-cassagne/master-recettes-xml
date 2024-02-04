<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="IngredientSeul.xslt" />

  <!-- Modèle qui regroupe tous les produits de notre application -->
  <xsl:template name="liste-produits">

    <h2 class="text-center margin-bottom">
      Liste Des Produits :
    </h2>

    <xsl:for-each
        select="//Produit">
      <xsl:variable
          name="produit-id"><xsl:value-of select="@id"/></xsl:variable>

      <h3 class="padding element-list-row text-center">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
        <xsl:value-of select="Nom/text()"/>
      </h3>
      <ul>
        <xsl:for-each select="//Ingredient[ProduitRef/@produit = $produit-id]">
          <xsl:sort select="Nom"/>
          <li class="margin-bottom-half">
            <xsl:apply-templates select="current()" mode="lien" />
          </li>
        </xsl:for-each>
      </ul>

    </xsl:for-each>

  </xsl:template>
</xsl:stylesheet>