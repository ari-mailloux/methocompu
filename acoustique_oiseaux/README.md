# methocompu



## Description des variables

-   `site_id` identifiant unique du site
-   `lat` latitude du site
-   `projection` projection carthographique utilisée
-   `time_start` heure de début d'observation
-   `time_finish` heure de fin d'observation
-   `date_obs` date de l'observation
-   `time_obs` heure de l'observation
-   `variable` variable mesurée
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
