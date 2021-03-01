
1/
--a) Donner la liste des titres des représentations
SELECT titre_representation FROM representation 
--b) Donner la liste des titres des représentations ayant lieu à …
SELECT * FROM representation WHERE lieu = 'Paris' 
--c) Donner la liste des noms des musiciens et des titres des représentations auxquelles ils participent
SELECT nom, titre_representation FROM musicien, representation WHERE musicien.numero_representation = representation.numero_representation 
--d) Donner la liste des titres des représentations, les lieux et les tarifs pour la journée du 14/09/2014. 
SELECT titre_representation, lieu, tarif FROM representation, programme WHERE programme.date = '2021-02-05' AND representation.numero_representation = programme.numero_representation 

2/
--a) Quel est le nombre total d'étudiants ?
SELECT COUNT(*) FROM Etudiant 
--b) Quelles sont, parmi l'ensemble des notes, la note la plus haute et la note la plus basse ?
SELECT MAX(note), MIN(note) FROM Evaluer 
--c) Quelles sont les moyennes de chaque étudiant dans chacune des matières ? (utilisez CREATE VIEW)
SELECT AVG(note), nom, libelleMat FROM `moyennes` GROUP BY nom, libelleMat 
--d) Quelles sont les moyennes par matière ? (cf. question c)
SELECT AVG(note), libelleMat FROM `moyennes` GROUP BY libelleMat 
--e) Quelle est la moyenne générale de chaque étudiant ? (utilisez CREATE VIEW + cf. question 3)
SELECT AVG(note), nom FROM `moyennes` GROUP BY nom 
--f) Quelle est la moyenne générale de la promotion ? (cf. question e)
SELECT AVG(note) FROM `moyennes` 
--g) Quels sont les étudiants qui ont une moyenne générale supérieure ou égale à la moyenne générale de la promotion ? (cf. question e)
SELECT AVG(note), nom FROM `moyennes` GROUP BY nom HAVING ((AVG(note))>=(SELECT AVG(note) FROM moyennes)) 

---> oublié tenir compte coeffs !!!!

---> dernière question  plus simple à résoudre avec un meilleur emploi des views !

3/
--a)  Numéros et libellés des articles dont le stock est inférieur à 10 ?
SELECT NoArt, libelle FROM `Articles` WHERE stock < 10 
--b) Liste des articles dont le prix d'inventaire est compris entre 100 et 300 ?
SELECT * FROM `Articles` WHERE (prixInvent > 100) AND (prixInvent < 300) 
SELECT * FROM `Articles` WHERE prixInvent BETWEEN 100 AND 300 /*(mieux)*/
--c) Liste des fournisseurs dont on ne connaît pas l'adresse ?
SELECT * FROM `Fournisseurs` WHERE adrFour IS NULL /*(-> réclame que l'adresse ait été définie comme null, et pas simplement laissée vide)*/
-- d) Liste des fournisseurs dont le nom commence par "STE" ? -->(j'ai remplacé par NIM)
SELECT * FROM `Fournisseurs` WHERE nomFour LIKE 'nim%' 
-- e) Noms et adresses des fournisseurs qui proposent des articles pour lesquels le délai d'approvisionnement est supérieur à 20 jours ?
SELECT nomFour, adrFour FROM `Fournisseurs` f, acheter a WHERE (a.delai > 20) AND f.noFour = a.noFour 
-- j) Délai moyen pour chaque fournisseur proposant au moins 2 articles ?
SELECT AVG(delai), nomFour as DelaiMoyen FROM `acheter` a, Fournisseurs f WHERE a.noFour = f.noFour GROUP BY nomFour HAVING COUNT(a.noFour) >= 2 

4/
-- a) Liste de tous les étudiants
SELECT * FROM `Etudiant` 
-- b) Liste de tous les étudiants, classée par ordre alphabétique inverse
SELECT nom, prenom FROM `Etudiant` ORDER BY nom DESC 
-- c) Libellé et coefficient (exprimé en pourcentage) de chaque matière
SELECT libelle, coef FROM `Matiere` /* pour les pourcents je sais pas du tout…*/ 
-- correction Stéphane :
SELECT libelle, coef*100/18 FROM `Matiere`/* (prise en compte pourcentages coeffs)*/

