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

	-- EXEMPLE DE SORTIE :
	--                                                                                                                                        formatfonctiongrimoiredetail                                                                                                                                         
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- ╔═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·...·:·.═══╗+
	-- ║               Grimoire de : Lichsorcerer                      ║                                                                                                                                                                                                                                          +
	--                                                                                                                                                                                                                                                                                                            +
	-- ║                          Nom  ║                                                                                  Description  ║       Niveau Requis   ║       Dégats          ║           Composantes ║       Temps d'Incantation     ║       Portée          ║              Ecole de magie   ║          +
	-- ║       ______________________  ║       ______________________________________________________________________________________  ║       _____________   ║       ________        ║       _______________ ║       ___________________     ║       ________        ║       _____________________   ║          +
	-- ║       Barrière de Protection  ║                     Crée une barrière impénétrable pour protéger contre toutes les attaques.  ║       4               ║       0               ║       Verbal, Gestuel ║       3                       ║       10              ║          Magie de l'énergie   ║          +
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                               ║          +
	-- ║               Saut Quantique  ║                          Saute instantanément d'un point à un autre en modifiant la réalité.  ║       4               ║       0               ║         Verbal, Focus ║       5                       ║       30              ║        Magie dimensionnelle   ║          +
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                               ║          +
	-- ║             Saut Acrobatique  ║       Effectue un saut acrobatique pour échapper aux attaques et atterrir en toute élégance.  ║       2               ║       0               ║              Physique ║       0                       ║       1               ║                     Esquive   ║          +
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                               ║          +
	-- ║          Résistance Endurcie  ║                                         Développe une grande résistance physique aux dégâts.  ║       2               ║       0               ║                Mental ║       0                       ║       1               ║                      Parade   ║          +
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                               ║          +
	-- ║          Bouclier de Défense  ║                                  Utilise un bouclier pour se protéger des attaques ennemies.  ║       2               ║       0               ║              Physique ║       0                       ║       1               ║          Magie de l'énergie   ║          +
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                               ║          +
	-- ║              Lancer de Hache  ║                          Lance des haches avec une grande précision et une force surhumaine.  ║       2               ║       70              ║              Physique ║       1                       ║       12              ║       Lancer de projectiles   ║          +
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                               ║          +
	-- ║                 Lancé Précis  ║           Lance des projectiles avec une précision chirurgicale, touchant toujours la cible.  ║       3               ║       90              ║              Physique ║       1                       ║       15              ║       Lancer de projectiles   ║          +
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                               ║          +
	-- ╚═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·...·:·.═══╝
	--(1 ligne)
	--
	--                                                                                                                                   formatfonctiongrimoiredetail                                                                                                                                    
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- ╔═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·.═══╗ +
	-- ║               Grimoire de : Necrocleric                       ║                                                                                                                                                                                                                                +
	--                                                                                                                                                                                                                                                                                                  +
	-- ║                          Nom  ║                                                                    Description        ║       Niveau Requis   ║       Dégats          ║           Composantes ║       Temps d'Incantation     ║       Portée          ║                 Ecole de magie        ║+
	-- ║       ______________________  ║       ________________________________________________________________________        ║       _____________   ║       ________        ║       _______________ ║       ___________________     ║       ________        ║       ________________________        ║+
	-- ║                Téléportation  ║                       Se téléporte instantanément vers une destination connue.        ║       2               ║       0               ║         Verbal, Focus ║       1                       ║       20              ║           Magie dimensionnelle        ║+
	-- ║                               ║                                                                                       ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║                 Soin Céleste  ║                                   Régénère les blessures et guérit les alliés.        ║       2               ║       0               ║       Verbal, Gestuel ║       2                       ║       10              ║              Magie de guérison        ║+
	-- ║                               ║                                                                                       ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║                Rayon Solaire  ║                           Libère un rayon solaire destructeur sur les ennemis.        ║       3               ║       120             ║       Verbal, Gestuel ║       2                       ║       15              ║            Magie de la lumière        ║+
	-- ║                               ║                                                                                       ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║           Bouclier d'Énergie  ║                 Crée un bouclier d'énergie pour bloquer les attaques magiques.        ║       2               ║       0               ║       Verbal, Gestuel ║       2                       ║       8               ║             Magie de l'énergie        ║+
	-- ║                               ║                                                                                       ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║                 Invisibilité  ║                                         Se rend invisible aux yeux des autres.        ║       2               ║       0               ║         Verbal, Focus ║       2                       ║       5               ║                  Illusionnisme        ║+
	-- ║                               ║                                                                                       ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║               Évasion Rapide  ║                  Se déplace à une vitesse surhumaine pour éviter les attaques.        ║       2               ║       0               ║       Verbal, Gestuel ║       1                       ║       10              ║           Magie dimensionnelle        ║+
	-- ║                               ║                                                                                       ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║                Illusionniste  ║                        Manipule la réalité pour créer des illusions complexes.        ║       2               ║       0               ║       Verbal, Gestuel ║       2                       ║       10              ║                  Illusionnisme        ║+
	-- ║                               ║                                                                                       ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║       Barrière de Protection  ║       Crée une barrière impénétrable pour protéger contre toutes les attaques.        ║       4               ║       0               ║       Verbal, Gestuel ║       3                       ║       10              ║             Magie de l'énergie        ║+
	-- ║                               ║                                                                                       ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║            Révélation Divine  ║                      Obtient une connaissance divine sur des sujets mystiques.        ║       4               ║       0               ║         Verbal, Focus ║       2                       ║       15              ║            Magie de la lumière        ║+
	-- ║                               ║                                                                                       ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║                Frappe Rapide  ║            Une série de coups rapides et précis qui désorientent l'adversaire.        ║       1               ║       40              ║              Physique ║       0                       ║       1               ║       Attaque au corps à corps        ║+
	-- ║                               ║                                                                                       ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║              Danse des Lames  ║                Danse avec des lames pour attaquer rapidement et avec élégance.        ║       3               ║       100             ║              Physique ║       0                       ║       2               ║       Attaque au corps à corps        ║+
	-- ║                               ║                                                                                       ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║          Maîtrise du Marteau  ║             Manie un marteau avec une force écrasante et une grande précision.        ║       3               ║       120             ║              Physique ║       0                       ║       1               ║             Magie de l'énergie        ║+
	-- ║                               ║                                                                                       ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ╚═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·.═══╝
	--(1 ligne)
	--
	--                                                                                                                                       formatfonctiongrimoiredetail                                                                                                                                        
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- ╔═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:.·:·.═══╗ +
	-- ║               Grimoire de : Aelarion                  ║                                                                                                                                                                                                                                                +
	--                                                                                                                                                                                                                                                                                                          +
	-- ║                       Nom     ║                                                                               Description     ║       Niveau Requis   ║       Dégats          ║           Composantes ║       Temps d'Incantation     ║       Portée          ║                 Ecole de magie        ║+
	-- ║       ___________________     ║       ___________________________________________________________________________________     ║       _____________   ║       ________        ║       _______________ ║       ___________________     ║       ________        ║       ________________________        ║+
	-- ║          Bouclier d'Éther     ║                    Crée un bouclier d'énergie éthérée pour bloquer les attaques magiques.     ║       3               ║       0               ║       Verbal, Gestuel ║       2                       ║       8               ║             Magie de l'énergie        ║+
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║            Portail Astral     ║                                           Ouvre un portail vers des dimensions inconnues.     ║       3               ║       0               ║         Verbal, Focus ║       4                       ║       20              ║           Magie dimensionnelle        ║+
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║           Vision Nocturne     ║                                             Peut voir clairement dans l'obscurité totale.     ║       2               ║       0               ║                Mental ║       0                       ║       5               ║             Magie des ténèbres        ║+
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║         Évasion Gracieuse     ║                    Évite les attaques avec une grâce naturelle et une agilité surhumaine.     ║       3               ║       0               ║              Physique ║       0                       ║       1               ║                        Esquive        ║+
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║          Volée de Flèches     ║                                               Lance une volée de flèches sur les ennemis.     ║       2               ║       80              ║              Physique ║       1                       ║       15              ║          Lancer de projectiles        ║+
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║               Fouet Agile     ║           Utilise un fouet avec une grande agilité pour attaquer et désarmer les ennemis.     ║       2               ║       50              ║              Physique ║       0                       ║       3               ║       Attaque au corps à corps        ║+
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║                Tir Précis     ║               Fait des tirs précis avec une grande précision, touchant toujours la cible.     ║       2               ║       60              ║              Physique ║       1                       ║       8               ║          Lancer de projectiles        ║+
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║       Maîtrise des Cordes     ║       Utilise des cordes pour grimper, se déplacer rapidement et immobiliser les ennemis.     ║       3               ║       0               ║              Physique ║       0                       ║       1               ║             Magie de l'énergie        ║+
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║            Coup Assommant     ║                              Frappe la tête de l'ennemi pour les assommer temporairement.     ║       2               ║       60              ║              Physique ║       0                       ║       1               ║       Attaque au corps à corps        ║+
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ║            Sprint Furieux     ║               Sprinte à une vitesse surhumaine pour atteindre rapidement une destination.     ║       2               ║       0               ║              Physique ║       0                       ║       10              ║                         Course        ║+
	-- ║                               ║                                                                                               ║                       ║                       ║                       ║                               ║                       ║                                       ║+
	-- ╚═══.·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:·..·:.·:·.═══╝
	--(1 ligne)