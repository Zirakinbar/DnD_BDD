psql.exe -U postgres -d DnD > C:\Users\emrik\Documents\Master\DnDbase\git\TestOutput.txt & type C:\Users\emrik\Documents\Master\DnDbase\git\TestOutput.txt
SET CLIENT_ENCODING TO 'UTF8';


-- FonctionInventaireDetail
	-- Retourne les items détaillés présent dans l'inventaire d'un joueur cible
	CREATE OR REPLACE FUNCTION FonctionInventaireDetail(NumPersonnage INT)
	RETURNS TABLE (
		Id INT,
		Nom VARCHAR(255),
		Description TEXT,
		Qte INT,
		Effet VARCHAR(255),
		PointDeVieBase INT,
		ArmureBase INT,
		DegatsBase INT
	) AS $$
	BEGIN
		RETURN QUERY
		SELECT IV.Id_Personnage, I.Nom, I.Description, IV.Qte, C.Effet, AU.PointDeVieBase, AU.ArmureBase, A.DegatsBase
			FROM INVENTAIRE IV
			LEFT JOIN ITEM I ON IV.Id_Item = I.Id
			LEFT JOIN ARMURE AU ON I.Id = AU.Id
			LEFT JOIN ARME A ON I.Id = A.Id
			LEFT JOIN CONSOMMABLE C ON I.Id = C.Id
			WHERE IV.Id_Personnage = NumPersonnage
			ORDER BY I.Id;
	END;
	$$ LANGUAGE plpgsql;

