-- 1) Nombre de gaulois par lieu (trié par nombre de gaulois décroissant)
SELECT COUNT(`ID_VILLAGEOIS`) AS nbreHabitants, v.ID_LIEU FROM villageois v, lieu l WHERE v.ID_LIEU = l.ID_LIEU GROUP BY ID_LIEU ORDER BY ID_LIEU DESC 
-- 2) Nom des gaulois + spécialité + village
SELECT nom, nom_specialite, nom_lieu FROM `villageois` v, lieu l, specialite s WHERE v.ID_SPECIALITE = s.ID_SPECIALITE AND v.ID_LIEU = l.ID_LIEU 
-- 3) Nom des spécialités avec nombre de gaulois par spécialité (trié par nombre de gaulois décroissant)
SELECT `NOM_SPECIALITE`, COUNT(v.ID_SPECIALITE) AS nbre FROM `specialite` s, villageois v WHERE v.ID_SPECIALITE = s.ID_SPECIALITE GROUP BY NOM_SPECIALITE ORDER BY nbre DESC 
-- 4) Nom des batailles + lieu de la plus récente à la plus ancienne (dates au format jj/mm/aaaa)
SELECT `NOM_BATAILLE`, DATE_FORMAT(`DATE_BATAILLE`,"%d/%m/%Y") from bataille b, lieu l WHERE b.ID_LIEU = l.ID_LIEU ORDER BY DATE_BATAILLE DESC 

-------------------------------
-- 5) Nom des potions + coût de réalisation de la potion (trié par coût décroissant)
CREATE view coutPotion AS SELECT p.ID_POTION, i.id_ingredient, (COUNT(qte)*i.cout_ingredient) AS coutIngPotion FROM potion p, ingredient i, compose c WHERE p.ID_POTION = c.ID_POTION AND i.id_ingredient = c.ID_INGREDIENT GROUP BY c.QTE ORDER BY `p`.`ID_POTION` ASC 
SELECT nom_potion, SUM(`coutIngPotion`) FROM `coutpotion` c, potion p WHERE p.ID_POTION = c.`ID_POTION` GROUP BY p.NOM_POTION ORDER BY SUM(`coutIngPotion`) ASC 
---> je me suis trompé quelque-part, je n'ai pas la même réponse que Stéphane… Par ailleurs j'aurais pu cumuler le sum et count et ne pas faire de create views.
Soluce Stéphane : 
SELECT nom_potion, sum(i.cout_ingredient * c.QTE) as cout from ingredient i inner join compose c on c.id_ingredient = i.id_ingredient inner join potion p on p.id_potion = c.id_potion group by p.id_potion ORDER by cout desc
-- En fait il fallait que je fasse sum(cout*quantité), et pas ce que j'ai fait.
--------------------------------

-- 6) Nom des ingrédients + coût + quantité de chaque ingrédient qui composent la potion 'Potion V'
SELECT nom_ingredient, cout_ingredient, qte FROM `compose` c, ingredient i, potion p WHERE c.ID_INGREDIENT = i.ID_INGREDIENT AND p.ID_POTION = c.ID_POTION AND nom_potion = 'Potion V' 

------------------------------
-- 7) Nom du ou des villageois qui ont pris le plus de casques dans la bataille 'Babaorum'
CREATE VIEW qteCasquesBabaorum AS SELECT NOM, SUM(QTE) from villageois v, prise_casque p, bataille b WHERE nom_bataille = 'Babaorum' AND v.ID_VILLAGEOIS = p.ID_VILLAGEOIS AND b.ID_BATAILLE = p.ID_BATAILLE GROUP BY id_casque, NOM 
SELECT `NOM`, `SUM(QTE)` FROM qtecasquesbabaorum ORDER BY `SUM(QTE)` DESC LIMIT 1 

-- Après la correction j'ai testé la sous-requête et effectivement j'arrive à utiliser Max :
SELECT `SUM(QTE)`, NOM FROM `qtecasquesbabaorum` GROUP BY `NOM` HAVING `SUM(QTE)` = (SELECT MAX(`SUM(QTE)`) FROM qtecasquesbabaorum) 

