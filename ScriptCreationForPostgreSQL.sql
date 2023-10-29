-- TYPEMONSTRE
   -- Création de la séquence
   CREATE SEQUENCE TYPEMONSTRE_seq
     START 1
     INCREMENT 1
     NO MAXVALUE
     CACHE 2;

   -- TABLE TYPEMONSTRE
   CREATE TABLE TYPEMONSTRE (
     Id serial PRIMARY KEY,
     Nom VARCHAR(255) NOT NULL,
     Description TEXT
   );

   -- Création de la fonction de déclenchement (trigger) pour générer la valeur Id
   CREATE OR REPLACE FUNCTION New_TypeMonstre_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     NEW.Id = nextval('TYPEMONSTRE_seq');
     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   -- Création du déclenchement (trigger) avant l'insertion dans TYPEMONSTRE
   CREATE TRIGGER new_type_monstre_trigger
   BEFORE INSERT ON TYPEMONSTRE
   FOR EACH ROW
   EXECUTE FUNCTION New_TypeMonstre_trigger();

-- ECOLEMAGIE
   CREATE TABLE ECOLEMAGIE(
      Nom VARCHAR(255) PRIMARY KEY,
      Description TEXT
   );

-- CLASSE
   CREATE TABLE CLASSE(
      Nom VARCHAR(255) PRIMARY KEY,
      Description TEXT,
      PointDeVie_Base INT DEFAULT 1000
   );

-- RACE
   CREATE TABLE RACE(
      Nom VARCHAR(255) PRIMARY KEY,
      Description TEXT,
      Vitesse INT DEFAULT 15,
      TailleMin INT DEFAULT 90,
      TailleMax INT DEFAULT 250
   );

-- FACTION
   -- Création de la séquence
   CREATE SEQUENCE FACTION_seq
     START WITH 1
     INCREMENT BY 1
     NO MAXVALUE
     CACHE 2;

   CREATE TABLE FACTION(
     Id INT PRIMARY KEY,
     Nom VARCHAR(255) NOT NULL,
     Description TEXT
   );

   -- Création du trigger BEFORE INSERT pour FACTION
   CREATE OR REPLACE FUNCTION New_Faction_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     NEW.Id := NEXTVAL('FACTION_seq');
     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER new_faction
   BEFORE INSERT ON FACTION
   FOR EACH ROW
   EXECUTE FUNCTION New_Faction_trigger();

-- HAUTFAIT
   -- Création de la séquence
   CREATE SEQUENCE HAUTFAIT_seq
     START WITH 1
     INCREMENT BY 1
     NO MAXVALUE
     CACHE 2;

   CREATE TABLE HAUTFAIT(
     Id INT PRIMARY KEY,
     Nom VARCHAR(255) NOT NULL,
     Description TEXT,
     PointHF INT DEFAULT 0
   );

   -- Création du trigger BEFORE INSERT pour HAUTFAIT
   CREATE OR REPLACE FUNCTION New_HautFait_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     NEW.Id := NEXTVAL('HAUTFAIT_seq');
     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER new_hautfait
   BEFORE INSERT ON HAUTFAIT
   FOR EACH ROW
   EXECUTE FUNCTION New_HautFait_trigger();

-- TITRE
   -- Création de la séquence
   CREATE SEQUENCE TITRE_seq
     START WITH 1
     INCREMENT BY 1
     NO MAXVALUE
     CACHE 2;

   CREATE TABLE TITRE(
     Id INT PRIMARY KEY,
     Nom VARCHAR(255) NOT NULL,
     Description VARCHAR(255),
     MethodeObtention VARCHAR(255)
   );

   -- Création du trigger BEFORE INSERT pour TITRE
   CREATE OR REPLACE FUNCTION New_Titre_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     NEW.Id := NEXTVAL('TITRE_seq');
     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER new_titre
   BEFORE INSERT ON TITRE
   FOR EACH ROW
   EXECUTE FUNCTION New_Titre_trigger();

-- LANGUE
   -- Création de la séquence
   CREATE SEQUENCE LANGUE_seq
     START WITH 1
     INCREMENT BY 1
     NO MAXVALUE
     CACHE 2;

   CREATE TABLE LANGUE(
     Id INT PRIMARY KEY,
     Nom VARCHAR(255) NOT NULL,
     Description TEXT
   );

   -- Création du trigger BEFORE INSERT pour LANGUE
   CREATE OR REPLACE FUNCTION New_Langue_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     NEW.Id := NEXTVAL('LANGUE_seq');
     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER new_langue
   BEFORE INSERT ON LANGUE
   FOR EACH ROW
   EXECUTE FUNCTION New_Langue_trigger();

-- TYPERESSOURCE
   -- Création de la séquence
   CREATE SEQUENCE TYPERESSOURCE_seq
     START WITH 1
     INCREMENT BY 1
     NO MAXVALUE
     CACHE 2;

   CREATE TABLE TYPERESSOURCE (
     Id INT PRIMARY KEY,
     Nom VARCHAR(255) NOT NULL,
     Description TEXT
   );

   -- Création du trigger BEFORE INSERT pour TYPERESSOURCE
   CREATE OR REPLACE FUNCTION New_Typeressource_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     NEW.Id := NEXTVAL('TYPERESSOURCE_seq');
     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER new_typeressource
   BEFORE INSERT ON TYPERESSOURCE
   FOR EACH ROW
   EXECUTE FUNCTION New_Typeressource_trigger();

-- TYPECONSOMMABLE
   -- Création de la séquence
   CREATE SEQUENCE TYPECONSOMMABLE_seq
     START WITH 1
     INCREMENT BY 1
     NO MAXVALUE
     CACHE 2;

   CREATE TABLE TYPECONSOMMABLE (
     Id INT PRIMARY KEY,
     Nom VARCHAR(255) NOT NULL,
     Description TEXT
   );

   -- Création du trigger BEFORE INSERT pour TYPECONSOMMABLE
   CREATE OR REPLACE FUNCTION New_Typeconsommable_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     NEW.Id := NEXTVAL('TYPECONSOMMABLE_seq');
     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER new_typeconsommable
   BEFORE INSERT ON TYPECONSOMMABLE
   FOR EACH ROW
   EXECUTE FUNCTION New_Typeconsommable_trigger();

-- ITEM
    CREATE SEQUENCE ITEM_seq
        START WITH 1
        INCREMENT BY 1
        NO MAXVALUE
        CACHE 2;

    CREATE TABLE ITEM(
        Id INT PRIMARY KEY,
        Nom VARCHAR(255) NOT NULL,
        Description TEXT
    );

    -- Création du trigger BEFORE INSERT pour ITEM
    CREATE OR REPLACE FUNCTION New_Item_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Utilisation de la séquence pour générer la valeur Id
        NEW.Id := NEXTVAL('ITEM_seq');
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER new_Item
    BEFORE INSERT ON ITEM
    FOR EACH ROW
    EXECUTE FUNCTION New_Item_trigger();

-- ARMURE (Hérite de ITEM)
    CREATE TABLE ARMURE(
        PointDeVieBase INT DEFAULT 100,
        ArmureBase INT DEFAULT 100,
        Id INT PRIMARY KEY,
        CONSTRAINT fk_armure_item FOREIGN KEY (Id) REFERENCES ITEM (Id)
    );

    
    -- VUE
    CREATE OR REPLACE VIEW V_ARMURE AS
        SELECT I.Id, I.Nom, I.Description, A.PointDeVieBase, A.ArmureBase
        FROM ITEM I
        JOIN ARMURE A ON I.Id = A.Id;


    -- trigger INSTEAD OF INSERT
    CREATE OR REPLACE FUNCTION New_Armure_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Nouvel item
        INSERT INTO ITEM(Nom, Description)
        VALUES (NEW.Nom, NEW.Description)
        RETURNING Id INTO NEW.Id;

        -- Nouvelle armure
        INSERT INTO ARMURE(Id, PointDeVieBase, ArmureBase)
        VALUES (NEW.Id, NEW.PointDeVieBase, NEW.ArmureBase);

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER New_Armure_trigger
    INSTEAD OF INSERT ON V_ARMURE
    FOR EACH ROW
    EXECUTE FUNCTION New_Armure_trigger();


    -- trigger INSTEAD OF UPDATE
    CREATE OR REPLACE FUNCTION Update_Armure_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Mise à jour de l'item
        UPDATE ITEM
        SET Nom = NEW.Nom,
            Description = NEW.Description
        WHERE Id = NEW.Id;

        -- Mise à jour de l'armure
        UPDATE ARMURE
        SET PointDeVieBase = NEW.PointDeVieBase,
            ArmureBase = NEW.ArmureBase
        WHERE Id = NEW.Id;

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Update_Armure_trigger
    INSTEAD OF UPDATE ON V_ARMURE
    FOR EACH ROW
    EXECUTE FUNCTION Update_Armure_trigger();


    -- trigger INSTEAD OF DELETE
    CREATE OR REPLACE FUNCTION Delete_Armure_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Suppression de l'armure
        DELETE FROM ARMURE
        WHERE Id = OLD.Id;

        -- Suppression de l'item
        DELETE FROM ITEM
        WHERE Id = OLD.Id;

        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Delete_Armure_trigger
    INSTEAD OF DELETE ON V_ARMURE
    FOR EACH ROW
    EXECUTE FUNCTION Delete_Armure_trigger();

-- ARME (Hérite de ITEM)
    CREATE TABLE ARME(
        DegatsBase INT DEFAULT 100,
        Id INT PRIMARY KEY,
        CONSTRAINT fk_arme_item FOREIGN KEY (Id) REFERENCES ITEM (Id)
    );


    -- VUE
    CREATE OR REPLACE VIEW V_ARME AS
        SELECT I.Id, I.Nom, I.Description, A.DegatsBase
        FROM ITEM I
        JOIN ARME A ON I.Id = A.Id;


    -- trigger INSTEAD OF INSERT
    CREATE OR REPLACE FUNCTION New_Arme_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Nouvel item
        INSERT INTO ITEM(Nom, Description)
        VALUES (NEW.Nom, NEW.Description)
        RETURNING Id INTO NEW.Id;

        -- Nouvelle arme
        INSERT INTO ARME(Id, DegatsBase)
        VALUES (NEW.Id, NEW.DegatsBase);

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER New_Arme_trigger
    INSTEAD OF INSERT ON V_ARME
    FOR EACH ROW
    EXECUTE FUNCTION New_Arme_trigger();


    -- trigger INSTEAD OF UPDATE
    CREATE OR REPLACE FUNCTION Update_Arme_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Mise à jour de l'item
        UPDATE ITEM
        SET Nom = NEW.Nom,
            Description = NEW.Description
        WHERE Id = NEW.Id;

        -- Mise à jour de l'arme
        UPDATE ARME
        SET DegatsBase = NEW.DegatsBase
        WHERE Id = NEW.Id;

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Update_Arme_trigger
    INSTEAD OF UPDATE ON V_ARME
    FOR EACH ROW
    EXECUTE FUNCTION Update_Arme_trigger();


    -- trigger INSTEAD OF DELETE
    CREATE OR REPLACE FUNCTION Delete_Arme_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Suppression de l'arme
        DELETE FROM ARME
        WHERE Id = OLD.Id;

        -- Suppression de l'item
        DELETE FROM ITEM
        WHERE Id = OLD.Id;

        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Delete_Arme_trigger
    INSTEAD OF DELETE ON V_ARME
    FOR EACH ROW
    EXECUTE FUNCTION Delete_Arme_trigger();

