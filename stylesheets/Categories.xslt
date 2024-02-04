<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- Modèle qui regroupe toutes les catégories, ainsi que les
sous-catégories de notre application -->
  <xsl:template name="liste-categories">

    <h2 class="text-center margin-bottom">
      Liste Des Catégories :
    </h2>

    <xsl:for-each
        select="//Categorie">
      <xsl:variable name="categorie-id"><xsl:value-of select="@id"/></xsl:variable>

      <div class="categorie padding element-list-row">

        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>

        <h3 class="text-center">
          <xsl:value-of select="Nom/text()"/>
          (<xsl:value-of
            select="count(//SousCategorie[CategorieRef/@ref = $categorie-id]/RecetteRef/@ref)"/>)
        </h3>

        <p class="text-center">
          <xsl:value-of select="Descriptif/text()"/>
        </p>

        <div class="sous-categorie">

          <h3>Sous-catégories : </h3>
          <ul>
            <xsl:for-each
                select="//SousCategorie[CategorieRef/@ref = $categorie-id]">
              <h4>
                <xsl:attribute name="id">
                  <xsl:value-of select="@id"/>
                </xsl:attribute>
                <xsl:value-of select="Nom"/>
                (<xsl:value-of
                  select="count(current()[CategorieRef/@ref = $categorie-id]/RecetteRef/@ref)"/>)
              </h4>
              <xsl:choose>
                <xsl:when test="RecetteRef">
                  <li>
                    <xsl:variable
                        name="sous-categorie-recette-id"><xsl:value-of
                        select="RecetteRef/@ref"/></xsl:variable>
                    <ul>
                      <xsl:for-each
                          select="//Recette[@id = $sous-categorie-recette-id]">
                        <li>
                          <a>
                            <xsl:attribute name="href">
                              <xsl:copy-of select="$redirection-recettes"/>#<xsl:value-of select="@id"/>
                            </xsl:attribute>
                            <xsl:value-of select="Titre"/>
                          </a>
                        </li>
                      </xsl:for-each>
                    </ul>
                  </li>
                </xsl:when>
                <xsl:otherwise>
                  <i>Aucune recette n'appartient à cette catégorie</i>
                </xsl:otherwise>
              </xsl:choose>

            </xsl:for-each>
          </ul>

        </div>

      </div>

    </xsl:for-each>

  </xsl:template>
</xsl:stylesheet>