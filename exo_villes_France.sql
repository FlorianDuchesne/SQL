    -- Obtenir la liste des 10 villes les plus peuplées en 2012
    SELECT ville_nom FROM `villes_france_free` ORDER BY `ville_population_2012` DESC LIMIT 10 
    -- Obtenir la liste des 50 villes ayant la plus faible superficie
    SELECT ville_nom FROM `villes_france_free` ORDER BY `ville_surface` ASC LIMIT 50 
    -- Obtenir la liste des départements d’outres-mer, c’est-à-dire ceux dont le numéro de département commencent par “97”
    SELECT `departement_nom` FROM `departement` WHERE `departement_code` LIKE '97%' 
    -- Obtenir le nom des 10 villes les plus peuplées en 2012, ainsi que le nom du département associé
    SELECT ville_nom, departement_nom FROM `villes_france_free` v, `departement` d WHERE v.ville_departement = d.departement_code ORDER BY v.ville_population_2012 DESC LIMIT 10 
    -- Obtenir la liste du nom de chaque département, associé à son code et du nombre de commune au sein de ces département, en triant afin d’obtenir en priorité les départements qui possèdent le plus de communes
    SELECT `departement_nom`, `departement_code`, COUNT(ville_id) AS nbVilles FROM `departement` d, villes_france_free v WHERE v.ville_departement = d.departement_code GROUP BY departement_nom ORDER BY nbVilles DESC 
    -- Obtenir la liste des 10 plus grands départements, en terme de superficie
    SELECT `departement_nom`, COUNT(ville_surface) AS superficie FROM `departement` d, villes_france_free v WHERE v.ville_departement = d.departement_code GROUP BY departement_nom ORDER BY superficie DESC 
    -- Compter le nombre de villes dont le nom commence par “Saint”
    SELECT COUNT(ville_id) FROM `villes_france_free` WHERE `ville_nom_reel` LIKE 'Saint%' 
    -- Obtenir la liste des villes qui ont un nom existant plusieurs fois, et trier afin d’obtenir en premier celles dont le nom est le plus souvent utilisé par plusieurs communes
    SELECT `ville_nom`, COUNT(`ville_nom`) AS doublons FROM `villes_france_free` v GROUP BY ville_nom HAVING (COUNT(`ville_nom`) > 1) ORDER BY doublons DESC 
    -- Obtenir en une seule requête SQL la liste des villes dont la superficie est supérieur à la superficie moyenne
    SELECT `ville_nom` FROM `villes_france_free` WHERE `ville_surface` > (SELECT AVG(`ville_surface`) FROM `villes_france_free`) 
    -- Obtenir la liste des départements qui possèdent plus de 2 millions d’habitants
    CREATE VIEW ViewPopDep AS SELECT SUM(ville_population_2012) AS popDep, departement_nom FROM villes_france_free, departement WHERE ville_departement = departement_code GROUP BY departement_nom 
    SELECT `departement_nom` FROM `viewpopdep` WHERE `popDep` > 2000000 
    -- Remplacez les tirets par un espace vide, pour toutes les villes commençant par “SAINT-” (dans la colonne qui contient les noms en majuscule)
    UPDATE `villes_france_free` SET `ville_nom` = REPLACE(`ville_nom`, 'SAINT-', 'SAINT ') 