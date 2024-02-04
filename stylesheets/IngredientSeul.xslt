<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Modèle qui regroupe tous les ingrédients de notre application -->
  <xsl:template match="Ingredient">
    <h2 class="text-center margin-bottom">
      Liste Des Ingrédients :
    </h2>

      <div class="padding element-list-row">
        <h3 class="text-center margin-bottom">
          <xsl:attribute name="id">
            <xsl:value-of select="@id"/>
          </xsl:attribute>
          <xsl:value-of select="Nom"/>
        </h3>
        <p>Catégorie : <b>
          <xsl:variable name="produit-ref">
            <xsl:value-of select="ProduitRef/@produit" />
          </xsl:variable>
          <xsl:value-of select="//Produit[@id = $produit-ref]/Nom"/>
        </b></p>
        <p>Recettes utilisant cet ingrédient :
          <xsl:for-each select="RecetteRef">
            <xsl:variable name="recette-ref">
              <xsl:value-of select="@ref" />
            </xsl:variable>
            <ul>
              <xsl:for-each select="//Recette[@id = $recette-ref]">
              <li>
                <a>
                  <xsl:attribute name="href">../Recettes.html#<xsl:value-of select="@id"/>
                  </xsl:attribute>
                  <xsl:value-of select="Titre" />
                </a>
              </li>
              </xsl:for-each>
            </ul>
          </xsl:for-each>
        </p>
      </div>
  </xsl:template>

  <xsl:template match="Ingredient" mode="lien">
    <a>
      <xsl:attribute name="href">Ingredients/<xsl:value-of select="@id"/>.html</xsl:attribute>
      <xsl:value-of select="Nom"/>
    </a>
  </xsl:template>

</xsl:stylesheet>