-- ITEMQUETE (Hérite de ITEM)
    CREATE TABLE ITEMQUETE(
        Id INT PRIMARY KEY,
        CONSTRAINT fk_itemquete_item FOREIGN KEY (Id) REFERENCES ITEM (Id)
    );


    -- VUE
    CREATE OR REPLACE VIEW V_ITEMQUETE AS
        SELECT I.Id, I.Nom, I.Description
        FROM ITEM I
        JOIN ITEMQUETE IQ ON I.Id = IQ.Id;


    -- trigger INSTEAD OF INSERT
    CREATE OR REPLACE FUNCTION New_Itemquete_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Nouvel item
        INSERT INTO ITEM(Nom, Description)
        VALUES (NEW.Nom, NEW.Description)
        RETURNING Id INTO NEW.Id;

        -- Nouvelle itemquete
        INSERT INTO ITEMQUETE(Id)
        VALUES (NEW.Id);

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER New_Itemquete_trigger
    INSTEAD OF INSERT ON V_ITEMQUETE
    FOR EACH ROW
    EXECUTE FUNCTION New_Itemquete_trigger();


    -- trigger INSTEAD OF UPDATE
    CREATE OR REPLACE FUNCTION Update_Itemquete_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Mise à jour de l'item
        UPDATE ITEM
        SET Nom = NEW.Nom,
            Description = NEW.Description
        WHERE Id = NEW.Id;

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Update_Itemquete_trigger
    INSTEAD OF UPDATE ON V_ITEMQUETE
    FOR EACH ROW
    EXECUTE FUNCTION Update_Itemquete_trigger();


    -- trigger INSTEAD OF DELETE
    CREATE OR REPLACE FUNCTION Delete_Itemquete_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Suppression de l'itemquete
        DELETE FROM ITEMQUETE
        WHERE Id = OLD.Id;

        -- Suppression de l'item
        DELETE FROM ITEM
        WHERE Id = OLD.Id;

        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Delete_Itemquete_trigger
    INSTEAD OF DELETE ON V_ITEMQUETE
    FOR EACH ROW
    EXECUTE FUNCTION Delete_Itemquete_trigger();

-- OUTIL (Hérite de ITEM)
    CREATE TABLE OUTIL(
        Id INT PRIMARY KEY,
        CONSTRAINT fk_outil_item FOREIGN KEY (Id) REFERENCES ITEM (Id)
    );


    -- VUE
    CREATE OR REPLACE VIEW V_OUTIL AS
        SELECT I.Id, I.Nom, I.Description
        FROM ITEM I
        JOIN OUTIL O ON I.Id = O.Id;


    -- trigger INSTEAD OF INSERT
    CREATE OR REPLACE FUNCTION New_Outil_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Nouvel item
        INSERT INTO ITEM(Nom, Description)
        VALUES (NEW.Nom, NEW.Description)
        RETURNING Id INTO NEW.Id;

        -- Nouvelle outil
        INSERT INTO OUTIL(Id)
        VALUES (NEW.Id);

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER New_Outil_trigger
    INSTEAD OF INSERT ON V_OUTIL
    FOR EACH ROW
    EXECUTE FUNCTION New_Outil_trigger();


    -- trigger INSTEAD OF UPDATE
    CREATE OR REPLACE FUNCTION Update_Outil_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Mise à jour de l'item
        UPDATE ITEM
        SET Nom = NEW.Nom,
            Description = NEW.Description
        WHERE Id = NEW.Id;

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Update_Outil_trigger
    INSTEAD OF UPDATE ON V_OUTIL
    FOR EACH ROW
    EXECUTE FUNCTION Update_Outil_trigger();


    -- trigger INSTEAD OF DELETE
    CREATE OR REPLACE FUNCTION Delete_Outil_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Suppression de l'outil
        DELETE FROM OUTIL
        WHERE Id = OLD.Id;

        -- Suppression de l'item
        DELETE FROM ITEM
        WHERE Id = OLD.Id;

        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Delete_Outil_trigger
    INSTEAD OF DELETE ON V_OUTIL
    FOR EACH ROW
    EXECUTE FUNCTION Delete_Outil_trigger();

-- DIVERS (Hérite de ITEM)
    CREATE TABLE DIVERS(
        Id INT PRIMARY KEY,
        CONSTRAINT fk_divers_item FOREIGN KEY (Id) REFERENCES ITEM (Id)
    );


    -- VUE
    CREATE OR REPLACE VIEW V_DIVERS AS
        SELECT I.Id, I.Nom, I.Description
        FROM ITEM I
        JOIN DIVERS D ON I.Id = D.Id;


    -- trigger INSTEAD OF INSERT
    CREATE OR REPLACE FUNCTION New_Divers_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Nouvel item
        INSERT INTO ITEM(Nom, Description)
        VALUES (NEW.Nom, NEW.Description)
        RETURNING Id INTO NEW.Id;

        -- Nouveau divers
        INSERT INTO DIVERS(Id)
        VALUES (NEW.Id);

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER New_Divers_trigger
    INSTEAD OF INSERT ON V_DIVERS
    FOR EACH ROW
    EXECUTE FUNCTION New_Divers_trigger();


    -- trigger INSTEAD OF UPDATE
    CREATE OR REPLACE FUNCTION Update_Divers_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Mise à jour de l'item
        UPDATE ITEM
        SET Nom = NEW.Nom,
            Description = NEW.Description
        WHERE Id = NEW.Id;

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Update_Divers_trigger
    INSTEAD OF UPDATE ON V_DIVERS
    FOR EACH ROW
    EXECUTE FUNCTION Update_Divers_trigger();


    -- trigger INSTEAD OF DELETE
    CREATE OR REPLACE FUNCTION Delete_Divers_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Suppression du divers
        DELETE FROM DIVERS
        WHERE Id = OLD.Id;

        -- Suppression de l'item
        DELETE FROM ITEM
        WHERE Id = OLD.Id;

        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Delete_Divers_trigger
    INSTEAD OF DELETE ON V_DIVERS
    FOR EACH ROW
    EXECUTE FUNCTION Delete_Divers_trigger();

-- CONSOMMABLE (Hérite de DIVERS)
    CREATE TABLE CONSOMMABLE(
        Effet VARCHAR(255),
        Id_Typeconsommable INT,
        Id INT PRIMARY KEY,
        CONSTRAINT fk_consommable_divers FOREIGN KEY (Id) REFERENCES DIVERS (Id),
        CONSTRAINT fk_consommable_typecons FOREIGN KEY (Id_Typeconsommable) REFERENCES TYPECONSOMMABLE (Id)
    );


    -- VUE
    CREATE OR REPLACE VIEW V_CONSOMMABLE AS
        SELECT I.Id, I.Nom, I.Description, C.Effet, C.Id_Typeconsommable
        FROM V_DIVERS I
        JOIN CONSOMMABLE C ON I.Id = C.Id;


    -- trigger INSTEAD OF INSERT
    CREATE OR REPLACE FUNCTION New_Consommable_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Nouvel Divers
        INSERT INTO V_DIVERS(Nom, Description)
        VALUES (NEW.Nom, NEW.Description)
        RETURNING Id INTO NEW.Id;

        -- Nouvelle Consommable
        INSERT INTO CONSOMMABLE(Id, Effet, Id_Typeconsommable)
        VALUES (NEW.Id, NEW.Effet, NEW.Id_Typeconsommable);

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER New_Consommable_trigger
    INSTEAD OF INSERT ON V_CONSOMMABLE
    FOR EACH ROW
    EXECUTE FUNCTION New_Consommable_trigger();


    -- trigger INSTEAD OF UPDATE
    CREATE OR REPLACE FUNCTION Update_Consommable_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Mise à jour du divers
        UPDATE V_DIVERS
        SET Nom = NEW.Nom,
            Description = NEW.Description
        WHERE Id = NEW.Id;

        -- Mise à jour du consommable
        UPDATE CONSOMMABLE
        SET Effet = NEW.Effet,
            Id_Typeconsommable = NEW.Id_Typeconsommable
        WHERE Id = NEW.Id;

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Update_Consommable_trigger
    INSTEAD OF UPDATE ON V_CONSOMMABLE
    FOR EACH ROW
    EXECUTE FUNCTION Update_Consommable_trigger();


    -- trigger INSTEAD OF DELETE
    CREATE OR REPLACE FUNCTION Delete_Consommable_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Suppression du consommable
        DELETE FROM CONSOMMABLE
        WHERE Id = OLD.Id;

        -- Suppression du divers
        DELETE FROM V_DIVERS
        WHERE Id = OLD.Id;

        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Delete_Consommable_trigger
    INSTEAD OF DELETE ON V_CONSOMMABLE
    FOR EACH ROW
    EXECUTE FUNCTION Delete_Consommable_trigger();

-- RESSOURCE (Hérite de DIVERS)
    CREATE TABLE RESSOURCE(
        Id_Typeressource INT,
        Id INT PRIMARY KEY,
        CONSTRAINT fk_ressource_divers FOREIGN KEY (Id) REFERENCES DIVERS (Id),
        CONSTRAINT fk_ressource_typeres FOREIGN KEY (Id_Typeressource) REFERENCES TYPERESSOURCE (Id)
    );


    --VUE
    CREATE OR REPLACE VIEW V_RESSOURCE AS
        SELECT I.Id, I.Nom, I.Description, R.Id_Typeressource
        FROM V_DIVERS I
        JOIN RESSOURCE R ON I.Id = R.Id;


    -- trigger INSTEAD OF INSERT
    CREATE OR REPLACE FUNCTION New_Ressource_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Nouvel Divers
        INSERT INTO V_DIVERS(Nom, Description)
        VALUES (NEW.Nom, NEW.Description)
        RETURNING Id INTO NEW.Id;

        -- Nouvelle Ressource
        INSERT INTO RESSOURCE(Id, Id_Typeressource)
        VALUES (NEW.Id, NEW.Id_Typeressource);

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER New_Ressource_trigger
    INSTEAD OF INSERT ON V_RESSOURCE
    FOR EACH ROW
    EXECUTE FUNCTION New_Ressource_trigger();


    -- trigger INSTEAD OF UPDATE
    CREATE OR REPLACE FUNCTION Update_Ressource_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Mise à jour du divers
        UPDATE V_DIVERS
        SET Nom = NEW.Nom,
            Description = NEW.Description
        WHERE Id = NEW.Id;

        -- Mise à jour de la ressource
        UPDATE RESSOURCE
        SET Id_Typeressource = NEW.Id_Typeressource
        WHERE Id = NEW.Id;

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Update_Ressource_trigger
    INSTEAD OF UPDATE ON V_RESSOURCE
    FOR EACH ROW
    EXECUTE FUNCTION Update_Ressource_trigger();


    -- trigger INSTEAD OF DELETE
    CREATE OR REPLACE FUNCTION Delete_Ressource_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Suppression de la ressource
        DELETE FROM RESSOURCE
        WHERE Id = OLD.Id;

        -- Suppression du divers
        DELETE FROM V_DIVERS
        WHERE Id = OLD.Id;

        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Delete_Ressource_trigger
    INSTEAD OF DELETE ON V_RESSOURCE
    FOR EACH ROW
    EXECUTE FUNCTION Delete_Ressource_trigger();