-- FormatFonctionInventaireDetail
	-- Met en forme le retour de la fonction FonctionInventaireDetail
	CREATE OR REPLACE FUNCTION FormatFonctionInventaireDetail(personnage_id INT)
	RETURNS TEXT AS $$
	DECLARE
		formatted_data TEXT := '';
		item_record RECORD;
		max_nom_length INT;
		max_description_length INT;
		string_length INT;
	BEGIN
		-- Obtenir la longueur maximale des Champs
		SELECT MAX(LENGTH(Nom)) INTO max_nom_length FROM FonctionInventaireDetail(personnage_id);
		SELECT MAX(LENGTH(Description)) INTO max_description_length FROM FonctionInventaireDetail(personnage_id);

		-- Ajouter le titre "Inventaire de : "
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || CHR(09) || 'Inventaire de : ' || (SELECT Nom FROM PERSONNAGE WHERE Id = personnage_id) || CHR(09) || CHR(09) || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(10);

		--Ajouter les noms de colonne du tableau
		formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || lpad('Nom', max_nom_length, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || 
						CHR(09) || lpad('Description', max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || 'Quantité' || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(10);
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || lpad('_', max_nom_length, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || 
						CHR(09) || lpad('_', max_description_length, '_') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('_', 8, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(10);
		string_length := LENGTH((SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || lpad('Nom', max_nom_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || 
						CHR(09) || lpad('Description', max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || 'Quantité' || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4));


		-- Parcourir les éléments de l'inventaire
		FOR item_record IN (SELECT * FROM FonctionInventaireDetail(personnage_id))
		LOOP
			-- Ajouter chaque élément à la chaîne en les alignant
			formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || 
							  lpad(item_record.Nom, max_nom_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
							  CHR(09) || lpad(item_record.Description, max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
							  CHR(09) || item_record.Qte || CHR(09) || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4);

			IF item_record.Effet IS NOT NULL THEN
				formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || CHR(09) || CHR(09) || CHR(09) || CHR(09) || 'Effet : ' || item_record.Effet || (SELECT Chaine FROM BYPASS WHERE Id = 4);
			ELSIF item_record.ArmureBase IS NOT NULL THEN
				formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || CHR(09) || CHR(09) || CHR(09) || CHR(09) || 'Point De Vie  : ' || item_record.PointDeVieBase|| CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09)  || 'Armure de base : ' || item_record.ArmureBase || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4);
			ELSIF item_record.DegatsBase IS NOT NULL THEN
				formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || CHR(09) || CHR(09) || CHR(09) || CHR(09) || 'Dégats : ' || item_record.DegatsBase || (SELECT Chaine FROM BYPASS WHERE Id = 4);
			END IF;



			formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || lpad('', max_nom_length, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || 
							CHR(09) || lpad('', max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
							CHR(09) || lpad('', 8, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(10);
		END LOOP;

		-- Début de la chaîne
		formatted_data := (SELECT Chaine FROM BYPASS WHERE Id = 1) || lpad((SELECT Chaine FROM BYPASS WHERE Id = 2), (string_length+27) , (SELECT Chaine FROM BYPASS WHERE Id = 2)) || (SELECT Chaine FROM BYPASS WHERE Id = 3) || CHR(10) || formatted_data;
		-- Fin de la chaîne
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 5) || lpad((SELECT Chaine FROM BYPASS WHERE Id = 2), (string_length+27) , (SELECT Chaine FROM BYPASS WHERE Id = 2)) || (SELECT Chaine FROM BYPASS WHERE Id = 6);

		RETURN formatted_data;
	END;
	$$ LANGUAGE plpgsql;


SELECT FormatFonctionInventaireDetail(92);





-- FonctionGrimoireDetail
	-- Retourne les sorts détaillés présent dans le grimoire d'un joueur cible
	CREATE OR REPLACE FUNCTION FonctionGrimoireDetail(NumPersonnage INT)
	RETURNS TABLE (
		Id INT,
		Nom VARCHAR(255),
		Description TEXT,
		Niveau INT,
		DegatsBase INT,
		Composantes VARCHAR(255),
		TempsIncantation INT,
		Portee INT,
		EcoleMagie VARCHAR(255)
	) AS $$
	BEGIN
		RETURN QUERY
		SELECT S.Id, S.Nom, S.Description, S.Niveau, S.DegatsBase, S.Composantes, S.TempsIncantation, S.Portee, S.Nom_EcoleMagie
			FROM GRIMOIRE G
			INNER JOIN SORT S ON G.Id_Sort = S.Id
			WHERE G.Id_Personnage = NumPersonnage
			ORDER BY S.Id;
	END;
	$$ LANGUAGE plpgsql;




-- FormatFonctionGrimoireDetail
	-- Met en forme le retour de la fonction FonctionGrimoireDetail
	CREATE OR REPLACE FUNCTION FormatFonctionGrimoireDetail(personnage_id INT)
	RETURNS TEXT AS $$
	DECLARE
		formatted_data TEXT := '';
		item_record RECORD;
		max_nom_length INT;
		max_description_length INT;
		max_composantes_length INT;
		max_ecolemagie_length INT;
		string_length INT;
	BEGIN
		-- Obtenir la longueur maximale des Champs
		SELECT MAX(LENGTH(Nom)) INTO max_nom_length FROM FonctionGrimoireDetail(personnage_id);
		SELECT MAX(LENGTH(Description)) INTO max_description_length FROM FonctionGrimoireDetail(personnage_id);
		SELECT MAX(LENGTH(Composantes)) INTO max_composantes_length FROM FonctionGrimoireDetail(personnage_id);
		SELECT MAX(LENGTH(EcoleMagie)) INTO max_ecolemagie_length FROM FonctionGrimoireDetail(personnage_id);

		-- Ajouter le titre "Inventaire de : "
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || CHR(09) || 'Grimoire de : ' || (SELECT Nom FROM PERSONNAGE WHERE Id = personnage_id) || CHR(09) || CHR(09) || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(10);

		--Ajouter les noms de colonne du tableau
		formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || lpad('Nom', max_nom_length, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || 
						CHR(09) || lpad('Description', max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || 'Niveau Requis' || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || 'Dégats' || CHR(09) || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('Composantes', max_composantes_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || 'Temps d''Incantation' || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || 'Portée' || CHR(09) || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('Ecole de magie', max_ecolemagie_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(10);
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || lpad('_', max_nom_length, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || 
						CHR(09) || lpad('_', max_description_length, '_') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('_', 13, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('_', 8, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('_', max_composantes_length, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('_', 19, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('_', 8, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('_', max_ecolemagie_length, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(10);
		string_length := LENGTH((SELECT Chaine FROM BYPASS WHERE Id = 4) || '    ' || lpad('Nom', max_nom_length, ' ') || '      '  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || 
						'      ' || lpad('Description', max_description_length, ' ') || '      ' || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						'      ' || 'Niveau Requis' || '      '  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						'      ' || 'Dégats' || '      '  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						'      ' || lpad('Composantes', max_composantes_length, ' ') || '      ' || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						'      ' || 'Temps d''Incantation' || '      '  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						'      ' || 'Portée' || '      '  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						'      ' || lpad('Ecole de magie', max_ecolemagie_length, ' ') || '      ' || (SELECT Chaine FROM BYPASS WHERE Id = 4));


		-- Parcourir les éléments de l'inventaire
		FOR item_record IN (SELECT * FROM FonctionGrimoireDetail(personnage_id))
		LOOP
			-- Ajouter chaque élément à la chaîne en les alignant
			formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || lpad(item_record.Nom, max_nom_length, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || 
						CHR(09) || lpad(item_record.Description, max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || item_record.Niveau || CHR(09) || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || item_record.DegatsBase || CHR(09) || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad(item_record.Composantes, max_composantes_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || item_record.TempsIncantation || CHR(09) || CHR(09) || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || item_record.Portee || CHR(09) || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad(item_record.EcoleMagie, max_ecolemagie_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4);

			formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || lpad('', max_nom_length, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || 
						CHR(09) || lpad('', max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('', 13, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('', 8, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('', max_composantes_length, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('', 19, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('', 8, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('', max_ecolemagie_length, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(10);
		END LOOP;

		-- Début de la chaîne
		formatted_data := (SELECT Chaine FROM BYPASS WHERE Id = 1) || lpad((SELECT Chaine FROM BYPASS WHERE Id = 2), string_length, (SELECT Chaine FROM BYPASS WHERE Id = 2)) || (SELECT Chaine FROM BYPASS WHERE Id = 3) || CHR(10) || formatted_data;
		-- Fin de la chaîne
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 5) || lpad((SELECT Chaine FROM BYPASS WHERE Id = 2), string_length, (SELECT Chaine FROM BYPASS WHERE Id = 2)) || (SELECT Chaine FROM BYPASS WHERE Id = 6);

		RETURN formatted_data;
	END;
	$$ LANGUAGE plpgsql;


SELECT FormatFonctionGrimoireDetail(92);