-- d) Nom et prénom de chaque étudiant
SELECT nom, prenom FROM `Etudiant` 
-- e) Nom et prénom des étudiants domiciliés à Lyon (->Francon dans mon cas)
SELECT nom, prenom FROM `Etudiant` WHERE (ville = 'Francon') 
-- f) Liste des notes supérieures ou égales à 10 (-> je vais faire 14)
SELECT * FROM `notation` WHERE note >= 14 
-- g) Liste des épreuves dont la date se situe entre le 1er janvier et le 30 juin 2014 (-> j'ai fait autre chose avec les dates)
SELECT * FROM `Epreuve` WHERE datEpreuve BETWEEN '2019-01-01' AND '2021-11-13' 
-- h) Nom, prénom et ville des étudiants dont la ville contient la chaîne "ll" (LL) (-> remplacé par au)
SELECT nom, prenom, ville FROM `Etudiant` WHERE ville LIKE '%au%' 
-- i) Prénoms des étudiants de nom Dupont, Durand ou Martin (-> pris autres noms)
SELECT prenom FROM `Etudiant` WHERE (nom = 'Bousier') OR (nom = 'Goison') 
/*Autre solution : */ WHERE nom IN ("Bousier, Goison")
-- j) Somme des coefficients de toutes les matières
SELECT SUM(coef) FROM `Matiere` 
-- k) Nombre total d'épreuves
SELECT COUNT(*) FROM `Epreuve` 
-- l) Nombre de notes indéterminées (NULL)
SELECT COUNT(*) FROM `notation` WHERE note IS NULL 
-- m) Liste des épreuves (numéro, date et lieu) incluant le libellé de la matière
SELECT numEpreuve, datEpreuve, lieu, libelle FROM `Epreuve` e, `Matiere` m WHERE e.codeMat = m.codeMat 
-- n) Liste des notes en précisant pour chacune le nom et le prénom de l'étudiant qui l'a obtenue
SELECT note, nom, prenom FROM `notation` n, Etudiant e WHERE e.numEtu = n.numetu 
-- o) Liste des notes en précisant pour chacune le nom et le prénom de l'étudiant qui l'a obtenue et le libellé de la matière concernée
SELECT note, nom, prenom, libelle FROM Epreuve ep, `notation` n, Etudiant et, Matiere m WHERE et.numEtu = n.numetu AND n.numepreuve = ep.numEpreuve AND m.codeMat = ep.codeMat 
-- p) Nom et prénom des étudiants qui ont obtenu au moins une note égale à 20
SELECT note, prenom, nom FROM notation, Etudiant WHERE note >=20 AND notation.numEtu = Etudiant.numEtu 
-- q) Moyennes des notes de chaque étudiant (indiquer le nom et le prénom)
SELECT AVG(note), nom, prenom FROM `notation` n, Etudiant e WHERE n.numEtu = e.numEtu GROUP BY nom 
-- r) Moyennes des notes de chaque étudiant (indiquer le nom et le prénom), classées de la meilleure à la moins bonne
SELECT AVG(note), nom, prenom FROM `notation` n, Etudiant e WHERE n.numEtu = e.numEtu GROUP BY nom ORDER BY AVG(note) DESC 
-- s) Moyennes des notes pour les matières (indiquer le libellé) comportant plus d'une épreuve
-- CORRECTION (je n'arrivais pas à afficher le bon résultat):
SELECT libelle, AVG(note) FROM `notation` n, Matiere m, Epreuve e WHERE m.codeMat = e.codeMat AND n.numEpreuve = e.numEpreuve GROUP BY libelle HAVING COUNT(DISTINCT e.numEpreuve) > 1 /* retourne un résultat vide chez moi… chelou…)*/
-- t) Moyennes des notes obtenues aux épreuves (indiquer le numéro d'épreuve) où moins de 6 étudiants ont été notés
SELECT numEpreuve, AVG(note) FROM `notation` n WHERE note IS NOT NULL GROUP BY numEpreuve HAVING COUNT(*) < 6 

-- 5/
-- a) Ajouter un nouveau fournisseur avec les attributs de votre choix
INSERT INTO Fournisseur (`NomF`) VALUES ('Marcelormittal') 
/*OU (correction)*/ INSERT INTO Fournisseur VALUES (45, 'Truc', 'Sous-traitant', 'Strasbourg') 
-- b) Supprimer tous les produits de couleur noire et de numéros compris entre 100 et 1999
DELETE FROM `Produit` WHERE `Couleur` = 'noir' AND NumP BETWEEN 100 AND 1999 
-- c) Changer la ville du fournisseur 3 par Mulhouse
UPDATE Fournisseur SET VilleF = 'Mulhouse' WHERE NumF = 3 