-- TYPEARMURE
   -- Création de la séquence
   CREATE SEQUENCE TYPEARMURE_seq
       START 1
       INCREMENT 1
       NO MAXVALUE
       CACHE 2;

   -- Création de la table TYPEARMURE
   CREATE TABLE TYPEARMURE (
       Id SERIAL PRIMARY KEY, -- Utilisation du type SERIAL pour générer automatiquement les valeurs de la clé primaire
       Nom VARCHAR(255) NOT NULL,
       Description TEXT
   );

   -- Création du trigger INSTEAD OF INSERT pour TYPEARMURE
   CREATE OR REPLACE FUNCTION New_Typearmure_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
       -- Utilisation de la séquence pour générer la valeur Id
       NEW.Id = nextval('TYPEARMURE_seq');
       RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   -- Lier le trigger au déclencheur BEFORE INSERT sur la table TYPEARMURE
   CREATE TRIGGER New_Typearmure_trigger
   BEFORE INSERT ON TYPEARMURE
   FOR EACH ROW
   EXECUTE FUNCTION New_Typearmure_trigger();

-- TYPEARME
   -- Création de la séquence
   CREATE SEQUENCE TYPEARME_seq
       START 1
       INCREMENT 1
       NO MAXVALUE
       CACHE 2;

   -- Création de la table TYPEARME
   CREATE TABLE TYPEARME (
       Id SERIAL PRIMARY KEY, -- Utilisation du type SERIAL pour générer automatiquement les valeurs de la clé primaire
       Nom VARCHAR(255) NOT NULL,
       Description TEXT
   );

   -- Création du trigger INSTEAD OF INSERT pour TYPEARME
   CREATE OR REPLACE FUNCTION New_Typearme_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
       -- Utilisation de la séquence pour générer la valeur Id
       NEW.Id = nextval('TYPEARME_seq');
       RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   -- Lier le trigger au déclencheur BEFORE INSERT sur la table TYPEARME
   CREATE TRIGGER New_Typearme_trigger
   BEFORE INSERT ON TYPEARME
   FOR EACH ROW
   EXECUTE FUNCTION New_Typearme_trigger();

-- METIER
   -- Création de la séquence
   CREATE SEQUENCE METIER_seq
       START 1
       INCREMENT 1
       NO MAXVALUE
       CACHE 2;

   -- Création de la table METIER
   CREATE TABLE METIER (
       Id SERIAL PRIMARY KEY, -- Utilisation du type SERIAL pour générer automatiquement les valeurs de la clé primaire
       Nom VARCHAR(255) NOT NULL,
       Description TEXT
   );

   -- Création de la règle INSTEAD OF INSERT pour METIER
   CREATE OR REPLACE FUNCTION New_Metier_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
       -- Utilisation de la séquence pour générer la valeur Id
       NEW.Id = nextval('METIER_seq');
       RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   -- Lier la règle au déclencheur BEFORE INSERT sur la table METIER
   CREATE TRIGGER New_Metier_trigger
   BEFORE INSERT ON METIER
   FOR EACH ROW
   EXECUTE FUNCTION New_Metier_trigger();

-- RECETTE
   -- Création de la séquence
   CREATE SEQUENCE RECETTE_seq
       START 1
       INCREMENT 1
       NO MAXVALUE
       CACHE 2;

   -- Création de la table RECETTE
   CREATE TABLE RECETTE (
       Id SERIAL PRIMARY KEY, -- Utilisation du type SERIAL pour générer automatiquement les valeurs de la clé primaire
       Nom VARCHAR(255) NOT NULL,
       Description TEXT,
       IdItem INT,
       CONSTRAINT fk_recette_item FOREIGN KEY (IdItem) REFERENCES ITEM(Id)
   );

   -- Création de la règle INSTEAD OF INSERT pour RECETTE
   CREATE OR REPLACE FUNCTION New_Recette_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
       -- Utilisation de la séquence pour générer la valeur Id
       NEW.Id = nextval('RECETTE_seq');
       RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   -- Lier la règle au déclencheur BEFORE INSERT sur la table RECETTE
   CREATE TRIGGER New_Recette_trigger
   BEFORE INSERT ON RECETTE
   FOR EACH ROW
   EXECUTE FUNCTION New_Recette_trigger();

-- TYPELIEUX
   -- Création de la séquence
   CREATE SEQUENCE TYPELIEUX_seq
       START 1
       INCREMENT 1
       NO MAXVALUE
       CACHE 2;

   -- Création de la table TYPELIEUX
   CREATE TABLE TYPELIEUX (
       Id SERIAL PRIMARY KEY, -- Utilisation du type SERIAL pour générer automatiquement les valeurs de la clé primaire
       Nom VARCHAR(255) NOT NULL,
       Description TEXT
   );

   -- Création de la règle INSTEAD OF INSERT pour TYPELIEUX
   CREATE OR REPLACE FUNCTION New_Typelieux_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
       -- Utilisation de la séquence pour générer la valeur Id
       NEW.Id = nextval('TYPELIEUX_seq');
       RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   -- Lier la règle au déclencheur BEFORE INSERT sur la table TYPELIEUX
   CREATE TRIGGER New_Typelieux_trigger
   BEFORE INSERT ON TYPELIEUX
   FOR EACH ROW
   EXECUTE FUNCTION New_Typelieux_trigger();

-- LIEUX
   -- Création de la séquence
   CREATE SEQUENCE LIEUX_seq
       START 1
       INCREMENT 1
       NO MAXVALUE
       CACHE 2;

   -- Création de la table LIEUX
   CREATE TABLE LIEUX (
       Id SERIAL PRIMARY KEY, -- Utilisation du type SERIAL pour générer automatiquement les valeurs de la clé primaire
       Nom VARCHAR(255) NOT NULL,
       Description TEXT,
       Id_TypeLieux INT,
       CONSTRAINT fk_typelieux_lieux FOREIGN KEY (Id_TypeLieux) REFERENCES TYPELIEUX(Id)
   );

   -- Création de la règle INSTEAD OF INSERT pour LIEUX
   CREATE OR REPLACE FUNCTION New_Lieux_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
       -- Utilisation de la séquence pour générer la valeur Id
       NEW.Id = nextval('LIEUX_seq');
       RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   -- Lier la règle au déclencheur BEFORE INSERT sur la table LIEUX
   CREATE TRIGGER New_Lieux_trigger
   BEFORE INSERT ON LIEUX
   FOR EACH ROW
   EXECUTE FUNCTION New_Lieux_trigger();

-- TYPEQUETE
   -- Création de la séquence
   CREATE SEQUENCE TYPEQUETE_seq
       START 1
       INCREMENT 1
       NO MAXVALUE
       CACHE 2;

   -- Création de la table TYPEQUETE
   CREATE TABLE TYPEQUETE (
       Id SERIAL PRIMARY KEY, -- Utilisation du type SERIAL pour générer automatiquement les valeurs de la clé primaire
       Description TEXT
   );

   -- Création de la règle INSTEAD OF INSERT pour TYPEQUETE
   CREATE OR REPLACE FUNCTION New_Typequete_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
       -- Utilisation de la séquence pour générer la valeur Id
       NEW.Id = nextval('TYPEQUETE_seq');
       RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   -- Lier la règle au déclencheur BEFORE INSERT sur la table TYPEQUETE
   CREATE TRIGGER New_Typequete_trigger
   BEFORE INSERT ON TYPEQUETE
   FOR EACH ROW
   EXECUTE FUNCTION New_Typequete_trigger();

-- QUETE
   -- Création de la séquence
   CREATE SEQUENCE QUETE_seq
       START 1
       INCREMENT 1
       NO MAXVALUE
       CACHE 2;

   -- Création de la table QUETE
   CREATE TABLE QUETE (
       Id SERIAL PRIMARY KEY, -- Utilisation du type SERIAL pour générer automatiquement les valeurs de la clé primaire
       Titre VARCHAR(255) NOT NULL,
       Description TEXT,
       NiveauRecommande INT DEFAULT 1,
       Statut VARCHAR(255) DEFAULT 'En cours',
       DateDebut TIMESTAMP DEFAULT current_timestamp,
       DateFin TIMESTAMP,
       Id_Typequete INT,
       CONSTRAINT fk_typequete_quete FOREIGN KEY (Id_Typequete) REFERENCES TYPEQUETE(Id)
   );

   -- Création de la règle INSTEAD OF INSERT pour QUETE
   CREATE OR REPLACE FUNCTION New_Quete_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
       -- Utilisation de la séquence pour générer la valeur Id
       NEW.Id = nextval('QUETE_seq');
       RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   -- Lier la règle au déclencheur BEFORE INSERT sur la table QUETE
   CREATE TRIGGER New_Quete_trigger
   BEFORE INSERT ON QUETE
   FOR EACH ROW
   EXECUTE FUNCTION New_Quete_trigger();

-- EVENEMENT
   -- Création de la séquence
   CREATE SEQUENCE EVENEMENT_seq
        START 1
        INCREMENT 1
        NO MAXVALUE
        CACHE 2;

   -- Création de la table EVENEMENT
   CREATE TABLE EVENEMENT(
         Id SERIAL PRIMARY KEY,
         Nom VARCHAR(255) NOT NULL,
         Description TEXT,
         Duree INT DEFAULT 1
      );

   -- Création de la fonction et du déclencheur (trigger) pour gérer l'incrémentation de l'ID
   CREATE OR REPLACE FUNCTION New_Evenement_function()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     NEW.Id = nextval('EVENEMENT_seq');
     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER New_Evenement_trigger
   BEFORE INSERT ON EVENEMENT
   FOR EACH ROW
   EXECUTE FUNCTION New_Evenement_function();

-- APPARENCE
   -- Création de la séquence
   CREATE SEQUENCE APPARENCE_seq
        START 1
        INCREMENT 1
        NO MAXVALUE
        CACHE 2;

   -- Création de la table APPARENCE
   CREATE TABLE APPARENCE(
         Id SERIAL PRIMARY KEY,
         Nom VARCHAR(255) NOT NULL,
         Description TEXT,
         Image VARCHAR(255)
      );

   -- Création de la fonction et du déclencheur (trigger) pour gérer l'incrémentation de l'ID
   CREATE OR REPLACE FUNCTION New_Apparence_function()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     NEW.Id = nextval('APPARENCE_seq');
     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER New_Apparence_trigger
   BEFORE INSERT ON APPARENCE
   FOR EACH ROW
   EXECUTE FUNCTION New_Apparence_function();

-- CLASSE_RACE
   CREATE TABLE CLASSE_RACE(
      Nom_Classe VARCHAR(255),
      Nom_Race VARCHAR(255),
      PRIMARY KEY(Nom_Classe, Nom_Race),
      FOREIGN KEY(Nom_Classe) REFERENCES CLASSE(Nom),
      FOREIGN KEY(Nom_Race) REFERENCES RACE(Nom)
   );