--( j'aurais pu faire directement : )
SELECT NOM, SUM(QTE) as somme from villageois v, prise_casque p, bataille b WHERE nom_bataille = 'Babaorum' AND v.ID_VILLAGEOIS = p.ID_VILLAGEOIS AND b.ID_BATAILLE = p.ID_BATAILLE GROUP BY id_casque, NOM ORDER BY somme DESC LIMIT 1 

-- Cette solution fonctionne mais n'aurait pas convenu si plusieurs personnes partageaient le même record ! Dans ce cas, il faut passer par un create view + une sous-requête.
-- Voilà ce que ça donne (soluce Stéphane) :
CREATE VIEW scores_casques_bataille AS SELECT v.NOM, b.NOM_BATAILLE, SUM(pc.QTE) AS nbCasques FROM villageois v, bataille b, prise_casque pc WHERE pc.ID_VILLAGEOIS = v.ID_VILLAGEOIS AND pc.ID_BATAILLE = b.ID_BATAILLE GROUP BY v.NOM ORDER BY v.NOM ASC
SELECT v.`NOM`, b.`NOM_BATAILLE`, sum(pc.qte) as nbCasques FROM villageois v, bataille b, prise_casque pc WHERE pc.ID_VILLAGEOIS = v.ID_VILLAGEOIS AND pc.ID_BATAILLE = b.ID_BATAILLE GROUP BY v.NOM HAVING nbCasques = (SELECT MAX(sc.nbCasques) FROM scores_casques_bataille sc WHERE sc.NOM_BATAILLE = "Babaorum") 
-----------------------------

-- 8) Nom des villageois et la quantité de potion bue (en les classant du plus grand buveur au plus petit)
SELECT SUM(DOSE), v.nom FROM `boit` b, villageois v WHERE v.ID_VILLAGEOIS = b.ID_VILLAGEOIS GROUP BY v.NOM ORDER BY `SUM(DOSE)` DESC 

-----------------------------
-- 9) Nom de la bataille où le nombre de casques pris a été le plus important
SELECT nom_bataille, SUM(`QTE`) AS totalCasques FROM `prise_casque` p, bataille b WHERE p.id_bataille = b.ID_BATAILLE GROUP BY p.ID_BATAILLE ORDER BY totalCasques DESC LIMIT 1 
---> faux ! il faut obtenir SEULEMENT le nom de la bataille, et PAS le nombre de casques ! 
-- Du coup ça donne :
-- (j'ai réutilisé les connaissances acquises à la correction de la question 7 pour trouver la bonne réponse)
CREATE view totalCasques AS SELECT nom_bataille, SUM(`QTE`) AS totalCasques FROM `prise_casque` p, bataille b WHERE p.id_bataille = b.ID_BATAILLE GROUP BY p.ID_BATAILLE ORDER BY totalCasques 
SELECT `nom_bataille` FROM `totalcasques` WHERE `totalCasques` = (SELECT MAX(`totalCasques`) FROM `totalcasques`) 
-----------------------------

-- 10) Combien existe-t-il de casques de chaque type et quel est leur coût total ? (classés par nombre décroissant)
SELECT COUNT(c.ID_CASQUE) AS totalTypes, SUM(`COUT_CASQUE`) AS CoutParType, nom_type_casque FROM `casque` c, type_casque t WHERE c.id_type_casque = t.ID_TYPE_CASQUE GROUP BY c.ID_TYPE_CASQUE ORDER BY totalTypes DESC 
-- 11) Noms des potions dont un des ingrédients est la cerise
SELECT `NOM_POTION` FROM `potion` p, ingredient i, compose c WHERE p.id_potion = c.ID_POTION AND i.ID_INGREDIENT = c.ID_INGREDIENT AND nom_ingredient = 'Cerise' 

----------------------------
-- 12) Nom du / des village(s) possédant le plus d'habitants
SELECT nom_lieu, COUNT(`ID_VILLAGEOIS`) AS population FROM `villageois` v, lieu l WHERE v.id_lieu = l.ID_LIEU GROUP BY v.ID_LIEU ORDER BY nom_lieu DESC LIMIT 1 
----> à refaire ! puisque on veut SEULEMENT le nom du village, et pas le nombre d'habitants !
-- Ce qui donne :

CREATE VIEW popParVillage AS SELECT nom_lieu, COUNT(`ID_VILLAGEOIS`) AS population FROM `villageois` v, lieu l WHERE v.id_lieu = l.ID_LIEU GROUP BY v.ID_LIEU ORDER BY nom_lieu DESC
SELECT `nom_lieu` FROM `popparvillage` WHERE `population` = (SELECT MAX(`population`) FROM popparvillage) 
---------------------------

-- 13) Noms des villageois qui n'ont jamais bu de potion
SELECT nom FROM villageois LEFT JOIN boit ON villageois.ID_VILLAGEOIS = boit.ID_VILLAGEOIS WHERE boit.ID_VILLAGEOIS IS NULL 
-- 14) Noms des villages qui contiennent la particule 'um'
SELECT `NOM_LIEU` FROM `lieu` WHERE `NOM_LIEU` LIKE '%um%' 
-- 15) Nom du / des villageois qui n'ont pas le droit de boire la potion 'Rajeunissement II'
SELECT nom FROM `peut` p, villageois v, potion po WHERE A_LE_DROIT = 0 AND nom_potion = 'Rajeunissement II' AND v.ID_VILLAGEOIS = p.ID_VILLAGEOIS AND po.ID_POTION = p.ID_POTION 
(marche aussi avec false au lieu de 0)

------


