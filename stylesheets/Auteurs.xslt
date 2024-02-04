<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:key name="recettes-par-auteur" match="Recette"
           use="AuteurRef/@ref"/>
  <xsl:key name="auteurs-recette-tres-facile" match="Auteur"
           use="//Recette/@difficulte"/>

  <xsl:template name="liste-auteurs">

    <h2 class="text-center margin-bottom">
      Liste Des Auteurs :
    </h2>

    <xsl:for-each
        select="//Auteur" >
      <xsl:sort select="Nom"/>

      <div class="auteur element-list-row padding">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>

        <h3 class="text-center">
          <xsl:value-of select="Nom"/>
        </h3>

        <div class="data flex-row auteur-info">
          <span>Âge :
            <b><xsl:value-of
                select="Age"/>
            </b>
          </span>
          <span>Pays :
            <b><xsl:value-of
                select="Pays"/>
            </b>
          </span>
          <span>Sexe :
            <b>
              <xsl:if test="@sexe = 'f'">Femme</xsl:if>
              <xsl:if test="@sexe = 'm'">Homme</xsl:if>
              <xsl:if test="@sexe = 'n'">(Inconnu)</xsl:if>
            </b>
          </span>
        </div>

        <p>
          <xsl:value-of select="Biographie"/>
        </p>

        <div class="liste-recette">
          <h4>Recettes :</h4>
          <ul>
            <xsl:apply-templates
                select="key('recettes-par-auteur', @id)" />
          </ul>
        </div>

      </div>

    </xsl:for-each>

  </xsl:template>

</xsl:stylesheet>