-- PERSONNAGE
    -- Création de la séquence
    CREATE SEQUENCE PERSONNAGE_seq
        START 1
        INCREMENT 1
        NO MAXVALUE
        CACHE 2;

    -- Création de la table PERSONNAGE
    CREATE TABLE PERSONNAGE (
        Id SERIAL PRIMARY KEY,
        Nom VARCHAR(255) NOT NULL,
        Taille INT DEFAULT 180,
        Alignement VARCHAR(255),
        Description TEXT,
        DateCreation TIMESTAMP DEFAULT current_timestamp,
        Nom_Classe VARCHAR(255) NOT NULL,
        Nom_Race VARCHAR(255) NOT NULL,
        Id_Lieux INT NOT NULL,
        CONSTRAINT fk_classe_personnage FOREIGN KEY (Nom_Classe) REFERENCES CLASSE(Nom),
        CONSTRAINT fk_race_personnage FOREIGN KEY (Nom_Race) REFERENCES RACE(Nom),
        CONSTRAINT fk_lieux_personnage FOREIGN KEY (Id_Lieux) REFERENCES LIEUX(Id),
        CONSTRAINT fk_calsserace_personnage FOREIGN KEY (Nom_Classe, Nom_Race) REFERENCES CLASSE_RACE (Nom_Classe, Nom_Race)
    );

    -- Création du trigger INSTEAD OF INSERT pour PERSONNAGE
    CREATE OR REPLACE FUNCTION New_Personnage_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Utilisation de la séquence pour générer la valeur Id
        NEW.Id := NEXTVAL('PERSONNAGE_seq');
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER New_Personnage_trigger
    BEFORE INSERT ON PERSONNAGE
    FOR EACH ROW
    EXECUTE FUNCTION New_Personnage_trigger();

-- PJ
    CREATE TABLE PJ (
        Id INT PRIMARY KEY,
        Niveau INT DEFAULT 1,
        PointDeVie INT DEFAULT 1000,
        PointDeMana INT DEFAULT 1000,
        Experience INT DEFAULT 0,
        Gold INT DEFAULT 10,
        CONSTRAINT fk_personnage_pj FOREIGN KEY (Id) REFERENCES PERSONNAGE(Id)
    );


    -- Création de la View pour PJ
    CREATE OR REPLACE VIEW V_PJ AS
        SELECT P.Id, P.Nom, P.Taille, P.Alignement, P.Description, P.DateCreation, P.Nom_Classe, P.Nom_Race, P.Id_Lieux, PJ.Niveau, PJ.PointDeVie, PJ.PointDeMana, PJ.Experience, PJ.Gold
        FROM PERSONNAGE P
        JOIN PJ ON P.Id = PJ.Id;

    -- Création du déclencheur INSTEAD OF INSERT pour V_PNJ
    CREATE OR REPLACE FUNCTION New_PJ_function()
    RETURNS TRIGGER AS $$
    DECLARE
        New_Id INT;
    BEGIN
        -- Nouveau PERSONNAGE
        INSERT INTO PERSONNAGE(Nom, Taille, Alignement, Description, DateCreation, Nom_Classe, Nom_Race, Id_Lieux)
        VALUES (NEW.Nom, NEW.Taille, NEW.Alignement, NEW.Description, NEW.DateCreation, NEW.Nom_Classe, NEW.Nom_Race, NEW.Id_Lieux)
        RETURNING Id INTO New_Id;

        -- Nouveau PJ
        INSERT INTO PJ(Id, Niveau, PointDeVie, PointDeMana, Experience, Gold)
        VALUES (New_Id, NEW.Niveau, NEW.PointDeVie, NEW.PointDeMana, NEW.Experience, NEW.Gold);

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER New_PJ_trigger
    INSTEAD OF INSERT ON V_PJ
    FOR EACH ROW
    EXECUTE FUNCTION New_PJ_function();


    -- Création du déclencheur INSTEAD OF UPDATE pour V_PJ
    CREATE OR REPLACE FUNCTION Update_PJ_function()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Mise à jour du personnage
        UPDATE PERSONNAGE
        SET Nom = NEW.Nom,
            Taille = NEW.Taille,
            Alignement = NEW.Alignement,
            Description = NEW.Description,
            DateCreation = NEW.DateCreation,
            Nom_Classe = NEW.Nom_Classe,
            Nom_Race = NEW.Nom_Race,
            Id_Lieux = NEW.Id_Lieux
        WHERE Id = NEW.Id;

        -- Mise à jour du PJ
        UPDATE PJ
        SET Niveau = NEW.Niveau,
            PointDeVie = NEW.PointDeVie,
            PointDeMana = NEW.PointDeMana,
            Experience = NEW.Experience,
            Gold = NEW.Gold
        WHERE Id = NEW.Id;

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Update_PJ_trigger
    INSTEAD OF UPDATE ON V_PJ
    FOR EACH ROW
    EXECUTE FUNCTION Update_PJ_function();


    -- Création du déclencheur INSTEAD OF DELETE pour V_PJ
    CREATE OR REPLACE FUNCTION Delete_PJ_function()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Suppression du PJ
        DELETE FROM PJ
        WHERE Id = OLD.Id;

        -- Suppression du personnage
        DELETE FROM PERSONNAGE
        WHERE Id = OLD.Id;

        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Delete_PJ_trigger
    INSTEAD OF DELETE ON V_PJ
    FOR EACH ROW
    EXECUTE FUNCTION Delete_PJ_function();

-- PNJ
    CREATE TABLE PNJ (
        Id SERIAL PRIMARY KEY,
        CONSTRAINT fk_personnage_pnj FOREIGN KEY (Id) REFERENCES PERSONNAGE(Id)
    );

    -- Création de la vue pour PNJ
    CREATE OR REPLACE VIEW V_PNJ AS
    SELECT P.Id, P.Nom, P.Taille, P.Alignement, P.Description, P.DateCreation, P.Nom_Classe, P.Nom_Race, P.Id_Lieux
    FROM PERSONNAGE P
    JOIN PNJ ON P.Id = PNJ.Id;


    -- Création du déclencheur INSTEAD OF INSERT pour V_PNJ
    CREATE OR REPLACE FUNCTION New_PNJ_function()
    RETURNS TRIGGER AS $$
    DECLARE
    BEGIN
        -- Nouveau PERSONNAGE
        INSERT INTO PERSONNAGE(Nom, Taille, Alignement, Description, DateCreation, Nom_Classe, Nom_Race, Id_Lieux)
        VALUES (NEW.Nom, NEW.Taille, NEW.Alignement, NEW.Description, NEW.DateCreation, NEW.Nom_Classe, NEW.Nom_Race, NEW.Id_Lieux)
        RETURNING Id INTO New.Id;

        -- Nouveau PNJ
        INSERT INTO PNJ(Id)
        VALUES (New.Id);

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER New_PNJ_trigger
    INSTEAD OF INSERT ON V_PNJ
    FOR EACH ROW
    EXECUTE FUNCTION New_PNJ_function();


    -- Création du déclencheur INSTEAD OF UPDATE pour V_PNJ
    CREATE OR REPLACE FUNCTION Update_PNJ_function()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Mise à jour du personnage
        UPDATE PERSONNAGE
        SET Nom = NEW.Nom,
            Taille = NEW.Taille,
            Alignement = NEW.Alignement,
            Description = NEW.Description,
            DateCreation = NEW.DateCreation,
            Nom_Classe = NEW.Nom_Classe,
            Nom_Race = NEW.Nom_Race,
            Id_Lieux = NEW.Id_Lieux
        WHERE Id = NEW.Id;

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Update_PNJ_trigger
    INSTEAD OF UPDATE ON V_PNJ
    FOR EACH ROW
    EXECUTE FUNCTION Update_PNJ_function();


    -- Création du déclencheur INSTEAD OF DELETE pour V_PNJ
    CREATE OR REPLACE FUNCTION Delete_PNJ_function()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Suppression du PNJ
        DELETE FROM PNJ
        WHERE Id = OLD.Id;

        -- Suppression du personnage
        DELETE FROM PERSONNAGE
        WHERE Id = OLD.Id;

        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Delete_PNJ_trigger
    INSTEAD OF DELETE ON V_PNJ
    FOR EACH ROW
    EXECUTE FUNCTION Delete_PNJ_function();

-- ALLIE
    CREATE TABLE ALLIE (
        Id SERIAL PRIMARY KEY,
        CONSTRAINT fk_personnage_allie FOREIGN KEY (Id) REFERENCES PNJ(Id)
    );


    -- Création de la vue pour ALLIE
    CREATE OR REPLACE VIEW V_ALLIE AS
    SELECT P.Id, P.Nom, P.Taille, P.Alignement, P.Description, P.DateCreation, P.Nom_Classe, P.Nom_Race, P.Id_Lieux
    FROM V_PNJ P
    JOIN ALLIE A ON P.Id = A.Id;


    -- Création du déclencheur INSTEAD OF INSERT pour V_ALLIE
    CREATE OR REPLACE FUNCTION New_Allie_function()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Nouveau PNJ
        INSERT INTO V_PNJ(Nom, Taille, Alignement, Description, DateCreation, Nom_Classe, Nom_Race, Id_Lieux)
        VALUES (NEW.Nom, NEW.Taille, NEW.Alignement, NEW.Description, NEW.DateCreation, NEW.Nom_Classe, NEW.Nom_Race, NEW.Id_Lieux)
        RETURNING Id INTO New.Id;

        -- Nouveau ALLIE
        INSERT INTO ALLIE(Id)
        VALUES (New.Id);

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER New_Allie_trigger
    INSTEAD OF INSERT ON V_ALLIE
    FOR EACH ROW
    EXECUTE FUNCTION New_Allie_function();


    -- Création du déclencheur INSTEAD OF UPDATE pour V_ALLIE
    CREATE OR REPLACE FUNCTION Update_Allie_function()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Mise à jour du personnage
        UPDATE V_PNJ
        SET Nom = NEW.Nom,
            Taille = NEW.Taille,
            Alignement = NEW.Alignement,
            Description = NEW.Description,
            DateCreation = NEW.DateCreation,
            Nom_Classe = NEW.Nom_Classe,
            Nom_Race = NEW.Nom_Race,
            Id_Lieux = NEW.Id_Lieux
        WHERE Id = NEW.Id;

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Update_Allie_trigger
    INSTEAD OF UPDATE ON V_ALLIE
    FOR EACH ROW
    EXECUTE FUNCTION Update_Allie_function();


    -- Création du déclencheur INSTEAD OF DELETE pour V_ALLIE
    CREATE OR REPLACE FUNCTION Delete_Allie_function()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Suppression de l'allie
        DELETE FROM ALLIE
        WHERE Id = OLD.Id;

        -- Suppression du PNJ
        DELETE FROM V_PNJ
        WHERE Id = OLD.Id;

        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Delete_Allie_trigger
    INSTEAD OF DELETE ON V_ALLIE
    FOR EACH ROW
    EXECUTE FUNCTION Delete_Allie_function();

