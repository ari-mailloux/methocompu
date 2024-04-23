# Analyse des inventaires d'oiseaux au Québec

## Répertoire de travail
Pour faire fonctionner ce projet, il est nécessaire d'établir le répertoire de travail comme étant le dossier intitulé acoustique_oiseaux.

## Données
Ce jeu de données a été produit suite à un programme de suivi de la biodiversité acoustique du Ministère de l'Environnement, de la Lutte contre les Changements Climatiques, de la Faune et des Parcs (MELCCFP) effectué dans le cadre du Réseau de suivi de la biodiversité du Québec. Celui-ci contient des observations acoustiques d'oiseaux permettant de mesurer la composition et la phénologie acoustique des oiseaux de plusieurs sites au Québec.

Le protocole d'inventaire utilisait un enregistreur acoustique. Un taxonomiste analyse ensuite les sons enregistrés afin d'identifier les espèces aviaires présentes. Le protocole est standardisé pour permettre la reproductibilité.

Le protocole est décrit dans le document suivant : [Protocole d’inventaire acoustique multiespèce avec appareil Song Meter Mini Bat (SMMB)](https://mffp.gouv.qc.ca/documents/faune/protocole-inventaire-acoustique-multiespece.pdf)

Les données sont analysées dans le cadre d'un projet sur la biodiversité afin de répondre à trois questions :
- À quel moment de la journée est-ce que le plus grand nombre d’oiseaux a été détecté? 
- À quel moment de la journée est-ce que la plus grande diversité d’espèces a été détectée? 
- À quel moment de la journée est-ce que le plus grand nombre de parulines du Canada a été détecté? 


## Description des variables

-   `site_id` identifiant unique du site
-   `lat` latitude du site
-   `projection` projection carthographique utilisée
-   `time_start` heure de début d'observation
-   `time_finish` heure de fin d'observation
-   `date_obs` date de l'observation
-   `time_obs` heure de l'observation
-   `presence` présence ou absence de l'oiseau
-   `kingdom` règne
-   `phylum` embranchement
-   `class` classe
-   `ordre` ordre
-   `family` famille
-   `genus` genre
-   `species` espèce
-   `valid_scientific_name` nom scientifique valide du taxon observé
-   `rank` rang taxonomique du taxon observé
-   `vernacular_en` nom vernaculaire anglais du taxon observé
-   `vernacular_fr` nom vernaculaire français du taxon observé
-   `id_obs` identifiant unique de chaque observation

## Description des tables

-   `taxo` réfère à une table contenant les informations relative à la taxonomie des individus enregistrés
-   `obs` réfère à une table contenant les informations relative aux observations
-   `effort_e` réfère à une table contenant les informations relative à l'effort d'échnatillonage
-   `site` réfère à une table contenant les informations relative au site

## Validation des données

-   Les manipulations effectuées pour la validation et le nettoyage des données incluent : la transformation des NULL en NA, l'uniformisation du format des dates, la conversion de la colonne "variable" en colonne "presence" avec des valeurs booléennes, la vérification des virgules dans la latitude, la vérification que les latitudes se trouvent au Québec, la vérification et la correction de l'association entre nom vernaculaire et nom scientifique et la vérification du format d'heure.

## Informations complémentaires
Prise de données : [Biodiversité Québec / Oiseaux](https://biodiversite-quebec.ca/fr/inventaires/inventaires/oiseaux)
Manipulation des données : Florence Beaudry, Jasmine Boulanger, Ariane Mailloux, Clara Surprenant