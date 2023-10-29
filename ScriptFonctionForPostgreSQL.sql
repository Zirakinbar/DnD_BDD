-- FonctionInventaire
	-- Retourne les items présent dans l'inventaire d'un joueur cible
	CREATE OR REPLACE FUNCTION FonctionInventaire(NumPersonnage INT)
	RETURNS TABLE (
		Id INT,
		Nom VARCHAR(255),
		Description TEXT,
		Qte INT
	) AS $$
	BEGIN
		RETURN QUERY
		SELECT IV.Id_Personnage, I.Nom, I.Description, IV.Qte
			FROM INVENTAIRE IV
			LEFT JOIN ITEM I ON IV.Id_Item = I.Id
			WHERE IV.Id_Personnage = NumPersonnage
			ORDER BY I.Id;
	END;
	$$ LANGUAGE plpgsql;

-- FormatFonctionInventaire
	-- Met en forme le retour de la fonction FonctionInventaire
	CREATE OR REPLACE FUNCTION FormatFonctionInventaire(personnage_id INT)
	RETURNS TEXT AS $$
	DECLARE
		formatted_data TEXT := '';
		item_record RECORD;
		max_nom_length INT;
		max_description_length INT;
	BEGIN
		-- Obtenir la longueur maximale des Champs
		SELECT MAX(LENGTH(Nom)) INTO max_nom_length FROM FonctionInventaire(personnage_id);
		SELECT MAX(LENGTH(Description)) INTO max_description_length FROM FonctionInventaire(personnage_id);

		-- Début de la chaîne
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 1) || CHR(10);

		-- Ajouter le titre "Inventaire de : "
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(09) || CHR(09) || 'Inventaire de : ' || (SELECT Nom FROM PERSONNAGE WHERE Id = personnage_id) || CHR(09) || CHR(09) || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(10);

		--Ajouter les noms de colonne du tableau
		formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(09) || lpad('Nom', max_nom_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2) || 
						CHR(09) || lpad('Description', max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2) ||
						CHR(09) || 'Quantité' || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(10);
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(09) || lpad('_', max_nom_length, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 2) || 
						CHR(09) || lpad('_', max_description_length, '_') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2) ||
						CHR(09) || lpad('_', 8, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(10);


		-- Parcourir les éléments de l'inventaire
		FOR item_record IN (SELECT * FROM FonctionInventaire(personnage_id))
		LOOP
			-- Ajouter chaque élément à la chaîne en les alignant
			formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(09) || 
							  lpad(item_record.Nom, max_nom_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2) ||
							  CHR(09) || lpad(item_record.Description, max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2) ||
							  CHR(09) || item_record.Qte || CHR(09) || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2);
			formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(09) || lpad('', max_nom_length, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 2) || 
							CHR(09) || lpad('', max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2) ||
							CHR(09) || lpad('', 8, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(10);
		END LOOP;

		-- Fin de la chaîne
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 3);

		RETURN formatted_data;
	END;
	$$ LANGUAGE plpgsql;

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
	BEGIN
		-- Obtenir la longueur maximale des Champs
		SELECT MAX(LENGTH(Nom)) INTO max_nom_length FROM FonctionInventaireDetail(personnage_id);
		SELECT MAX(LENGTH(Description)) INTO max_description_length FROM FonctionInventaireDetail(personnage_id);

		-- Début de la chaîne
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 1) || CHR(10);

		-- Ajouter le titre "Inventaire de : "
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(09) || CHR(09) || 'Inventaire de : ' || (SELECT Nom FROM PERSONNAGE WHERE Id = personnage_id) || CHR(09) || CHR(09) || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(10);

		--Ajouter les noms de colonne du tableau
		formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(09) || lpad('Nom', max_nom_length, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 2) || 
						CHR(09) || lpad('Description', max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2) ||
						CHR(09) || 'Quantité' || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(10);
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(09) || lpad('_', max_nom_length, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 2) || 
						CHR(09) || lpad('_', max_description_length, '_') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2) ||
						CHR(09) || lpad('_', 8, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(10);


		-- Parcourir les éléments de l'inventaire
		FOR item_record IN (SELECT * FROM FonctionInventaireDetail(personnage_id))
		LOOP
			-- Ajouter chaque élément à la chaîne en les alignant
			formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(09) || 
							  lpad(item_record.Nom, max_nom_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2) ||
							  CHR(09) || lpad(item_record.Description, max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2) ||
							  CHR(09) || item_record.Qte || CHR(09) || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2);

			IF item_record.Effet IS NOT NULL THEN
				formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(09) || CHR(09) || CHR(09) || CHR(09) || CHR(09) || 'Effet : ' || item_record.Effet || (SELECT Chaine FROM BYPASS WHERE Id = 2);
			ELSIF item_record.ArmureBase IS NOT NULL THEN
				formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(09) || CHR(09) || CHR(09) || CHR(09) || CHR(09) || 'Point De Vie  : ' || item_record.PointDeVieBase|| CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(09)  || 'Armure de base : ' || item_record.ArmureBase || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2);
			ELSIF item_record.DegatsBase IS NOT NULL THEN
				formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(09) || CHR(09) || CHR(09) || CHR(09) || CHR(09) || 'Dégats : ' || item_record.DegatsBase || (SELECT Chaine FROM BYPASS WHERE Id = 2);
			END IF;



			formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(09) || lpad('', max_nom_length, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 2) || 
							CHR(09) || lpad('', max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 2) ||
							CHR(09) || lpad('', 8, ' ') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 2) || CHR(10);
		END LOOP;

		-- Fin de la chaîne
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 3);

		RETURN formatted_data;
	END;
	$$ LANGUAGE plpgsql;