-- MONSTRE
    CREATE TABLE MONSTRE (
        Id SERIAL PRIMARY KEY,
        Niveau INT DEFAULT 1,
        PointDeVie INT DEFAULT 1000,
        PointDeMana INT DEFAULT 1000,
        Experience INT DEFAULT 0,
        Gold INT DEFAULT 0,
        EstBoss BOOL DEFAULT FALSE,
        CONSTRAINT fk_personnage_monstre FOREIGN KEY (Id) REFERENCES PNJ(Id)
    );
    

    -- Création de la vue pour MONSTRE
    CREATE OR REPLACE VIEW V_MONSTRE AS
    SELECT P.Id, P.Nom, P.Taille, P.Alignement, P.Description, P.DateCreation, P.Nom_Classe, P.Nom_Race, P.Id_Lieux, M.Niveau, M.PointDeVie, M.PointDeMana, M.Experience, M.Gold, M.EstBoss
    FROM V_PNJ P
    JOIN MONSTRE M ON P.Id = M.Id;


    -- Création du déclencheur INSTEAD OF INSERT pour V_MONSTRE
    CREATE OR REPLACE FUNCTION New_Monstre_function()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Nouveau PNJ
        INSERT INTO V_PNJ(Nom, Taille, Alignement, Description, DateCreation, Nom_Classe, Nom_Race, Id_Lieux)
        VALUES (NEW.Nom, NEW.Taille, NEW.Alignement, NEW.Description, NEW.DateCreation, NEW.Nom_Classe, NEW.Nom_Race, NEW.Id_Lieux)
        RETURNING Id INTO New.Id;

        -- Nouveau MONSTRE
        INSERT INTO MONSTRE(Id, Niveau, PointDeVie, PointDeMana, Experience, Gold, EstBoss)
        VALUES (New.Id, NEW.Niveau, NEW.PointDeVie, NEW.PointDeMana, NEW.Experience, NEW.Gold, NEW.EstBoss);

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER New_Monstre_trigger
    INSTEAD OF INSERT ON V_MONSTRE
    FOR EACH ROW
    EXECUTE FUNCTION New_Monstre_function();


    -- Création du déclencheur INSTEAD OF UPDATE pour V_MONSTRE
    CREATE OR REPLACE FUNCTION Update_Monstre_function()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Mise à jour du personnage
        UPDATE V_PNJ
        SET Nom = NEW.Nom,
            Taille = NEW.Taille,
            Alignement = NEW.Alignement,
            Description = NEW.Description,
            DateCreation = NEW.DateCreation,
            Nom_Classe = NEW.Nom_Classe,
            Nom_Race = NEW.Nom_Race,
            Id_Lieux = NEW.Id_Lieux
        WHERE Id = NEW.Id;

        -- Mise à jour du monstre
        UPDATE MONSTRE
        SET Niveau = NEW.Niveau,
            PointDeVie = NEW.PointDeVie,
            PointDeMana = NEW.PointDeMana,
            Experience = NEW.Experience,
            Gold = NEW.Gold,
            EstBoss = NEW.EstBoss
        WHERE Id = NEW.Id;

        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Update_Monstre_trigger
    INSTEAD OF UPDATE ON V_MONSTRE
    FOR EACH ROW
    EXECUTE FUNCTION Update_Monstre_function();


    -- Création du déclencheur INSTEAD OF DELETE pour V_MONSTRE
    CREATE OR REPLACE FUNCTION Delete_Monstre_function()
    RETURNS TRIGGER AS $$
    BEGIN
        -- Suppression du Monstre
        DELETE FROM MONSTRE
        WHERE Id = OLD.Id;

        -- Suppression du PNJ
        DELETE FROM V_PNJ
        WHERE Id = OLD.Id;

        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER Delete_Monstre_trigger
    INSTEAD OF DELETE ON V_MONSTRE
    FOR EACH ROW
    EXECUTE FUNCTION Delete_Monstre_function();

-- SORT
   -- Création de la séquence
   CREATE SEQUENCE SORT_seq
     START WITH 1
     INCREMENT BY 1
     NO MAXVALUE
     CACHE 2;

   -- Création de la table de base SORT
   CREATE TABLE SORT(
      Id INT PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description TEXT,
      Niveau INT DEFAULT 1,
      DegatsBase INT DEFAULT 100,
      Composantes VARCHAR(255),
      TempsIncantation INT DEFAULT 0,
      Portee INT DEFAULT 5,
      Nom_EcoleMagie VARCHAR(255) NOT NULL,
      CONSTRAINT fk_ecolemagie_sort FOREIGN KEY(Nom_EcoleMagie) REFERENCES ECOLEMAGIE(Nom)
   );

   -- Création du trigger INSTEAD OF INSERT pour SORT
   CREATE OR REPLACE FUNCTION New_Sort_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
      -- Utilisation de la séquence pour générer la valeur Id
      NEW.Id := nextval('SORT_seq');
      RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER New_Sort_trigger
   BEFORE INSERT ON SORT
   FOR EACH ROW
   EXECUTE FUNCTION New_Sort_trigger();

-- BUFF
   CREATE TABLE BUFF(
      Id INT PRIMARY KEY,
      CONSTRAINT fk_sort_buff FOREIGN KEY(Id) REFERENCES SORT(Id)
   );

   
   -- VUE
   CREATE OR REPLACE VIEW V_BUFF AS
      SELECT S.Id, S.Nom, S.Description, S.Niveau, S.DegatsBase, S.Composantes, S.TempsIncantation, S.Portee, S.Nom_EcoleMagie
      FROM SORT S
      JOIN BUFF B ON S.Id = B.Id;


   -- Création du trigger INSTEAD OF INSERT pour V_BUFF
   CREATE OR REPLACE FUNCTION New_Buff_trigger()
   RETURNS TRIGGER AS $$
   DECLARE
   BEGIN
     -- Nouveau SORT
     INSERT INTO SORT(Id, Nom, Description, Niveau, DegatsBase, Composantes, TempsIncantation, Portee, Nom_EcoleMagie)
     VALUES (NEW.Id, NEW.Nom, NEW.Description, NEW.Niveau, NEW.DegatsBase, NEW.Composantes, NEW.TempsIncantation, NEW.Portee, NEW.Nom_EcoleMagie)
     RETURNING Id INTO New.Id;

     -- Nouveau BUFF
     INSERT INTO BUFF(Id)
     VALUES (New.Id);

     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER New_Buff_trigger
   INSTEAD OF INSERT ON V_BUFF
   FOR EACH ROW
   EXECUTE FUNCTION New_Buff_trigger();


   -- Création du trigger INSTEAD OF UPDATE pour V_BUFF
   CREATE OR REPLACE FUNCTION Update_Buff_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Mise à jour du SORT
     UPDATE SORT
     SET Nom = NEW.Nom,
         Description = NEW.Description,
         Niveau = NEW.Niveau,
         DegatsBase = NEW.DegatsBase,
         Composantes = NEW.Composantes,
         TempsIncantation = NEW.TempsIncantation,
         Portee = NEW.Portee,
         Nom_EcoleMagie = NEW.Nom_EcoleMagie
     WHERE Id = NEW.Id;

     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER Update_Buff_trigger
   INSTEAD OF UPDATE ON V_BUFF
   FOR EACH ROW
   EXECUTE FUNCTION Update_Buff_trigger();



   -- Création du trigger INSTEAD OF DELETE pour V_BUFF
   CREATE OR REPLACE FUNCTION Delete_Buff_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Suppression du BUFF
     DELETE FROM BUFF
     WHERE Id = OLD.Id;

     -- Suppression du SORT
     DELETE FROM SORT
     WHERE Id = OLD.Id;

     RETURN OLD;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER Delete_Buff_trigger
   INSTEAD OF DELETE ON V_BUFF
   FOR EACH ROW
   EXECUTE FUNCTION Delete_Buff_trigger();

-- POUVOIR
   CREATE TABLE POUVOIR(
      Id INT PRIMARY KEY,
      CONSTRAINT fk_sort_pouvoir FOREIGN KEY(Id) REFERENCES SORT(Id)
   );

   
   -- VUE
   CREATE OR REPLACE VIEW V_POUVOIR AS
      SELECT S.Id, S.Nom, S.Description, S.Niveau, S.DegatsBase, S.Composantes, S.TempsIncantation, S.Portee, S.Nom_EcoleMagie
      FROM SORT S
      JOIN POUVOIR P ON S.Id = P.Id;


   -- Création du trigger INSTEAD OF INSERT pour V_POUVOIR
   CREATE OR REPLACE FUNCTION New_Pouvoir_trigger()
   RETURNS TRIGGER AS $$
   DECLARE
   BEGIN
     -- Nouveau SORT
     INSERT INTO SORT(Id, Nom, Description, Niveau, DegatsBase, Composantes, TempsIncantation, Portee, Nom_EcoleMagie)
     VALUES (NEW.Id, NEW.Nom, NEW.Description, NEW.Niveau, NEW.DegatsBase, NEW.Composantes, NEW.TempsIncantation, NEW.Portee, NEW.Nom_EcoleMagie)
     RETURNING Id INTO New.Id;

     -- Nouveau POUVOIR
     INSERT INTO POUVOIR(Id)
     VALUES (New.Id);

     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER New_Pouvoir_trigger
   INSTEAD OF INSERT ON V_POUVOIR
   FOR EACH ROW
   EXECUTE FUNCTION New_Pouvoir_trigger();


   -- Création du trigger INSTEAD OF UPDATE pour V_POUVOIR
   CREATE OR REPLACE FUNCTION Update_Pouvoir_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Mise à jour du SORT
     UPDATE SORT
     SET Nom = NEW.Nom,
         Description = NEW.Description,
         Niveau = NEW.Niveau,
         DegatsBase = NEW.DegatsBase,
         Composantes = NEW.Composantes,
         TempsIncantation = NEW.TempsIncantation,
         Portee = NEW.Portee,
         Nom_EcoleMagie = NEW.Nom_EcoleMagie
     WHERE Id = NEW.Id;

     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER Update_Pouvoir_trigger
   INSTEAD OF UPDATE ON V_POUVOIR
   FOR EACH ROW
   EXECUTE FUNCTION Update_Pouvoir_trigger();


   -- Création du trigger INSTEAD OF DELETE pour V_POUVOIR
   CREATE OR REPLACE FUNCTION Delete_Pouvoir_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Suppression du POUVOIR
     DELETE FROM POUVOIR
     WHERE Id = OLD.Id;

     -- Suppression du SORT
     DELETE FROM SORT
     WHERE Id = OLD.Id;

     RETURN OLD;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER Delete_Pouvoir_trigger
   INSTEAD OF DELETE ON V_POUVOIR
   FOR EACH ROW
   EXECUTE FUNCTION Delete_Pouvoir_trigger();

