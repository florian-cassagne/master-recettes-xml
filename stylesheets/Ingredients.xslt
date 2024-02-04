<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Modèle qui regroupe tous les ingrédients de notre application -->
  <xsl:template name="liste-ingredients">

    <h2 class="text-center margin-bottom">
      Liste Des Ingrédients :
    </h2>

    <xsl:for-each
        select="//Ingredient">

      <div class="padding element-list-row">
        <h3 class="text-center margin-bottom">
          <xsl:attribute name="id">
            <xsl:value-of select="@id"/>
          </xsl:attribute>
          <xsl:value-of select="Nom"/>
        </h3>
        <p>Catégorie : <xsl:value-of select="ProduitRef/@produit"/></p>
        <p>Recettes utilisant cet ingrédient :</p>
        <p><xsl:value-of select="RecetteRef/@refs"/></p>
      </div>

    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>