xquery version "1.0" encoding "utf-8";


let $docRecette := doc ("./recette.xml")

let $sautLigne := "&#xA;"

(:
  Fonctionnalités XPath 2.0 utilisées :
  
    distinct-values : pour éviter les doublons d'auteurs
    
    order by : pour trier un jeu de données dans l'ordre croissant (ou décroissant)
:)

for $auteurId in distinct-values($docRecette//Auteur/@id)
let $auteur := $docRecette//Auteur[@id=$auteurId]
  order by $auteur/Nom ascending
  return
    ( 
    <Auteur>
      { $auteur/Nom/text(),
        for $recetteId in distinct-values($docRecette//Recette/@id)
        let $recette := $docRecette//Recette[@id=$recetteId]
        where $recette/@id = $auteur/RecetteRef/@ref
        order by $recette/Titre
          return 
          ( $sautLigne,
          <Recette>
            { $recette/Titre/text(),
               for $sousCategorie in $docRecette//SousCategorie
               where $recette/@id = $sousCategorie/RecetteRef/@ref
                 return 
                 ( $sautLigne,
                 <SousCategorie>
                   { $sousCategorie/Nom/text() }
                 </SousCategorie>)
             }
          </Recette>)
        }
    </Auteur>)