-- RACIAL
   CREATE TABLE RACIAL(
      Id INT PRIMARY KEY,
      CONSTRAINT fk_sort_racial FOREIGN KEY(Id) REFERENCES SORT(Id)
   );


   -- VUE
   CREATE OR REPLACE VIEW V_RACIAL AS
      SELECT S.Id, S.Nom, S.Description, S.Niveau, S.DegatsBase, S.Composantes, S.TempsIncantation, S.Portee, S.Nom_EcoleMagie
      FROM SORT S
      JOIN RACIAL R ON S.Id = R.Id;


   -- Création du trigger INSTEAD OF INSERT pour V_RACIAL
   CREATE OR REPLACE FUNCTION New_Racial_trigger()
   RETURNS TRIGGER AS $$
   DECLARE
   BEGIN
     -- Nouveau SORT
     INSERT INTO SORT(Id, Nom, Description, Niveau, DegatsBase, Composantes, TempsIncantation, Portee, Nom_EcoleMagie)
     VALUES (NEW.Id, NEW.Nom, NEW.Description, NEW.Niveau, NEW.DegatsBase, NEW.Composantes, NEW.TempsIncantation, NEW.Portee, NEW.Nom_EcoleMagie)
     RETURNING Id INTO New.Id;

     -- Nouveau RACIAL
     INSERT INTO RACIAL(Id)
     VALUES (New.Id);

     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER New_Racial_trigger
   INSTEAD OF INSERT ON V_RACIAL
   FOR EACH ROW
   EXECUTE FUNCTION New_Racial_trigger();


   -- Création du trigger INSTEAD OF UPDATE pour V_RACIAL
   CREATE OR REPLACE FUNCTION Update_Racial_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Mise à jour du SORT
     UPDATE SORT
     SET Nom = NEW.Nom,
         Description = NEW.Description,
         Niveau = NEW.Niveau,
         DegatsBase = NEW.DegatsBase,
         Composantes = NEW.Composantes,
         TempsIncantation = NEW.TempsIncantation,
         Portee = NEW.Portee,
         Nom_EcoleMagie = NEW.Nom_EcoleMagie
     WHERE Id = NEW.Id;

     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER Update_Racial_trigger
   INSTEAD OF UPDATE ON V_RACIAL
   FOR EACH ROW
   EXECUTE FUNCTION Update_Racial_trigger();


   -- Création du trigger INSTEAD OF DELETE pour V_RACIAL
   CREATE OR REPLACE FUNCTION Delete_Racial_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Suppression du RACIAL
     DELETE FROM RACIAL
     WHERE Id = OLD.Id;

     -- Suppression du SORT
     DELETE FROM SORT
     WHERE Id = OLD.Id;

     RETURN OLD;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER Delete_Racial_trigger
   INSTEAD OF DELETE ON V_RACIAL
   FOR EACH ROW
   EXECUTE FUNCTION Delete_Racial_trigger();

-- COMPETENCE
   CREATE TABLE COMPETENCE(
      Id INT PRIMARY KEY,
      CONSTRAINT fk_sort_competence FOREIGN KEY(Id) REFERENCES SORT(Id)
   );


   -- VUE
   CREATE OR REPLACE VIEW V_COMPETENCE AS
      SELECT S.Id, S.Nom, S.Description, S.Niveau, S.DegatsBase, S.Composantes, S.TempsIncantation, S.Portee, S.Nom_EcoleMagie
      FROM SORT S
      JOIN COMPETENCE C ON S.Id = C.Id;


   -- Création du trigger INSTEAD OF INSERT pour V_COMPETENCE
   CREATE OR REPLACE FUNCTION New_Competence_trigger()
   RETURNS TRIGGER AS $$
   DECLARE
   BEGIN
     -- Nouveau SORT
     INSERT INTO SORT(Id, Nom, Description, Niveau, DegatsBase, Composantes, TempsIncantation, Portee, Nom_EcoleMagie)
     VALUES (NEW.Id, NEW.Nom, NEW.Description, NEW.Niveau, NEW.DegatsBase, NEW.Composantes, NEW.TempsIncantation, NEW.Portee, NEW.Nom_EcoleMagie)
     RETURNING Id INTO New.Id;

     -- Nouveau COMPETENCE
     INSERT INTO COMPETENCE(Id)
     VALUES (New.Id);

     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER New_Competence_trigger
   INSTEAD OF INSERT ON V_COMPETENCE
   FOR EACH ROW
   EXECUTE FUNCTION New_Competence_trigger();


   -- Création du trigger INSTEAD OF UPDATE pour V_COMPETENCE
   CREATE OR REPLACE FUNCTION Update_Competence_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Mise à jour du SORT
     UPDATE SORT
     SET Nom = NEW.Nom,
         Description = NEW.Description,
         Niveau = NEW.Niveau,
         DegatsBase = NEW.DegatsBase,
         Composantes = NEW.Composantes,
         TempsIncantation = NEW.TempsIncantation,
         Portee = NEW.Portee,
         Nom_EcoleMagie = NEW.Nom_EcoleMagie
     WHERE Id = NEW.Id;

     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER Update_Competence_trigger
   INSTEAD OF UPDATE ON V_COMPETENCE
   FOR EACH ROW
   EXECUTE FUNCTION Update_Competence_trigger();


   -- Création du trigger INSTEAD OF DELETE pour V_COMPETENCE
   CREATE OR REPLACE FUNCTION Delete_Competence_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Suppression du COMPETENCE
     DELETE FROM COMPETENCE
     WHERE Id = OLD.Id;

     -- Suppression du SORT
     DELETE FROM SORT
     WHERE Id = OLD.Id;

     RETURN OLD;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER Delete_Competence_trigger
   INSTEAD OF DELETE ON V_COMPETENCE
   FOR EACH ROW
   EXECUTE FUNCTION Delete_Competence_trigger();

-- FACTION_PERSONNAGE
   CREATE TABLE FACTION_PERSONNAGE(
      Id_Personnage INT,
      Id_Faction INT,
      Grade VARCHAR(255) DEFAULT 'Étranger',
      Reputation INT DEFAULT 0,
      PRIMARY KEY(Id_Personnage, Id_Faction),
      CONSTRAINT fk_personnage_fp FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_faction_fp FOREIGN KEY(Id_Faction) REFERENCES FACTION(Id)
   );

-- HAUTFAIT_PERSONNAGE
   CREATE TABLE HAUTFAIT_PERSONNAGE(
      Id_Personnage INT,
      Id_HautFait INT,
      PRIMARY KEY(Id_Personnage, Id_HautFait),
      CONSTRAINT fk_personnage_hp FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_hautfait_hp FOREIGN KEY(Id_HautFait) REFERENCES HAUTFAIT(Id)
   );

-- PERSONNAGE_TITRE
   CREATE TABLE PERSONNAGE_TITRE(
      Id_Personnage INT,
      Id_Titre INT,
      EstActif  BOOL DEFAULT FALSE,
      PRIMARY KEY(Id_Personnage, Id_Titre),
      CONSTRAINT fk_personnage_pt FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_titre_pt FOREIGN KEY(Id_Titre) REFERENCES TITRE(Id)
   );

-- LANGUE_PERSONNAGE
   CREATE TABLE LANGUE_PERSONNAGE(
      Id_Personnage INT,
      Id_Langue INT,
      PRIMARY KEY(Id_Personnage, Id_Langue),
      CONSTRAINT fk_personnage_lp FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_langue_lp FOREIGN KEY(Id_Langue) REFERENCES LANGUE(Id)
   );

-- LANGUE_RACE
   CREATE TABLE LANGUE_RACE(
      Nom_Race VARCHAR(255),
      Id_Langue INT,
      PRIMARY KEY(Nom_Race, Id_Langue),
      CONSTRAINT fk_race_lr FOREIGN KEY(Nom_Race) REFERENCES RACE(Nom),
      CONSTRAINT fk_langue_lr FOREIGN KEY(Id_Langue) REFERENCES LANGUE(Id)
   );

-- MONSTRE_TYPEMONSTRE
   CREATE TABLE MONSTRE_TYPEMONSTRE(
      Id_Monstre INT,
      Id_Typemonstre INT,
      PRIMARY KEY(Id_Monstre, Id_Typemonstre),
      CONSTRAINT fk_monstre_mt FOREIGN KEY(Id_Monstre) REFERENCES MONSTRE(Id),
      CONSTRAINT fk_typemonstre_mt FOREIGN KEY(Id_Typemonstre) REFERENCES TYPEMONSTRE(Id)
   );

-- ARME_TYPEARME
   CREATE TABLE ARME_TYPEARME(
      Id_Arme INT,
      Id_Typearme INT,
      PRIMARY KEY(Id_Arme, Id_Typearme),
      CONSTRAINT fk_arme_at FOREIGN KEY(Id_Arme) REFERENCES ARME(Id),
      CONSTRAINT fk_typearme_at FOREIGN KEY(Id_Typearme) REFERENCES TYPEARME(Id)
   );

-- ARMURE_TYPEARMURE
   CREATE TABLE ARMURE_TYPEARMURE(
      Id_Armure INT,
      Id_Typearmure INT,
      PRIMARY KEY(Id_Armure, Id_Typearmure),
      CONSTRAINT fk_armure_at FOREIGN KEY(Id_Armure) REFERENCES ARMURE(Id),
      CONSTRAINT fk_typearmure_at FOREIGN KEY(Id_Typearmure) REFERENCES TYPEARMURE(Id)
   );

-- METIER_RECETTE
   CREATE TABLE METIER_RECETTE(
      Id_Metier INT,
      Id_Recette INT,
      NiveauRequis INT DEFAULT 1,
      PRIMARY KEY(Id_Metier, Id_Recette),
      CONSTRAINT fk_metier_mr FOREIGN KEY(Id_Metier) REFERENCES METIER(Id),
      CONSTRAINT fk_recette_mr FOREIGN KEY(Id_Recette) REFERENCES RECETTE(Id)
   );

-- METIER_OUTIL
   CREATE TABLE METIER_OUTIL(
      Id_Metier INT,
      Id_Outil INT,
      PRIMARY KEY(Id_Metier, Id_Outil),
      CONSTRAINT fk_metier_mo FOREIGN KEY(Id_Metier) REFERENCES METIER(Id),
      CONSTRAINT fk_outil_mo FOREIGN KEY(Id_Outil) REFERENCES OUTIL(Id)
   );

-- ITEM_RECETTE
   CREATE TABLE ITEM_RECETTE(
      Id_Item INT,
      Id_Recette INT,
      Quantite INT DEFAULT 1,
      PRIMARY KEY(Id_Item, Id_Recette),
      CONSTRAINT fk_item_item_recette FOREIGN KEY(Id_Item) REFERENCES ITEM(Id),
      CONSTRAINT fk_recette_item_recette FOREIGN KEY(Id_Recette) REFERENCES RECETTE(Id)
   );

-- CLASSE_TYPEARME
   CREATE TABLE CLASSE_TYPEARME(
      Nom_Classe VARCHAR(255),
      Id_Typearme INT,
      PRIMARY KEY(Nom_Classe, Id_Typearme),
      CONSTRAINT fk_classe_classe_typearme FOREIGN KEY(Nom_Classe) REFERENCES CLASSE(Nom),
      CONSTRAINT fk_typearme_classe_typearme FOREIGN KEY(Id_Typearme) REFERENCES TYPEARME(Id)
   );

-- CLASSE_TYPEARMURE
   CREATE TABLE CLASSE_TYPEARMURE(
      Nom_Classe VARCHAR(255),
      Id_Typearmure INT,
      PRIMARY KEY(Nom_Classe, Id_Typearmure),
      CONSTRAINT fk_classe_ct FOREIGN KEY(Nom_Classe) REFERENCES CLASSE(Nom),
      CONSTRAINT fk_typearmure_ct FOREIGN KEY(Id_Typearmure) REFERENCES TYPEARMURE(Id)
   );

-- CLASSE_COMPETENCE
   CREATE TABLE CLASSE_COMPETENCE(
      Id_Competence INT,
      Nom_Classe VARCHAR(255),
      PRIMARY KEY(Id_Competence, Nom_Classe),
      CONSTRAINT fk_competence_cc FOREIGN KEY(Id_Competence) REFERENCES COMPETENCE(Id),
      CONSTRAINT fk_classe_cc FOREIGN KEY(Nom_Classe) REFERENCES CLASSE(Nom)
   );

