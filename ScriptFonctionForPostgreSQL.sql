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
		string_length INT;
	BEGIN
		-- Obtenir la longueur maximale des Champs
		SELECT MAX(LENGTH(Nom)) INTO max_nom_length FROM FonctionInventaire(personnage_id);
		SELECT MAX(LENGTH(Description)) INTO max_description_length FROM FonctionInventaire(personnage_id);

		-- Ajouter le titre "Inventaire de : "
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || CHR(09) || 'Inventaire de : ' || (SELECT Nom FROM PERSONNAGE WHERE Id = personnage_id) || CHR(09) || CHR(09) || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(10);

		--Ajouter les noms de colonne du tableau
		formatted_data := formatted_data || CHR(10) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || lpad('Nom', max_nom_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || 
						CHR(09) || lpad('Description', max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || 'Quantité' || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(10);
		formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || lpad('_', max_nom_length, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || 
						CHR(09) || lpad('_', max_description_length, '_') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || lpad('_', 8, '_') || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(10);
		string_length := LENGTH((SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || lpad('Nom', max_nom_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) || 
						CHR(09) || lpad('Description', max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
						CHR(09) || 'Quantité' || CHR(09)  || (SELECT Chaine FROM BYPASS WHERE Id = 4));


		-- Parcourir les éléments de l'inventaire
		FOR item_record IN (SELECT * FROM FonctionInventaire(personnage_id))
		LOOP
			-- Ajouter chaque élément à la chaîne en les alignant
			formatted_data := formatted_data || (SELECT Chaine FROM BYPASS WHERE Id = 4) || CHR(09) || 
							  lpad(item_record.Nom, max_nom_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
							  CHR(09) || lpad(item_record.Description, max_description_length, ' ') || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4) ||
							  CHR(09) || item_record.Qte || CHR(09) || CHR(09) || (SELECT Chaine FROM BYPASS WHERE Id = 4);
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

	-- EXEMPLE DE SORTIE :
	--                                                             formatfonctioninventaire                                                              
	-----------------------------------------------------------------------------------------------------------------------------------------------------
	-- ╔═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·.·:·.═══╗+
	-- ║               Inventaire de : Lichsorcerer                    ║                                                                                +
	--                                                                                                                                                  +
	-- ║                                Nom    ║                                                            Description        ║       Quantité        ║+
	-- ║       ____________________________    ║       ________________________________________________________________        ║       ________        ║+
	-- ║            Cotte de mailles en fer    ║                        Une cotte de mailles en fer pour les guerriers.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║                       Cuir de yeti    ║                      Une armure en cuir de yeti pour le froid extrême.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║                    Arc du Traqueur    ║        Un arc court utilisé par les traqueurs pour chasser les proies.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║                Fléau de la Justice    ║                       Un fléau utilisé par les juges pour l'exécution.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║          Marteau de Forgeron en Or    ║                        Un marteau en or pour des œuvres d'art uniques.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║                 Scie à Bois en Fer    ║                  Une scie en fer pour découper le bois avec précision.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║                  Scie à Bois en Or    ║                 Une scie en or pour des créations de mobilier luxueux.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║         Machine à Coudre en Argent    ║       Une machine à coudre en argent pour des créations haut de gamme.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║          Enclume d'Armurier en Fer    ║                      Une enclume en fer pour la fabrication d'armures.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║            Pioche de Mineur en Fer    ║                       Une pioche en fer pour l'extraction de minéraux.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║       Potion de Résistance Magique    ║                         Une potion qui renforce la résistance magique.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║           Élixir de Chance Modeste    ║                       Un élixir qui augmente temporairement la chance.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║                   Minerai d'Argent    ║        Un minerai précieux utilisé pour frapper des pièces de monnaie.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ╚═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·.·:·.═══╝
	--(1 ligne)
	--
	--                                                              formatfonctioninventaire                                                               
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-- ╔═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·.·:·.═══╗+
	-- ║               Inventaire de : Necrocleric                     ║                                                                                  +
	--                                                                                                                                                    +
	-- ║                             Nom       ║                                                                 Description   ║       Quantité        ║  +
	-- ║       _________________________       ║       _____________________________________________________________________   ║       ________        ║  +
	-- ║             Arc du Vent Céleste       ║            Un arc long qui tire des flèches guidées par les vents célestes.   ║       1               ║  +
	-- ║                                       ║                                                                               ║                       ║  +
	-- ║       Fouet de la Lueur Lunaire       ║       Un fouet enchanté par la lueur de la lune pour des attaques précises.   ║       1               ║  +
	-- ║                                       ║                                                                               ║                       ║  +
	-- ║          Machine à Coudre en Or       ║                      Une machine à coudre en or pour des vêtements de luxe.   ║       1               ║  +
	-- ║                                       ║                                                                               ║                       ║  +
	-- ╚═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·.·:·.═══╝
	--(1 ligne)
	--
	--                                                                     formatfonctioninventaire                                                                      
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- ╔═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·.·:·.═══╗ +
	-- ║               Inventaire de : Aelarion                        ║                                                                                                +
	--                                                                                                                                                                  +
	-- ║                             Nom       ║                                                                              Description      ║       Quantité        ║+
	-- ║       _________________________       ║       __________________________________________________________________________________      ║       ________        ║+
	-- ║           Étoiles de l'Assassin       ║             Des étoiles de jet utilisées par les assassins pour des attaques sournoises.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║            Étoiles de la Foudre       ║       Des étoiles de jet chargées d'énergie électrique pour des attaques étourdissantes.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║              Scie à Bois en Fer       ║                                    Une scie en fer pour découper le bois avec précision.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║        Couteau de Chef en Acier       ║                      Un couteau de chef en acier pour la préparation de repas délicieux.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║              Sécateur en Cuivre       ║                           Un sécateur en cuivre pour des coupes précises dans le jardin.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║              Sécateur en Titane       ║                                       Un sécateur en titane pour des coupes impeccables.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║             Canne à Pêche en Or       ║                                       Une canne à pêche en or pour la pêche de trophées.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║       Enclume d'Armurier en Fer       ║                                        Une enclume en fer pour la fabrication d'armures.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║         Minerai de Diamant Noir       ║                             Un minerai exceptionnellement rare connu pour sa résistance.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ╚═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·.·:·.═══╝
	--(1 ligne)

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

	-- EXEMPLE DE SORTIE :
	--                                                          formatfonctioninventairedetail                                                           
	-----------------------------------------------------------------------------------------------------------------------------------------------------
	-- ╔═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·.·:·.═══╗+
	-- ║               Inventaire de : Lichsorcerer                    ║                                                                                +
	--                                                                                                                                                  +
	-- ║                                Nom    ║                                                            Description        ║       Quantité        ║+
	-- ║       ____________________________    ║       ________________________________________________________________        ║       ________        ║+
	-- ║            Cotte de mailles en fer    ║                        Une cotte de mailles en fer pour les guerriers.        ║       1               ║+
	-- ║                                       Point De Vie  : 145     ║       Armure de base : 85     ║                                                +
	-- ║                                       ║                                                                               ║                       ║+
	-- ║                       Cuir de yeti    ║                      Une armure en cuir de yeti pour le froid extrême.        ║       1               ║+
	-- ║                                       Point De Vie  : 130     ║       Armure de base : 75     ║                                                +
	-- ║                                       ║                                                                               ║                       ║+
	-- ║                    Arc du Traqueur    ║        Un arc court utilisé par les traqueurs pour chasser les proies.        ║       1               ║+
	-- ║                                       Dégats : 35║                                                                                             +
	-- ║                                       ║                                                                               ║                       ║+
	-- ║                Fléau de la Justice    ║                       Un fléau utilisé par les juges pour l'exécution.        ║       1               ║+
	-- ║                                       Dégats : 55║                                                                                             +
	-- ║                                       ║                                                                               ║                       ║+
	-- ║          Marteau de Forgeron en Or    ║                        Un marteau en or pour des œuvres d'art uniques.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║                 Scie à Bois en Fer    ║                  Une scie en fer pour découper le bois avec précision.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║                  Scie à Bois en Or    ║                 Une scie en or pour des créations de mobilier luxueux.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║         Machine à Coudre en Argent    ║       Une machine à coudre en argent pour des créations haut de gamme.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║          Enclume d'Armurier en Fer    ║                      Une enclume en fer pour la fabrication d'armures.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║            Pioche de Mineur en Fer    ║                       Une pioche en fer pour l'extraction de minéraux.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ║       Potion de Résistance Magique    ║                         Une potion qui renforce la résistance magique.        ║       1               ║+
	-- ║                                       Effet : Augmente la résistance aux sorts pendant 2 minutes.║                                             +
	-- ║                                       ║                                                                               ║                       ║+
	-- ║           Élixir de Chance Modeste    ║                       Un élixir qui augmente temporairement la chance.        ║       1               ║+
	-- ║                                       Effet : Augmente la chance de 10% pendant 5 minutes.║                                                    +
	-- ║                                       ║                                                                               ║                       ║+
	-- ║                   Minerai d'Argent    ║        Un minerai précieux utilisé pour frapper des pièces de monnaie.        ║       1               ║+
	-- ║                                       ║                                                                               ║                       ║+
	-- ╚═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·.·:·.═══╝
	--(1 ligne)
	--
	--                                                           formatfonctioninventairedetail                                                            
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-- ╔═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·.·:·.═══╗+
	-- ║               Inventaire de : Necrocleric                     ║                                                                                  +
	--                                                                                                                                                    +
	-- ║                             Nom       ║                                                                 Description   ║       Quantité        ║  +
	-- ║       _________________________       ║       _____________________________________________________________________   ║       ________        ║  +
	-- ║             Arc du Vent Céleste       ║            Un arc long qui tire des flèches guidées par les vents célestes.   ║       1               ║  +
	-- ║                                       Dégats : 45║                                                                                               +
	-- ║                                       ║                                                                               ║                       ║  +
	-- ║       Fouet de la Lueur Lunaire       ║       Un fouet enchanté par la lueur de la lune pour des attaques précises.   ║       1               ║  +
	-- ║                                       Dégats : 30║                                                                                               +
	-- ║                                       ║                                                                               ║                       ║  +
	-- ║          Machine à Coudre en Or       ║                      Une machine à coudre en or pour des vêtements de luxe.   ║       1               ║  +
	-- ║                                       ║                                                                               ║                       ║  +
	-- ╚═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·.·:·.═══╝
	--(1 ligne)
	--
	--                                                                  formatfonctioninventairedetail                                                                   
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- ╔═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·.·:·.═══╗ +
	-- ║               Inventaire de : Aelarion                        ║                                                                                                +
	--                                                                                                                                                                  +
	-- ║                             Nom       ║                                                                              Description      ║       Quantité        ║+
	-- ║       _________________________       ║       __________________________________________________________________________________      ║       ________        ║+
	-- ║           Étoiles de l'Assassin       ║             Des étoiles de jet utilisées par les assassins pour des attaques sournoises.      ║       1               ║+
	-- ║                                       Dégats : 35║                                                                                                             +
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║            Étoiles de la Foudre       ║       Des étoiles de jet chargées d'énergie électrique pour des attaques étourdissantes.      ║       1               ║+
	-- ║                                       Dégats : 35║                                                                                                             +
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║              Scie à Bois en Fer       ║                                    Une scie en fer pour découper le bois avec précision.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║        Couteau de Chef en Acier       ║                      Un couteau de chef en acier pour la préparation de repas délicieux.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║              Sécateur en Cuivre       ║                           Un sécateur en cuivre pour des coupes précises dans le jardin.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║              Sécateur en Titane       ║                                       Un sécateur en titane pour des coupes impeccables.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║             Canne à Pêche en Or       ║                                       Une canne à pêche en or pour la pêche de trophées.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║       Enclume d'Armurier en Fer       ║                                        Une enclume en fer pour la fabrication d'armures.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ║         Minerai de Diamant Noir       ║                             Un minerai exceptionnellement rare connu pour sa résistance.      ║       1               ║+
	-- ║                                       ║                                                                                               ║                       ║+
	-- ╚═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·.·:·.═══╝
	--(1 ligne)
