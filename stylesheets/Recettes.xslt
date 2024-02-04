<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:key name="recettes-par-difficulte"
           match="Recette" use="@difficulte"/>

  <!-- Template qui rassemble toutes les recettes de notre projet, affiché sur la page d'accueil (MAIN.xslt)-->
  <xsl:template name="liste-recettes">

    <xsl:for-each
        select="//Recette">
      <xsl:sort select="Date" order="descending"/>

      <div class="recette element-list-row padding">
        <xsl:variable name="recette-id">
          <xsl:value-of select="@id"/>
        </xsl:variable>
        <xsl:attribute name="id">
          <xsl:value-of select="$recette-id"/>
        </xsl:attribute>

        <h2 class="text-center margin-bottom">
          <xsl:value-of select="Titre"/>
        </h2>

        <div class="recette-image-container">
          <img class="margin-bottom">
            <xsl:attribute name="src">
              <xsl:value-of select="Photo"/>
            </xsl:attribute>
          </img>
        </div>

        <p class="margin-bottom">
          <xsl:value-of select="Resume"/>
        </p>

        <div class="data flex-row recette-info-base">
          <span>Auteur : <b><xsl:variable
              name="recette-auteur-id"><xsl:value-of select="@id"/></xsl:variable>
            <xsl:for-each
                select="//Auteur[RecetteRef/@ref = $recette-auteur-id]">
              <a>
                <xsl:attribute name="href">
                  <xsl:copy-of select="$redirection-auteurs"/>#<xsl:value-of
                    select="@id"/>
                </xsl:attribute>
                <xsl:value-of select="Nom/text()"/>
              </a>
            </xsl:for-each>

          </b></span>
          <span>Date : <b>
            <xsl:value-of select="Date"/>
          </b></span>
        </div>

        <div class="recette-liste-ingredient">
          <h4>Ingrédients :</h4>
          <xsl:for-each
              select="IngredientRef">
            <ul>
              <li><a>
                <xsl:attribute name="href">Ingredients/<xsl:value-of
                    select="@ref"/>.html</xsl:attribute>
                <xsl:value-of
                    select="text()"/>
              </a></li>
            </ul>
          </xsl:for-each>
        </div>

        <div class="recette-liste-ingredient">
          <h4>Sous-catégories : </h4>
          <ul>
            <xsl:for-each
                select="//SousCategorie[RecetteRef/@ref = $recette-id]">
              <li>
                <a>
                  <xsl:attribute name="href">
                    <xsl:copy-of select="$redirection-categories"/>#<xsl:value-of select="./@id"/>
                  </xsl:attribute>
                  <xsl:value-of select="./Nom"/>
                </a>
              </li>
            </xsl:for-each>
          </ul>
        </div>

        <h3>Préparation</h3>
        <div
            class="data flex-row recette-info-preparation">
          <span>Préparation :
            <b><xsl:value-of
                select="TempsPrepa"/>
            </b>
          </span>
          <span>Cuisson :
            <b><xsl:value-of
                select="TempsCuisson"/>
            </b>
          </span>
          <span>Repos :
            <b><xsl:value-of
                select="TempsRepos"/>
            </b>
          </span>
        </div>
        <p>
          <xsl:copy-of
              select="DescriptionPrepa/*"/>
        </p>

        <xsl:if test="Note">
          <p class="text-center text-2xl bg-orange5 padding margin-bottom">
              Note :
              <b><xsl:value-of select="Note"/>
              </b> / 5
          </p>
        </xsl:if>
      </div>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="recette">
      <xsl:apply-templates
          select="key('recettes-par-difficulte', 'tres-facile')" />
  </xsl:template>

  <xsl:template match="Recette">
    <li>
      <a>
        <xsl:attribute name="href">
          <xsl:copy-of select="$redirection-recettes"/>#<xsl:value-of select="@id"/>
        </xsl:attribute>
        <xsl:value-of select="Titre"/>
      </a>
    </li>
  </xsl:template>

</xsl:stylesheet>