-- RACE_RACIAL
   CREATE TABLE RACE_RACIAL(
      Id_Racial INT,
      Nom_Race VARCHAR(255),
      PRIMARY KEY(Id_Racial, Nom_Race),
      CONSTRAINT fk_racial_race_racial FOREIGN KEY(Id_Racial) REFERENCES RACIAL(Id),
      CONSTRAINT fk_race_race_racial FOREIGN KEY(Nom_Race) REFERENCES RACE(Nom)
   );

-- COMBAT
   CREATE TABLE COMBAT(
      Id_PJ INT,
      Id_Monstre INT,
      Resultat VARCHAR(255) DEFAULT 'victoire',
      DateCombat TIMESTAMP DEFAULT current_timestamp,
      PRIMARY KEY(Id_PJ, Id_Monstre, DateCombat),
      CONSTRAINT fk_pj_combat FOREIGN KEY(Id_PJ) REFERENCES PJ(Id),
      CONSTRAINT fk_monstre_combat FOREIGN KEY(Id_Monstre) REFERENCES MONSTRE(Id)
   );

-- METIER_PERSONNAGE
   CREATE TABLE METIER_PERSONNAGE(
      Id_Personnage INT,
      Id_Metier INT,
      Niveau INT DEFAULT 1,
      PRIMARY KEY(Id_Personnage, Id_Metier),
      CONSTRAINT fk_personnage_mp FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_metier_mp FOREIGN KEY(Id_Metier) REFERENCES METIER(Id)
   );

-- PERSONNAGE_RECETTE
   CREATE TABLE PERSONNAGE_RECETTE(
      Id_Personnage INT,
      Id_Recette INT,
      PRIMARY KEY(Id_Personnage, Id_Recette),
      CONSTRAINT fk_personnage_pr FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_recette_pr FOREIGN KEY(Id_Recette) REFERENCES RECETTE(Id)
   );

-- GRIMOIRE
   CREATE TABLE GRIMOIRE(
      Id_Personnage INT,
      Id_Sort INT,
      PRIMARY KEY(Id_Personnage, Id_Sort),
      CONSTRAINT fk_personnage_grimoire FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_sort_grimoire FOREIGN KEY(Id_Sort) REFERENCES SORT(Id)
   );

-- INVENTAIRE
   CREATE TABLE INVENTAIRE(
      Id_Personnage INT,
      Id_Item INT,
      PRIMARY KEY(Id_Personnage, Id_Item),
      CONSTRAINT fk_personnage_inventaire FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_item_inventaire FOREIGN KEY(Id_Item) REFERENCES ITEM(Id)
   );

-- EVENEMENT_MONSTRE
   CREATE TABLE EVENEMENT_MONSTRE(
      Id_Monstre INT,
      Id_Evenement INT,
      PRIMARY KEY(Id_Monstre, Id_Evenement),
      CONSTRAINT fk_monstre_evenement_monstre FOREIGN KEY(Id_Monstre) REFERENCES MONSTRE(Id),
      CONSTRAINT fk_evenement_evenement_monstre FOREIGN KEY(Id_Evenement) REFERENCES EVENEMENT(Id)
   );

-- EVENEMENT_ITEM
   CREATE TABLE EVENEMENT_ITEM(
      Id_Item INT,
      Id_Evenement INT,
      PRIMARY KEY(Id_Item, Id_Evenement),
      CONSTRAINT fk_item_evenement_item FOREIGN KEY(Id_Item) REFERENCES ITEM(Id),
      CONSTRAINT fk_evenement_evenement_item FOREIGN KEY(Id_Evenement) REFERENCES EVENEMENT(Id)
   );

-- CALENDRIER_EVENEMENT
   CREATE TABLE CALENDRIER_EVENEMENT(
      DateEvent TIMESTAMP DEFAULT current_timestamp,
      Id INT,
      PRIMARY KEY(DateEvent, Id),
      CONSTRAINT fk_evenement_ce FOREIGN KEY(Id) REFERENCES EVENEMENT(Id)
   );

-- SUITEQUETE
   CREATE TABLE SUITEQUETE(
      Id_Fils INT,
      Id_Pere INT,
      PRIMARY KEY(Id_Fils, Id_Pere),
      CONSTRAINT fk_quetefils_suitequete FOREIGN KEY(Id_Fils) REFERENCES QUETE(Id),
      CONSTRAINT fk_quetepere_suitequete FOREIGN KEY(Id_Pere) REFERENCES QUETE(Id)
   );

-- EVENEMENT_QUETE
   CREATE TABLE EVENEMENT_QUETE(
      Id_Quete INT,
      Id_Evenement INT,
      PRIMARY KEY(Id_Quete, Id_Evenement),
      CONSTRAINT fk_quete_evenement_quete FOREIGN KEY(Id_Quete) REFERENCES QUETE(Id),
      CONSTRAINT fk_evenement_evenement_quete FOREIGN KEY(Id_Evenement) REFERENCES EVENEMENT(Id)
   );

-- BUFF_PERSONNAGE
   CREATE TABLE BUFF_PERSONNAGE(
      Id_Personnage INT,
      Id_Buff INT,
      Duree INT DEFAULT 60,
      PRIMARY KEY(Id_Personnage, Id_Buff),
      CONSTRAINT fk_personnage_buff_personnage FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_buff_buff_personnage FOREIGN KEY(Id_Buff) REFERENCES BUFF(Id)
   );

-- PERSONNAGE_QUETE
   CREATE TABLE PERSONNAGE_QUETE(
      Id_Personnage INT,
      Id_Quete INT,
      Statut VARCHAR(255) DEFAULT 'En Cours',
      DateDebut TIMESTAMP DEFAULT current_timestamp,
      DateFin TIMESTAMP,
      PRIMARY KEY(Id_Personnage, Id_Quete),
      CONSTRAINT fk_personnage_personnage_quete FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_quete_personnage_quete FOREIGN KEY(Id_Quete) REFERENCES QUETE(Id)
   );

-- PERSONNAGE_QUETEJOURNALIERE
   CREATE TABLE PERSONNAGE_QUETEJOURNALIERE(
      Id_Personnage INT,
      Id_Quete INT,
      Code_Jour TIMESTAMP DEFAULT current_timestamp,
      Statut VARCHAR(255) DEFAULT 'En Cours',
      DateDebut TIMESTAMP DEFAULT current_timestamp,
      DateFin TIMESTAMP,
      PRIMARY KEY(Id_Personnage, Id_Quete, Code_Jour),
      CONSTRAINT fk_personnage_pqj FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_quetejournaliere_pqj FOREIGN KEY(Id_Quete) REFERENCES QUETE(Id)
   );

-- METIER_TYPERESSOURCE
   CREATE TABLE METIER_TYPERESSOURCE(
      Id_Typeressource INT,
      Id_Metier INT,
      PRIMARY KEY(Id_Typeressource, Id_Metier),
      CONSTRAINT fk_ressource_metier_ressource FOREIGN KEY(Id_Typeressource) REFERENCES TYPERESSOURCE(Id),
      CONSTRAINT fk_metier_metier_ressource FOREIGN KEY(Id_Metier) REFERENCES METIER(Id)
   );

-- ITEMQUETE_QUETE
   CREATE TABLE ITEMQUETE_QUETE(
      Id_Item INT,
      Id_Quete INT,
      PRIMARY KEY(Id_Item, Id_Quete),
      CONSTRAINT fk_itemquete_itemquete_quete FOREIGN KEY(Id_Item) REFERENCES ITEMQUETE(Id),
      CONSTRAINT fk_quete_itemquete_quete FOREIGN KEY(Id_Quete) REFERENCES QUETE(Id)
   );

-- APPARENCEPOSSIBLE_FACTION
   CREATE TABLE APPARENCEPOSSIBLE_FACTION(
      Id_Faction INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Faction, Id_Apparence),
      CONSTRAINT fk_faction_apf FOREIGN KEY(Id_Faction) REFERENCES FACTION(Id),
      CONSTRAINT fk_apparence_apf FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_FACTION
   CREATE TABLE APPARENCE_FACTION(
      Id_Faction INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Faction, Id_Apparence),
      CONSTRAINT fk_faction_af FOREIGN KEY(Id_Faction) REFERENCES FACTION(Id),
      CONSTRAINT fk_apparence_af FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_good_af FOREIGN KEY (Id_Apparence, Id_Faction) REFERENCES APPARENCEPOSSIBLE_FACTION(Id_Apparence, Id_Faction)
   );

-- APPARENCEPOSSIBLE_HAUTFAIT
   CREATE TABLE APPARENCEPOSSIBLE_HAUTFAIT(
      Id_Hautfait INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Hautfait, Id_Apparence),
      CONSTRAINT fk_hautfait_aph FOREIGN KEY(Id_Hautfait) REFERENCES HAUTFAIT(Id),
      CONSTRAINT fk_apparence_aph FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_HAUTFAIT
   CREATE TABLE APPARENCE_HAUTFAIT(
      Id_Hautfait INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Hautfait, Id_Apparence),
      CONSTRAINT fk_hautfait_ah FOREIGN KEY(Id_Hautfait) REFERENCES HAUTFAIT(Id),
      CONSTRAINT fk_apparence_ah FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_good_ah FOREIGN KEY (Id_Apparence, Id_Hautfait) REFERENCES APPARENCEPOSSIBLE_HAUTFAIT(Id_Apparence, Id_Hautfait)
   );

-- APPARENCEPOSSIBLE_TITRE
   CREATE TABLE APPARENCEPOSSIBLE_TITRE(
      Id_Titre INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Titre, Id_Apparence),
      CONSTRAINT fk_titre_apt FOREIGN KEY(Id_Titre) REFERENCES TITRE(Id),
      CONSTRAINT fk_apparence_apt FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_TITRE
   CREATE TABLE APPARENCE_TITRE(
      Id_Titre INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Titre, Id_Apparence),
      CONSTRAINT fk_titre_at FOREIGN KEY(Id_Titre) REFERENCES TITRE(Id),
      CONSTRAINT fk_apparence_at FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodat FOREIGN KEY (Id_Apparence, Id_Titre) REFERENCES APPARENCEPOSSIBLE_TITRE(Id_Apparence, Id_Titre)
   );

-- APPARENCEPOSSIBLE_PERSONNAGE
   CREATE TABLE APPARENCEPOSSIBLE_PERSONNAGE(
      Id_Personnage INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Personnage, Id_Apparence),
      CONSTRAINT fk_personnage_app FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_apparence_app FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_PERSONNAGE
   CREATE TABLE APPARENCE_PERSONNAGE(
      Id_Personnage INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Personnage, Id_Apparence),
      CONSTRAINT fk_personnage_ap FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_apparence_ap FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodap FOREIGN KEY (Id_Apparence, Id_Personnage) REFERENCES APPARENCEPOSSIBLE_PERSONNAGE(Id_Apparence, Id_Personnage)
   );

