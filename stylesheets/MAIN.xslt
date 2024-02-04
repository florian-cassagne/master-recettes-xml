<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="Recettes.xslt" />
  <xsl:include href="Ingredients.xslt" />
  <xsl:include href="Categories.xslt" />
  <xsl:include href="Produits.xslt" />
  <xsl:include href="Auteurs.xslt" />
  <xsl:include href="menu.xslt" />
  <xsl:include href="variables/redirection.xslt" />

  <xsl:output name="recette" method="html"
               indent="yes" />

  <!-- Template initiale de la page d'affichage des données, elle comprend plusieurs autres
   templates comme celle qui affiche la liste des recettes ou des auteurs
   -->
  <xsl:template match="/">

    <xsl:result-document href="index.html"
                         format="recette" >
      <xsl:call-template name="page-accueil" />
    </xsl:result-document>

    <xsl:result-document href="Recettes.html"
                         format="recette" >
      <xsl:call-template name="page-recettes" />
    </xsl:result-document>

    <xsl:result-document href="Auteurs.html"
                         format="recette" >
      <xsl:call-template name="page-auteurs" />
    </xsl:result-document>

    <xsl:for-each select="//Ingredient">
      <xsl:variable name="recette-id"
                    select="concat('Ingredients/', @id, '.html')" />
      <xsl:result-document format="recette" href="{$recette-id}">
        <html>
          <xsl:call-template name="head">
            <xsl:with-param name="niveau-inferieur"
                            select="1" />
            </xsl:call-template>
          <body>
            <xsl:call-template name="menu">
              <xsl:with-param name="niveau-inferieur" select="1" />
            </xsl:call-template>
            <xsl:apply-templates select="current()" />
          </body>
        </html>
      </xsl:result-document>
    </xsl:for-each>

    <xsl:result-document href="Produits.html"
                         format="recette" >
      <xsl:call-template name="page-produits" />
    </xsl:result-document>

    <xsl:result-document href="Categories.html"
                         format="recette" >
      <xsl:call-template name="page-categories" />
    </xsl:result-document>

  </xsl:template>


  <!-- En tête qui charge certaines ressources,
   comme la feuille de style CSS  -->
  <xsl:template name="page-accueil">
    <html lang="fr">
      <xsl:call-template name="head"/>
      <body>
        <xsl:call-template name="menu">
          <xsl:with-param name="niveau-inferieur" select="0" />
        </xsl:call-template>
        <h1 class="text-center margin-bottom">
          Application O'Délices : Edition M1 Informatique
        </h1>
        <xsl:call-template name="sommaire-recettes" />
        <xsl:call-template name="sommaire-ingredients" />
        <xsl:call-template name="sommaire-produits" />
        <xsl:call-template name="sommaire-categories" />
        <xsl:call-template name="sommaire-auteur" />
      </body>
    </html>
  </xsl:template>

  <xsl:template name="page-recettes">
    <html lang="fr">
      <xsl:call-template name="head"/>
      <body>
        <xsl:call-template name="menu">
          <xsl:with-param name="niveau-inferieur" select="0" />
        </xsl:call-template>
        <xsl:call-template
                name="liste-recettes" />
      </body>
    </html>
  </xsl:template>

  <xsl:template name="page-auteurs">
    <html>
      <xsl:call-template name="head"/>
      <body>
        <xsl:call-template name="menu" />
        <xsl:call-template
                name="liste-auteurs" />
      </body>
    </html>
  </xsl:template>

  <xsl:template name="page-ingredients">
    <html>
      <xsl:call-template name="head"/>
      <body>
        <xsl:call-template name="menu">
          <xsl:with-param name="niveau-inferieur" select="0" />
        </xsl:call-template>
        <xsl:call-template
                name="liste-ingredients" />
      </body>
    </html>
  </xsl:template>

  <xsl:template name="page-produits">
    <html>
      <xsl:call-template name="head"/>
      <body>
        <xsl:call-template name="menu">
          <xsl:with-param name="niveau-inferieur" select="0" />
        </xsl:call-template>
        <xsl:call-template
                name="liste-produits" />
      </body>
    </html>
  </xsl:template>

  <xsl:template name="page-categories">
    <html>
      <xsl:call-template name="head"/>
      <body>
        <xsl:call-template name="menu">
          <xsl:with-param name="niveau-inferieur" select="0" />
        </xsl:call-template>
        <xsl:call-template
                name="liste-categories" />
      </body>
    </html>
  </xsl:template>

  <!-- En-tête qui charge certaines ressources, comme la feuille de style CSS  -->
  <xsl:template name="head">
    <xsl:param name="niveau-inferieur" select="0" />
    <head>
      <link rel="stylesheet" type="text/css">
      <xsl:attribute name="href">
        <xsl:if test="$niveau-inferieur = 1">../</xsl:if>../recette.css</xsl:attribute>
      </link>
      <title>O'Délices M1 Informatique Edition</title>
    </head>
  </xsl:template>