-- APPARENCEPOSSIBLE_RACE
   CREATE TABLE APPARENCEPOSSIBLE_RACE(
      Nom_Race VARCHAR(255),
      Id_Apparence INT,
      PRIMARY KEY(Nom_Race, Id_Apparence),
      CONSTRAINT fk_race_apr FOREIGN KEY(Nom_Race) REFERENCES RACE(Nom),
      CONSTRAINT fk_apparence_apr FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_RACE
   CREATE TABLE APPARENCE_RACE(
      Nom_Race VARCHAR(255),
      Id_Apparence INT,
      PRIMARY KEY(Nom_Race, Id_Apparence),
      CONSTRAINT fk_race_ar FOREIGN KEY(Nom_Race) REFERENCES RACE(Nom),
      CONSTRAINT fk_apparence_ar FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodar FOREIGN KEY (Id_Apparence, Nom_Race) REFERENCES APPARENCEPOSSIBLE_RACE(Id_Apparence, Nom_Race)
   );

-- APPARENCEPOSSIBLE_CLASSE
   CREATE TABLE APPARENCEPOSSIBLE_CLASSE(
      Nom_Classe VARCHAR(255),
      Id_Apparence INT,
      PRIMARY KEY(Nom_Classe, Id_Apparence),
      CONSTRAINT fk_classe_apc FOREIGN KEY(Nom_Classe) REFERENCES CLASSE(Nom),
      CONSTRAINT fk_apparence_apc FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_CLASSE
   CREATE TABLE APPARENCE_CLASSE(
      Nom_Classe VARCHAR(255),
      Id_Apparence INT,
      PRIMARY KEY(Nom_Classe, Id_Apparence),
      CONSTRAINT fk_classe_ac FOREIGN KEY(Nom_Classe) REFERENCES CLASSE(Nom),
      CONSTRAINT fk_apparence_ac FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodac FOREIGN KEY (Id_Apparence, Nom_Classe) REFERENCES APPARENCEPOSSIBLE_CLASSE(Id_Apparence, Nom_Classe)
   );

-- APPARENCEPOSSIBLE_SORT
   CREATE TABLE APPARENCEPOSSIBLE_SORT(
      Id_Sort INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Sort, Id_Apparence),
      CONSTRAINT fk_sort_aps FOREIGN KEY(Id_Sort) REFERENCES SORT(Id),
      CONSTRAINT fk_apparence_aps FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_SORT
   CREATE TABLE APPARENCE_SORT(
      Id_Sort INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Sort, Id_Apparence),
      CONSTRAINT fk_sort_as FOREIGN KEY(Id_Sort) REFERENCES SORT(Id),
      CONSTRAINT fk_apparence_as FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodas FOREIGN KEY (Id_Apparence, Id_Sort) REFERENCES APPARENCEPOSSIBLE_SORT(Id_Apparence, Id_Sort)
   );

-- APPARENCEPOSSIBLE_METIER
   CREATE TABLE APPARENCEPOSSIBLE_METIER(
      Id_Metier INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Metier, Id_Apparence),
      CONSTRAINT fk_metier_apm FOREIGN KEY(Id_Metier) REFERENCES METIER(Id),
      CONSTRAINT fk_apparence_apm FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_METIER
   CREATE TABLE APPARENCE_METIER(
      Id_Metier INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Metier, Id_Apparence),
      CONSTRAINT fk_metier_am FOREIGN KEY(Id_Metier) REFERENCES METIER(Id),
      CONSTRAINT fk_apparence_am FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodam FOREIGN KEY (Id_Apparence, Id_Metier) REFERENCES APPARENCEPOSSIBLE_METIER(Id_Apparence, Id_Metier)
   );

-- APPARENCEPOSSIBLE_ITEM
   CREATE TABLE APPARENCEPOSSIBLE_ITEM(
      Id_Item INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Item, Id_Apparence),
      CONSTRAINT fk_item_api FOREIGN KEY(Id_Item) REFERENCES ITEM(Id),
      CONSTRAINT fk_apparence_api FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_ITEM
   CREATE TABLE APPARENCE_ITEM(
      Id_Item INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Item, Id_Apparence),
      CONSTRAINT fk_item_ai FOREIGN KEY(Id_Item) REFERENCES ITEM(Id),
      CONSTRAINT fk_apparence_ai FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodai FOREIGN KEY (Id_Apparence, Id_Item) REFERENCES APPARENCEPOSSIBLE_ITEM(Id_Apparence, Id_Item)
   );

-- APPARENCEPOSSIBLE_EVENEMENT
   CREATE TABLE APPARENCEPOSSIBLE_EVENEMENT(
      Id_Evenement INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Evenement, Id_Apparence),
      CONSTRAINT fk_evenement_ape FOREIGN KEY(Id_Evenement) REFERENCES EVENEMENT(Id),
      CONSTRAINT fk_apparence_ape FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_EVENEMENT
   CREATE TABLE APPARENCE_EVENEMENT(
      Id_Evenement INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Evenement, Id_Apparence),
      CONSTRAINT fk_evenement_ae FOREIGN KEY(Id_Evenement) REFERENCES EVENEMENT(Id),
      CONSTRAINT fk_apparence_ae FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodae FOREIGN KEY (Id_Apparence, Id_Evenement) REFERENCES APPARENCEPOSSIBLE_EVENEMENT(Id_Apparence, Id_Evenement)
   );

-- APPARENCEPOSSIBLE_QUETE
   CREATE TABLE APPARENCEPOSSIBLE_QUETE(
      Id_Quete INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Quete, Id_Apparence),
      CONSTRAINT fk_quete_apq FOREIGN KEY(Id_Quete) REFERENCES QUETE(Id),
      CONSTRAINT fk_apparence_apq FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_QUETE
   CREATE TABLE APPARENCE_QUETE(
      Id_Quete INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Quete, Id_Apparence),
      CONSTRAINT fk_quete_aq FOREIGN KEY(Id_Quete) REFERENCES QUETE(Id),
      CONSTRAINT fk_apparence_aq FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodaq FOREIGN KEY (Id_Apparence, Id_Quete) REFERENCES APPARENCEPOSSIBLE_QUETE(Id_Apparence, Id_Quete)
   );

-- APPARENCEPOSSIBLE_LIEUX
   CREATE TABLE APPARENCEPOSSIBLE_LIEUX(
      Id_Lieux INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Lieux, Id_Apparence),
      CONSTRAINT fk_lieux_apl FOREIGN KEY(Id_Lieux) REFERENCES LIEUX(Id),
      CONSTRAINT fk_apparence_apl FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_LIEUX
   CREATE TABLE APPARENCE_LIEUX(
      Id_Lieux INT,
      Id_Apparence INT,
      PRIMARY KEY(Id_Lieux, Id_Apparence),
      CONSTRAINT fk_lieux_al FOREIGN KEY(Id_Lieux) REFERENCES LIEUX(Id),
      CONSTRAINT fk_apparence_al FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodal FOREIGN KEY (Id_Apparence, Id_Lieux) REFERENCES APPARENCEPOSSIBLE_LIEUX(Id_Apparence, Id_Lieux)
   );

-- SLOT_ARMURE
   -- Création de la séquence
   CREATE SEQUENCE SLOT_ARMURE_seq
        START 1
        INCREMENT 1
        NO MAXVALUE
        CACHE 2;

   -- Création de la table SLOT_ARMURE
   CREATE TABLE SLOT_ARMURE(
         Id SERIAL PRIMARY KEY,
         Nom VARCHAR(255) NOT NULL,
         Description TEXT
      );

   -- Création de la fonction et du déclencheur (trigger) pour gérer l'incrémentation de l'ID
   CREATE OR REPLACE FUNCTION New_Slot_Armure_function()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     NEW.Id = nextval('SLOT_ARMURE_seq');
     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER New_Slot_Armure_trigger
   BEFORE INSERT ON SLOT_ARMURE
   FOR EACH ROW
   EXECUTE FUNCTION New_Slot_Armure_function();

-- ARMURE_EQUIPER
   CREATE TABLE ARMURE_EQUIPER(
      Id_Personnage INT,
      Id_Armure INT,
      Id_SlotArmure INT,
      PRIMARY KEY(Id_Personnage, Id_Armure, Id_SlotArmure),
      CONSTRAINT fk_Personnage_armuerE FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_Armure_armuerE FOREIGN KEY(Id_Armure) REFERENCES ARMURE(Id),
      CONSTRAINT fk_SlotArmure_armuerE FOREIGN KEY(Id_SlotArmure) REFERENCES SLOT_ARMURE(Id)
   );

-- SLOT_ARME
   -- Création de la séquence
   CREATE SEQUENCE SLOT_ARME_seq
        START 1
        INCREMENT 1
        NO MAXVALUE
        CACHE 2;

   -- Création de la table SLOT_ARME
   CREATE TABLE SLOT_ARME(
         Id SERIAL PRIMARY KEY,
         Nom VARCHAR(255) NOT NULL,
         Description TEXT
      );

   -- Création de la fonction et du déclencheur (trigger) pour gérer l'incrémentation de l'ID
   CREATE OR REPLACE FUNCTION New_Slot_Arme_function()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     NEW.Id = nextval('SLOT_ARME_seq');
     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER New_Slot_Arme_trigger
   BEFORE INSERT ON SLOT_ARME
   FOR EACH ROW
   EXECUTE FUNCTION New_Slot_Arme_function();

-- ARME_EQUIPER
   CREATE TABLE ARME_EQUIPER(
      Id_Personnage INT,
      Id_Arme INT,
      Id_SlotArme INT,
      PRIMARY KEY(Id_Personnage, Id_Arme, Id_SlotArme),
      CONSTRAINT fk_Personnage_armeE FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_Arme_armeE FOREIGN KEY(Id_Arme) REFERENCES ARME(Id),
      CONSTRAINT fk_SlotArme_armeE FOREIGN KEY(Id_SlotArme) REFERENCES SLOT_ARME(Id)
   );

-- CARACTERISTIQUE
   -- Création de la séquence
   CREATE SEQUENCE CARACTERISTIQUE_seq
        START 1
        INCREMENT 1
        NO MAXVALUE
        CACHE 2;

   -- Création de la table CARACTERISTIQUE
   CREATE TABLE CARACTERISTIQUE(
         Id SERIAL PRIMARY KEY,
         Nom VARCHAR(255) NOT NULL,
         Description TEXT
      );

   -- Création de la fonction et du déclencheur (trigger) pour gérer l'incrémentation de l'ID
   CREATE OR REPLACE FUNCTION New_Caracteristique_function()
   RETURNS TRIGGER AS $$
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     NEW.Id = nextval('CARACTERISTIQUE_seq');
     RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;

   CREATE TRIGGER New_Caracteristique_trigger
   BEFORE INSERT ON CARACTERISTIQUE
   FOR EACH ROW
   EXECUTE FUNCTION New_Caracteristique_function();

-- PERSONNAGE_CARACTERISTIQUE
   CREATE TABLE PERSONNAGE_CARACTERISTIQUE(
      Id_Personnage INT,
      Id_Caracteristique INT,
      Valeur INT,
      PRIMARY KEY(Id_Personnage, Id_Caracteristique),
      CONSTRAINT fk_Personnage_PC FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_SlotArme_PC FOREIGN KEY(Id_Caracteristique) REFERENCES CARACTERISTIQUE(Id)
   );

-- BYPASS pour le style
    CREATE TABLE BYPASS(
        Id INT PRIMARY KEY,
        Chaine TEXT
    );