<!-- Modèle qui affiche la liste des auteurs -->
  <xsl:template name="sommaire-auteur">
    <h2>Lien vers les auteurs : </h2>
    <ul>
      <xsl:for-each select="//Auteur">
        <xsl:sort select="Nom"/>
        <li class="margin-bottom">
          <a>
            <xsl:attribute name="href"><xsl:copy-of
                    select="$redirection-auteurs"/>#<xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:value-of select="Nom"/>
          </a>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

<!-- Modèle qui affiche la liste des recettes -->
  <xsl:template name="sommaire-recettes">
    <h2>Lien vers les recettes : </h2>
    <ul>
      <xsl:for-each select="//Recette">
        <xsl:sort select="Nom"/>
        <li class="margin-bottom">
          <a>
            <xsl:attribute name="href"><xsl:copy-of
                    select="$redirection-recettes"/>#<xsl:value-of
                    select="@id"/>
            </xsl:attribute>
            <xsl:value-of select="Titre"/>
          </a>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

<!-- Modèle qui affiche la liste des ingrédients -->
  <xsl:template name="sommaire-ingredients">
    <h2>Lien vers les ingrédients : </h2>
    <ul>
      <xsl:for-each select="//Ingredient">
        <li class="margin-bottom">
          <a>
            <xsl:attribute name="href"><xsl:copy-of
                    select="$redirection-ingredients"/><xsl:value-of
                    select="@id"/>.html</xsl:attribute>
            <xsl:value-of select="Nom"/>
          </a>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

<!-- Modèle qui affiche la liste des produits -->
  <xsl:template name="sommaire-produits">
    <h2>Lien vers les produits : </h2>
    <ul>
      <xsl:for-each select="//Produit">
        <li class="margin-bottom">
          <a>
            <xsl:attribute name="href"><xsl:copy-of
                    select="$redirection-produits"/>#<xsl:value-of
                    select="@id"/>
            </xsl:attribute>
            <xsl:value-of select="Nom"/>
          </a>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

<!-- Modèle qui affiche la liste des catégories -->
  <xsl:template name="sommaire-categories">
    <h2>Lien vers les catégories : </h2>
    <div>
      <ul>
        <xsl:for-each select="//Categorie">
          <xsl:variable
                  name="categorie-id"><xsl:value-of select="@id"/></xsl:variable>
          <h3>
            <a>
              <xsl:attribute name="href"><xsl:copy-of
                  select="$redirection-categories"/>#<xsl:value-of
                  select="@id"/>
              </xsl:attribute>
              <xsl:value-of select="Nom"/>
            </a>
          </h3>

          <xsl:for-each
                  select="//SousCategorie[CategorieRef/@ref = $categorie-id]">
            <li class="margin-bottom">
              <a>
                <xsl:attribute name="href"><xsl:copy-of
                        select="$redirection-categories"/>#<xsl:value-of
                        select="@id"/>
                </xsl:attribute>
                <xsl:value-of select="Nom"/> - <xsl:value-of select="count(RecetteRef)"/>
              </a>
            </li>
          </xsl:for-each>
        </xsl:for-each>
      </ul>
    </div>

  </xsl:template>


</xsl:stylesheet>