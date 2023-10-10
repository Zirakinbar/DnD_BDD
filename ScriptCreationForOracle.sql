-- TYPEMONSTRE
   -- Création de la séquence
   CREATE SEQUENCE TYPEMONSTRE_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE TYPEMONSTRE(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB
   );

   CREATE OR REPLACE TRIGGER New_TypeMonstre_trigger
   BEFORE INSERT ON TYPEMONSTRE
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := TYPEMONSTRE_seq.NEXTVAL;
   END;
   /

-- ECOLEMAGIE
   CREATE TABLE ECOLEMAGIE(
      Nom VARCHAR(255) PRIMARY KEY,
      Description CLOB
   );

-- CLASSE
   CREATE TABLE CLASSE(
      Nom VARCHAR(255) PRIMARY KEY,
      Description CLOB,
      PointDeVie_Base NUMBER(5) DEFAULT 1000
   );

-- RACE
   CREATE TABLE RACE(
      Nom VARCHAR(255) PRIMARY KEY,
      Description CLOB,
      Vitesse NUMBER(5) DEFAULT 15,
      TailleMin NUMBER(5) DEFAULT 90,
      TailleMax NUMBER(5) DEFAULT 250
   );

-- FACTION
   -- Création de la séquence
   CREATE SEQUENCE FACTION_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE FACTION(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB
   );

   -- Création du trigger INSTEAD OF INSERT pour FACTION
   CREATE OR REPLACE TRIGGER New_Faction_trigger
   BEFORE INSERT ON FACTION
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := FACTION_seq.NEXTVAL;
   END;
   /

-- HAUTFAIT
   -- Création de la séquence
   CREATE SEQUENCE HAUTFAIT_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE HAUTFAIT(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB,
      PointHF NUMBER(5) DEFAULT 0
   );

   -- Création du trigger INSTEAD OF INSERT pour HAUTFAIT
   CREATE OR REPLACE TRIGGER New_HautFait_trigger
   BEFORE INSERT ON HAUTFAIT
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := HAUTFAIT_seq.NEXTVAL;
   END;
   /

-- TITRE
   -- Création de la séquence
   CREATE SEQUENCE TITRE_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE TITRE(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description VARCHAR(255),
      MethodeOptention VARCHAR(255) DEFAULT NULL
   );

   -- Création du trigger INSTEAD OF INSERT pour TITRE
   CREATE OR REPLACE TRIGGER New_Titre_trigger
   BEFORE INSERT ON TITRE
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := TITRE_seq.NEXTVAL;
   END;
   /

-- LANGUE
   -- Création de la séquence
   CREATE SEQUENCE LANGUE_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE LANGUE(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB
   );

   -- Création du trigger INSTEAD OF INSERT pour LANGUE
   CREATE OR REPLACE TRIGGER New_Langue_trigger
   BEFORE INSERT ON LANGUE
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := LANGUE_seq.NEXTVAL;
   END;
   /

-- TYPERESSOURCE
   -- Création de la séquence
   CREATE SEQUENCE TYPERESSOURCE_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE TYPERESSOURCE(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB
   );

   -- Création du trigger INSTEAD OF INSERT pour TYPERESSOURCE
   CREATE OR REPLACE TRIGGER New_Typeressource_trigger
   BEFORE INSERT ON TYPERESSOURCE
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := TYPERESSOURCE_seq.NEXTVAL;
   END;
   /

-- TYPECONSOMMABLE
   -- Création de la séquence
   CREATE SEQUENCE TYPECONSOMMABLE_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE TYPECONSOMMABLE(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB
   );

   -- Création du trigger INSTEAD OF INSERT pour TYPECONSOMMABLE
   CREATE OR REPLACE TRIGGER New_Typeconsommable_trigger
   BEFORE INSERT ON TYPECONSOMMABLE
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := TYPECONSOMMABLE_seq.NEXTVAL;
   END;
   /

-- ITEM
   -- Création de la séquence
   CREATE SEQUENCE ITEM_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE ITEM(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB
   );

   -- Création du trigger INSTEAD OF INSERT pour ITEM
   CREATE OR REPLACE TRIGGER New_Item_trigger
   BEFORE INSERT ON ITEM
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := ITEM_seq.NEXTVAL;
   END;
   /

-- ARMURE
   CREATE TABLE ARMURE(
      Id NUMBER PRIMARY KEY,
      PointDeVieBase NUMBER(5) DEFAULT 100,
      ArmureBase NUMBER(5) DEFAULT 100,
      CONSTRAINT fk_armure_item FOREIGN KEY (Id) REFERENCES ITEM (Id)
   );

   -- Création de la View pour ARMURE
      CREATE OR REPLACE VIEW V_ARMURE AS
        SELECT I.Id, I.Nom, I.Description, A.PointDeVieBase, A.ArmureBase
        FROM ITEM I
        JOIN ARMURE A ON I.Id = A.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_ARMURE
      CREATE OR REPLACE TRIGGER New_Armure_trigger
      INSTEAD OF INSERT ON V_ARMURE
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouvel item
        INSERT INTO ITEM(Nom, Description)
        VALUES (:NEW.Nom, :NEW.Description);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM ITEM;

        -- Nouvelle armure
        INSERT INTO ARMURE(Id, PointDeVieBase, ArmureBase)
        VALUES (New_Id, :NEW.PointDeVieBase, :NEW.ArmureBase);
      END;
      /

   -- Création du trigger INSTEAD OF UPDATE pour V_ARMURE
      CREATE OR REPLACE TRIGGER Update_Armure_trigger
      INSTEAD OF UPDATE ON V_ARMURE
      FOR EACH ROW
      BEGIN
        -- Mise à jour de l'item
        UPDATE ITEM
        SET Nom = :NEW.Nom,
            Description = :NEW.Description
        WHERE Id = :NEW.Id;

        -- Mise à jour de l'armure
        UPDATE ARMURE
        SET PointDeVieBase = :NEW.PointDeVieBase,
            ArmureBase = :NEW.ArmureBase
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_ARMURE
      CREATE OR REPLACE TRIGGER Delete_Armure_trigger
      INSTEAD OF DELETE ON V_ARMURE
      FOR EACH ROW
      BEGIN
        -- Suppression de l'armure
        DELETE FROM ARMURE
        WHERE Id = :OLD.Id;

        -- Suppression de l'item
        DELETE FROM ITEM
        WHERE Id = :OLD.Id;
      END;
      /

-- ARME
   CREATE TABLE ARME(
      Id NUMBER PRIMARY KEY,
      DegatsBase NUMBER(5) DEFAULT 100,
      CONSTRAINT fk_arme_item FOREIGN KEY (Id) REFERENCES ITEM (Id)
   );

   -- Création de la View pour ARME
      CREATE OR REPLACE VIEW V_ARME AS
        SELECT I.Id, I.Nom, I.Description, A.DegatsBase
        FROM ITEM I
        JOIN ARME A ON I.Id = A.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_ARME
      CREATE OR REPLACE TRIGGER New_Arme_trigger
      INSTEAD OF INSERT ON V_ARME
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouvel item
        INSERT INTO ITEM(Nom, Description)
        VALUES (:NEW.Nom, :NEW.Description);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM ITEM;

        -- Nouvelle arme
        INSERT INTO ARME(Id, DegatsBase)
        VALUES (New_Id, :NEW.DegatsBase);
      END;
      /
   
   -- Création du trigger INSTEAD OF UPDATE pour V_ARME
      CREATE OR REPLACE TRIGGER Update_Arme_trigger
      INSTEAD OF UPDATE ON V_ARME
      FOR EACH ROW
      BEGIN
        -- Mise à jour de l'item
        UPDATE ITEM
        SET Nom = :NEW.Nom,
            Description = :NEW.Description
        WHERE Id = :NEW.Id;

        -- Mise à jour de l'armure
        UPDATE ARME
        SET DegatsBase = :NEW.DegatsBase
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_ARME
      CREATE OR REPLACE TRIGGER Delete_Arme_trigger
      INSTEAD OF DELETE ON V_ARME
      FOR EACH ROW
      BEGIN
        -- Suppression de l'armure
        DELETE FROM ARME
        WHERE Id = :OLD.Id;

        -- Suppression de l'item
        DELETE FROM ITEM
        WHERE Id = :OLD.Id;
      END;
      /

-- ITEMQUETE
   CREATE TABLE ITEMQUETE(
      Id NUMBER PRIMARY KEY,
      CONSTRAINT fk_itemquete_item FOREIGN KEY (Id) REFERENCES ITEM (Id)
   );

   -- Création de la View pour ITEMQUETE
      CREATE OR REPLACE VIEW V_ITEMQUETE AS
        SELECT I.Id, I.Nom, I.Description
        FROM ITEM I
        JOIN ITEMQUETE IQ ON I.Id = IQ.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_ITEMQUETE
      CREATE OR REPLACE TRIGGER New_Itemquete_trigger
      INSTEAD OF INSERT ON V_ITEMQUETE
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouvel item
        INSERT INTO ITEM(Nom, Description)
        VALUES (:NEW.Nom, :NEW.Description);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM ITEM;

        -- Nouvelle itemquete
        INSERT INTO ITEMQUETE(Id)
        VALUES (New_Id);
      END;
      /
   
   -- Création du trigger INSTEAD OF UPDATE pour V_ITEMQUETE
      CREATE OR REPLACE TRIGGER Update_Itemquete_trigger
      INSTEAD OF UPDATE ON V_ITEMQUETE
      FOR EACH ROW
      BEGIN
        -- Mise à jour de l'item
        UPDATE ITEM
        SET Nom = :NEW.Nom,
            Description = :NEW.Description
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_ITEMQUETE
      CREATE OR REPLACE TRIGGER Delete_Itemquete_trigger
      INSTEAD OF DELETE ON V_ITEMQUETE
      FOR EACH ROW
      BEGIN
        -- Suppression de l'itemquete
        DELETE FROM ITEMQUETE
        WHERE Id = :OLD.Id;

        -- Suppression de l'item
        DELETE FROM ITEM
        WHERE Id = :OLD.Id;
      END;
      /

-- OUTIL
   CREATE TABLE OUTIL(
      Id NUMBER PRIMARY KEY,
      CONSTRAINT fk_outil_item FOREIGN KEY (Id) REFERENCES ITEM (Id)
   );

   -- Création de la View pour OUTIL
      CREATE OR REPLACE VIEW V_OUTIL AS
        SELECT I.Id, I.Nom, I.Description
        FROM ITEM I
        JOIN OUTIL O ON I.Id = O.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_OUTIL
      CREATE OR REPLACE TRIGGER New_Outil_trigger
      INSTEAD OF INSERT ON V_OUTIL
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouvel item
        INSERT INTO ITEM(Nom, Description)
        VALUES (:NEW.Nom, :NEW.Description);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM ITEM;

        -- Nouvelle outil
        INSERT INTO OUTIL(Id)
        VALUES (New_Id);
      END;
      /
   
   -- Création du trigger INSTEAD OF UPDATE pour V_OUTIL
      CREATE OR REPLACE TRIGGER Update_Outil_trigger
      INSTEAD OF UPDATE ON V_OUTIL
      FOR EACH ROW
      BEGIN
        -- Mise à jour de l'item
        UPDATE ITEM
        SET Nom = :NEW.Nom,
            Description = :NEW.Description
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_Outil
      CREATE OR REPLACE TRIGGER Delete_Outil_trigger
      INSTEAD OF DELETE ON V_OUTIL
      FOR EACH ROW
      BEGIN
        -- Suppression de l'armure
        DELETE FROM OUTIL
        WHERE Id = :OLD.Id;

        -- Suppression de l'item
        DELETE FROM ITEM
        WHERE Id = :OLD.Id;
      END;
      /

-- DIVERS
   CREATE TABLE DIVERS(
      Id NUMBER PRIMARY KEY,
      CONSTRAINT fk_divers_item FOREIGN KEY (Id) REFERENCES ITEM (Id)
   );

   -- Création de la View pour DIVERS
      CREATE OR REPLACE VIEW V_DIVERS AS
        SELECT I.Id, I.Nom, I.Description
        FROM ITEM I
        JOIN DIVERS D ON I.Id = D.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_DIVERS
      CREATE OR REPLACE TRIGGER New_Divers_trigger
      INSTEAD OF INSERT ON V_DIVERS
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouvel item
        INSERT INTO ITEM(Nom, Description)
        VALUES (:NEW.Nom, :NEW.Description);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM ITEM;

        -- Nouvelle divers
        INSERT INTO DIVERS(Id)
        VALUES (New_Id);
      END;
      /
   
   -- Création du trigger INSTEAD OF UPDATE pour V_DIVERS
      CREATE OR REPLACE TRIGGER Update_DIVERS_trigger
      INSTEAD OF UPDATE ON V_DIVERS
      FOR EACH ROW
      BEGIN
        -- Mise à jour de l'item
        UPDATE ITEM
        SET Nom = :NEW.Nom,
            Description = :NEW.Description
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_ARME
      CREATE OR REPLACE TRIGGER Delete_Divers_trigger
      INSTEAD OF DELETE ON V_DIVERS
      FOR EACH ROW
      BEGIN
        -- Suppression de l'armure
        DELETE FROM DIVERS
        WHERE Id = :OLD.Id;

        -- Suppression de l'item
        DELETE FROM ITEM
        WHERE Id = :OLD.Id;
      END;
      /

-- CONSOMMABLE
   CREATE TABLE CONSOMMABLE(
      Id NUMBER PRIMARY KEY,
      Effet VARCHAR(255),
      Id_Typeconsommable NUMBER(5),
      CONSTRAINT fk_consommable_divers FOREIGN KEY (Id) REFERENCES DIVERS(Id),
      CONSTRAINT fk_consommable_typecons FOREIGN KEY (Id_Typeconsommable) REFERENCES TYPECONSOMMABLE(Id)
   );

   -- Création de la View pour CONSOMMABLE
      CREATE OR REPLACE VIEW V_CONSOMMABLE AS
        SELECT I.Id, I.Nom, I.Description, C.Effet, C.Id_Typeconsommable
        FROM V_DIVERS I
        JOIN CONSOMMABLE C ON I.Id = C.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_CONSOMMABLE
      CREATE OR REPLACE TRIGGER New_Consommable_trigger
      INSTEAD OF INSERT ON V_CONSOMMABLE
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouvel Divers
        INSERT INTO V_DIVERS(Nom, Description)
        VALUES (:NEW.Nom, :NEW.Description);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM V_DIVERS;

        -- Nouvelle Consommable
        INSERT INTO CONSOMMABLE(Id, Effet, Id_Typeconsommable)
        VALUES (New_Id, :NEW.Effet, :NEW.Id_Typeconsommable);
      END;
      /
   
   -- Création du trigger INSTEAD OF UPDATE pour V_CONSOMMABLE
      CREATE OR REPLACE TRIGGER Update_Consommable_trigger
      INSTEAD OF UPDATE ON V_CONSOMMABLE
      FOR EACH ROW
      BEGIN
        -- Mise à jour du divers
        UPDATE V_DIVERS
        SET Nom = :NEW.Nom,
            Description = :NEW.Description
        WHERE Id = :NEW.Id;

        -- Mise à jour du consommable
        UPDATE CONSOMMABLE
        SET Effet = :NEW.Effet,
            Id_Typeconsommable = :NEW.Id_Typeconsommable
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_CONSOMMABLE
      CREATE OR REPLACE TRIGGER Delete_Consommable_trigger
      INSTEAD OF DELETE ON V_CONSOMMABLE
      FOR EACH ROW
      BEGIN
        -- Suppression du consommable
        DELETE FROM CONSOMMABLE
        WHERE Id = :OLD.Id;

        -- Suppression ddu divers
        DELETE FROM V_DIVERS
        WHERE Id = :OLD.Id;
      END;
      /

-- RESSOURCE
   CREATE TABLE RESSOURCE(
      Id NUMBER PRIMARY KEY,
      Id_Typeressource NUMBER(5),
      CONSTRAINT fk_ressource_divers FOREIGN KEY (Id) REFERENCES DIVERS(Id),
      CONSTRAINT fk_ressource_typeres FOREIGN KEY (Id_Typeressource) REFERENCES TYPERESSOURCE(Id)
   );

   -- Création de la View pour RESSOURCE
      CREATE OR REPLACE VIEW V_RESSOURCE AS
        SELECT I.Id, I.Nom, I.Description, R.Id_Typeressource
        FROM V_DIVERS I
        JOIN RESSOURCE R ON I.Id = R.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_RESSOURCE
      CREATE OR REPLACE TRIGGER New_Ressource_trigger
      INSTEAD OF INSERT ON V_RESSOURCE
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouvel Divers
        INSERT INTO V_DIVERS(Nom, Description)
        VALUES (:NEW.Nom, :NEW.Description);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM V_DIVERS;

        -- Nouvelle Ressource
        INSERT INTO RESSOURCE(Id, Id_Typeressource)
        VALUES (New_Id, :NEW.Id_Typeressource);
      END;
      /
   
   -- Création du trigger INSTEAD OF UPDATE pour V_RESSOURCE
      CREATE OR REPLACE TRIGGER Update_Ressource_trigger
      INSTEAD OF UPDATE ON V_RESSOURCE
      FOR EACH ROW
      BEGIN
        -- Mise à jour du divers
        UPDATE V_DIVERS
        SET Nom = :NEW.Nom,
            Description = :NEW.Description
        WHERE Id = :NEW.Id;

        -- Mise à jour de la ressource
        UPDATE RESSOURCE
        SET Id_Typeressource = :NEW.Id_Typeressource
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_RESSOURCE
      CREATE OR REPLACE TRIGGER Delete_Ressource_trigger
      INSTEAD OF DELETE ON V_RESSOURCE
      FOR EACH ROW
      BEGIN
        -- Suppression du consommable
        DELETE FROM RESSOURCE
        WHERE Id = :OLD.Id;

        -- Suppression ddu divers
        DELETE FROM V_DIVERS
        WHERE Id = :OLD.Id;
      END;
      /

-- TYPEARMURE
   -- Création de la séquence
   CREATE SEQUENCE TYPEARMURE_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE TYPEARMURE(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB
   );

   -- Création du trigger INSTEAD OF INSERT pour TYPEARMURE
   CREATE OR REPLACE TRIGGER New_Typearmure_trigger
   BEFORE INSERT ON TYPEARMURE
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := TYPEARMURE_seq.NEXTVAL;
   END;
   /

-- TYPEARME
   -- Création de la séquence
   CREATE SEQUENCE TYPEARME_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE TYPEARME(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB
   );

   -- Création du trigger INSTEAD OF INSERT pour TYPEARME
   CREATE OR REPLACE TRIGGER New_Typearme_trigger
   BEFORE INSERT ON TYPEARME
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := TYPEARME_seq.NEXTVAL;
   END;
   /

-- METIER
   -- Création de la séquence
   CREATE SEQUENCE METIER_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE METIER(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB
   );

   -- Création du trigger INSTEAD OF INSERT pour METIER
   CREATE OR REPLACE TRIGGER New_Metier_trigger
   BEFORE INSERT ON METIER
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := METIER_seq.NEXTVAL;
   END;
   /

-- RECETTE
   -- Création de la séquence
   CREATE SEQUENCE RECETTE_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE RECETTE(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB,
      IdItem NUMBER(5),
      CONSTRAINT fk_recette_item FOREIGN KEY (IdItem) REFERENCES ITEM(Id)
   );

   -- Création du trigger INSTEAD OF INSERT pour RECETTE
   CREATE OR REPLACE TRIGGER New_Recette_trigger
   BEFORE INSERT ON RECETTE
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := RECETTE_seq.NEXTVAL;
   END;
   /

-- TYPELIEUX
   -- Création de la séquence
   CREATE SEQUENCE TYPELIEUX_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE TYPELIEUX(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB
   );

   -- Création du trigger INSTEAD OF INSERT pour TYPELIEUX
   CREATE OR REPLACE TRIGGER New_Typelieux_trigger
   BEFORE INSERT ON TYPELIEUX
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := TYPELIEUX_seq.NEXTVAL;
   END;
   /

-- LIEUX
   -- Création de la séquence
   CREATE SEQUENCE LIEUX_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE LIEUX(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB,
      Id_TypeLieux NUMBER(5),
      CONSTRAINT fk_typelieux_lieux FOREIGN KEY (Id_TypeLieux) REFERENCES TYPELIEUX(Id)
   );

   -- Création du trigger INSTEAD OF INSERT pour LIEUX
   CREATE OR REPLACE TRIGGER New_Lieux_trigger
   BEFORE INSERT ON LIEUX
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := LIEUX_seq.NEXTVAL;
   END;
   /

-- TYPEQUETE
   -- Création de la séquence
   CREATE SEQUENCE TYPEQUETE_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE TYPEQUETE(
      Id NUMBER PRIMARY KEY,
      Description CLOB
   );

   -- Création du trigger INSTEAD OF INSERT pour TYPEQUETE
   CREATE OR REPLACE TRIGGER New_Typequete_trigger
   BEFORE INSERT ON TYPEQUETE
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := TYPEQUETE_seq.NEXTVAL;
   END;
   /

-- QUETE
   -- Création de la séquence
   CREATE SEQUENCE QUETE_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE QUETE(
      Id NUMBER PRIMARY KEY,
      Titre VARCHAR(255) NOT NULL,
      Description CLOB,
      NiveauRecommande NUMBER(5) DEFAULT 1,
      Statut VARCHAR(255) DEFAULT 'En cours',
      DateDebut DATE DEFAULT SYSDATE,
      DateFin DATE,
      Id_Typequete NUMBER(5),
      CONSTRAINT fk_typequete_quete FOREIGN KEY (Id_Typequete) REFERENCES TYPEQUETE(Id)
   );

   -- Création du trigger INSTEAD OF INSERT pour QUETE
   CREATE OR REPLACE TRIGGER New_Quete_trigger
   BEFORE INSERT ON QUETE
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := QUETE_seq.NEXTVAL;
   END;
   /

-- EVENEMENT
   -- Création de la séquence
   CREATE SEQUENCE EVENEMENT_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE EVENEMENT(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB,
      Duree NUMBER(5) DEFAULT 1
   );

   -- Création du trigger INSTEAD OF INSERT pour EVENEMENT
   CREATE OR REPLACE TRIGGER New_Evenement_trigger
   BEFORE INSERT ON EVENEMENT
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := EVENEMENT_seq.NEXTVAL;
   END;
   /

-- APPARENCE
   -- Création de la séquence
   CREATE SEQUENCE APPARENCE_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE APPARENCE(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB,
      Image VARCHAR(255)
   );

   -- Création du trigger INSTEAD OF INSERT pour APPARENCE
   CREATE OR REPLACE TRIGGER New_Apparence_trigger
   BEFORE INSERT ON APPARENCE
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := APPARENCE_seq.NEXTVAL;
   END;
   /

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
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE PERSONNAGE (
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Taille NUMBER(5) DEFAULT 180,
      Alignement VARCHAR(255),
      Description CLOB,
      DateCreation DATE DEFAULT SYSDATE,
      Nom_Classe VARCHAR(255) NOT NULL,
      Nom_Race VARCHAR(255) NOT NULL,
      Id_Lieux NUMBER(5) NOT NULL,
      CONSTRAINT fk_classe_personnage FOREIGN KEY(Nom_Classe) REFERENCES CLASSE(Nom),
      CONSTRAINT fk_race_personnage FOREIGN KEY(Nom_Race) REFERENCES RACE(Nom),
      CONSTRAINT fk_lieux_personnage FOREIGN KEY(Id_Lieux) REFERENCES LIEUX(Id),
      CONSTRAINT fk_calsserace_personnage FOREIGN KEY (Nom_Classe, Nom_Race) REFERENCES CLASSE_RACE (Nom_Classe, Nom_Race)
   );

   -- Création du trigger INSTEAD OF INSERT pour PERSONNAGE
   CREATE OR REPLACE TRIGGER New_Personnage_trigger
   BEFORE INSERT ON PERSONNAGE
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := PERSONNAGE_seq.NEXTVAL;
   END;
   /

-- PJ
   CREATE TABLE PJ (
      Id NUMBER PRIMARY KEY,
      Niveau NUMBER(5) DEFAULT 1,
      PointDeVie NUMBER(5) DEFAULT 1000,
      PointDeMana NUMBER(5) DEFAULT 1000,
      Experience NUMBER(5) DEFAULT 0,
      Gold NUMBER(5) DEFAULT 10,
      CONSTRAINT fk_personnage_pj FOREIGN KEY (Id) REFERENCES PERSONNAGE(Id)
   );

   -- Création de la View pour PJ
      CREATE OR REPLACE VIEW V_PJ AS
        SELECT P.Id, P.Nom, P.Taille, P.Alignement, P.Description, P.DateCreation, P.Nom_Classe, P.Nom_Race, P.Id_Lieux, PJ.Niveau, PJ.PointDeVie, PJ.PointDeMana, PJ.Experience, PJ.Gold
        FROM PERSONNAGE P
        JOIN PJ ON P.Id = PJ.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_PJ
      CREATE OR REPLACE TRIGGER New_PJ_trigger
      INSTEAD OF INSERT ON V_PJ
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouveau PERSONNAGE
        INSERT INTO PERSONNAGE(Nom, Taille, Alignement, Description, DateCreation, Nom_Classe, Nom_Race, Id_Lieux)
        VALUES (:NEW.Nom, :NEW.Taille, :NEW.Alignement, :NEW.Description, :NEW.DateCreation, :NEW.Nom_Classe, :NEW.Nom_Race, :NEW.Id_Lieux);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM PERSONNAGE;

        -- Nouveau PJ
        INSERT INTO PJ(Id, Niveau, PointDeVie, PointDeMana, Experience, Gold)
        VALUES (New_Id, :NEW.Niveau, :NEW.PointDeVie, :NEW.PointDeMana, :NEW.Experience, :NEW.Gold);
      END;
      /
   
   -- Création du trigger INSTEAD OF UPDATE pour V_PJ
      CREATE OR REPLACE TRIGGER Update_PJ_trigger
      INSTEAD OF UPDATE ON V_PJ
      FOR EACH ROW
      BEGIN
        -- Mise à jour du personnage
        UPDATE PERSONNAGE
        SET Nom = :NEW.Nom,
            Taille = :NEW.Taille,
            Alignement = :NEW.Alignement,
            Description = :NEW.Description,
            DateCreation = :NEW.DateCreation,
            Nom_Classe = :NEW.Nom_Classe,
            Nom_Race = :NEW.Nom_Race,
            Id_Lieux = :NEW.Id_Lieux
        WHERE Id = :NEW.Id;

        -- Mise à jour du PJ
        UPDATE PJ
        SET Niveau = :NEW.Niveau,
            PointDeVie = :NEW.PointDeVie,
            PointDeMana = :NEW.PointDeMana,
            Experience = :NEW.Experience,
            Gold = :NEW.Gold
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_PJ
      CREATE OR REPLACE TRIGGER Delete_PJ_trigger
      INSTEAD OF DELETE ON V_PJ
      FOR EACH ROW
      BEGIN
        -- Suppression du PJ
        DELETE FROM PJ
        WHERE Id = :OLD.Id;

        -- Suppression du personnage
        DELETE FROM PERSONNAGE
        WHERE Id = :OLD.Id;
      END;
      /

-- PNJ
   CREATE TABLE PNJ(
      Id NUMBER PRIMARY KEY,
      CONSTRAINT fk_personnage_pnj FOREIGN KEY (Id) REFERENCES PERSONNAGE(Id)
   );

   -- Création de la View pour PNJ
      CREATE OR REPLACE VIEW V_PNJ AS
        SELECT P.Id, P.Nom, P.Taille, P.Alignement, P.Description, P.DateCreation, P.Nom_Classe, P.Nom_Race, P.Id_Lieux
        FROM PERSONNAGE P
        JOIN PNJ ON P.Id = PNJ.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_PNJ
      CREATE OR REPLACE TRIGGER New_PNJ_trigger
      INSTEAD OF INSERT ON V_PNJ
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouveau PERSONNAGE
        INSERT INTO PERSONNAGE(Nom, Taille, Alignement, Description, DateCreation, Nom_Classe, Nom_Race, Id_Lieux)
        VALUES (:NEW.Nom, :NEW.Taille, :NEW.Alignement, :NEW.Description, :NEW.DateCreation, :NEW.Nom_Classe, :NEW.Nom_Race, :NEW.Id_Lieux);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM PERSONNAGE;

        -- Nouveau PNJ
        INSERT INTO PNJ(Id)
        VALUES (New_Id);
      END;
      /
   
   -- Création du trigger INSTEAD OF UPDATE pour V_PNJ
      CREATE OR REPLACE TRIGGER Update_PNJ_trigger
      INSTEAD OF UPDATE ON V_PNJ
      FOR EACH ROW
      BEGIN
        -- Mise à jour du personnage
        UPDATE PERSONNAGE
        SET Nom = :NEW.Nom,
            Taille = :NEW.Taille,
            Alignement = :NEW.Alignement,
            Description = :NEW.Description,
            DateCreation = :NEW.DateCreation,
            Nom_Classe = :NEW.Nom_Classe,
            Nom_Race = :NEW.Nom_Race,
            Id_Lieux = :NEW.Id_Lieux
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_PNJ
      CREATE OR REPLACE TRIGGER Delete_PNJ_trigger
      INSTEAD OF DELETE ON V_PNJ
      FOR EACH ROW
      BEGIN
        -- Suppression du PNJ
        DELETE FROM PNJ
        WHERE Id = :OLD.Id;

        -- Suppression du personnage
        DELETE FROM PERSONNAGE
        WHERE Id = :OLD.Id;
      END;
      /

-- ALLIE
   CREATE TABLE ALLIE(
      Id NUMBER PRIMARY KEY,
      CONSTRAINT fk_personnage_allie FOREIGN KEY (Id) REFERENCES PNJ(Id)
   );

   -- Création de la View pour ALLIE
      CREATE OR REPLACE VIEW V_ALLIE AS
        SELECT P.Id, P.Nom, P.Taille, P.Alignement, P.Description, P.DateCreation, P.Nom_Classe, P.Nom_Race, P.Id_Lieux
        FROM V_PNJ P
        JOIN ALLIE A ON P.Id = A.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_ALLIE
      CREATE OR REPLACE TRIGGER New_Allie_trigger
      INSTEAD OF INSERT ON V_ALLIE
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouveau PNJ
        INSERT INTO V_PNJ(Nom, Taille, Alignement, Description, DateCreation, Nom_Classe, Nom_Race, Id_Lieux)
        VALUES (:NEW.Nom, :NEW.Taille, :NEW.Alignement, :NEW.Description, :NEW.DateCreation, :NEW.Nom_Classe, :NEW.Nom_Race, :NEW.Id_Lieux);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM V_PNJ;

        -- Nouveau ALLIE
        INSERT INTO ALLIE(Id)
        VALUES (New_Id);
      END;
      /
   
   -- Création du trigger INSTEAD OF UPDATE pour V_ALLIE
      CREATE OR REPLACE TRIGGER Update_Allie_trigger
      INSTEAD OF UPDATE ON V_ALLIE
      FOR EACH ROW
      BEGIN
        -- Mise à jour du personnage
        UPDATE V_PNJ
        SET Nom = :NEW.Nom,
            Taille = :NEW.Taille,
            Alignement = :NEW.Alignement,
            Description = :NEW.Description,
            DateCreation = :NEW.DateCreation,
            Nom_Classe = :NEW.Nom_Classe,
            Nom_Race = :NEW.Nom_Race,
            Id_Lieux = :NEW.Id_Lieux
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_ALLIE
      CREATE OR REPLACE TRIGGER Delete_Allie_trigger
      INSTEAD OF DELETE ON V_ALLIE
      FOR EACH ROW
      BEGIN
        -- Suppression de l'allie
        DELETE FROM ALLIE
        WHERE Id = :OLD.Id;

        -- Suppression du pnj
        DELETE FROM V_PNJ
        WHERE Id = :OLD.Id;
      END;
      /

-- MONSTRE
   CREATE TABLE MONSTRE(
      Id NUMBER PRIMARY KEY,
      Niveau NUMBER(5) DEFAULT 1,
      PointDeVie NUMBER(5) DEFAULT 1000,
      PointDeMana NUMBER(5) DEFAULT 1000,
      Experience NUMBER(5) DEFAULT 0,
      Gold NUMBER(5) DEFAULT 0,
      EstBoss NUMBER(1) DEFAULT 0,
      CONSTRAINT fk_personnage_monstre FOREIGN KEY (Id) REFERENCES PNJ(Id)
   );

   -- Création de la View pour MONSTRE
      CREATE OR REPLACE VIEW V_MONSTRE AS
        SELECT P.Id, P.Nom, P.Taille, P.Alignement, P.Description, P.DateCreation, P.Nom_Classe, P.Nom_Race, P.Id_Lieux, M.Niveau, M.PointDeVie, M.PointDeMana, M.Experience, M.Gold, M.EstBoss
        FROM V_PNJ P
        JOIN MONSTRE M ON P.Id = M.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_MONSTRE
      CREATE OR REPLACE TRIGGER New_Monstre_trigger
      INSTEAD OF INSERT ON V_MONSTRE
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouveau PNJ
        INSERT INTO V_PNJ(Nom, Taille, Alignement, Description, DateCreation, Nom_Classe, Nom_Race, Id_Lieux)
        VALUES (:NEW.Nom, :NEW.Taille, :NEW.Alignement, :NEW.Description, :NEW.DateCreation, :NEW.Nom_Classe, :NEW.Nom_Race, :NEW.Id_Lieux);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM V_PNJ;

        -- Nouveau MONSTRE
        INSERT INTO MONSTRE(Id, Niveau, PointDeVie, PointDeMana, Experience, Gold, EstBoss)
        VALUES (New_Id, :NEW.Niveau, :NEW.PointDeVie, :NEW.PointDeMana, :NEW.Experience, :NEW.Gold, :NEW.EstBoss);
      END;
      /
   
   -- Création du trigger INSTEAD OF UPDATE pour V_MONSTRE
      CREATE OR REPLACE TRIGGER Update_Monstre_trigger
      INSTEAD OF UPDATE ON V_MONSTRE
      FOR EACH ROW
      BEGIN
        -- Mise à jour du pnj
        UPDATE V_PNJ
        SET Nom = :NEW.Nom,
            Taille = :NEW.Taille,
            Alignement = :NEW.Alignement,
            Description = :NEW.Description,
            DateCreation = :NEW.DateCreation,
            Nom_Classe = :NEW.Nom_Classe,
            Nom_Race = :NEW.Nom_Race,
            Id_Lieux = :NEW.Id_Lieux
        WHERE Id = :NEW.Id;

        -- Mise à jour du monstre
        UPDATE MONSTRE
        SET Niveau = :NEW.Niveau,
            PointDeVie = :NEW.PointDeVie,
            PointDeMana = :NEW.PointDeMana,
            Experience = :NEW.Experience,
            Gold = :NEW.Gold,
            EstBoss = :NEW.EstBoss
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_MONSTRE
      CREATE OR REPLACE TRIGGER Delete_Monstre_trigger
      INSTEAD OF DELETE ON V_MONSTRE
      FOR EACH ROW
      BEGIN
        -- Suppression du Monstre
        DELETE FROM MONSTRE
        WHERE Id = :OLD.Id;

        -- Suppression du PNJ
        DELETE FROM V_PNJ
        WHERE Id = :OLD.Id;
      END;
      /

-- SORT
   -- Création de la séquence
   CREATE SEQUENCE SORT_seq
     START WITH 1
     INCREMENT BY 1
     NOMAXVALUE
     CACHE 2;

   CREATE TABLE SORT(
      Id NUMBER PRIMARY KEY,
      Nom VARCHAR(255) NOT NULL,
      Description CLOB,
      Niveau NUMBER(5) DEFAULT 1,
      DegatsBase NUMBER(5) DEFAULT 100,
      Composantes VARCHAR(255),
      TempsIncantation NUMBER(5) DEFAULT 0,
      Portee NUMBER(5) DEFAULT 5,
      Nom_EcoleMagie VARCHAR(255) NOT NULL,
      CONSTRAINT fk_ecolemagie_sort FOREIGN KEY(Nom_EcoleMagie) REFERENCES ECOLEMAGIE(Nom)
   );

   -- Création du trigger INSTEAD OF INSERT pour SORT
   CREATE OR REPLACE TRIGGER New_Sort_trigger
   BEFORE INSERT ON SORT
   FOR EACH ROW
   BEGIN
     -- Utilisation de la séquence pour générer la valeur Id
     :NEW.Id := SORT_seq.NEXTVAL;
   END;
   /

-- BUFF
   CREATE TABLE BUFF(
      Id NUMBER PRIMARY KEY,
      CONSTRAINT fk_sort_buff FOREIGN KEY (Id) REFERENCES SORT(Id)
   );

   -- Création de la View pour BUFF
      CREATE OR REPLACE VIEW V_BUFF AS
        SELECT S.Id, S.Nom, S.Description, S.Niveau, S.DegatsBase, S.Composantes, S.TempsIncantation, S.Portee, S.Nom_EcoleMagie
        FROM SORT S
        JOIN BUFF B ON S.Id = B.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_BUFF
      CREATE OR REPLACE TRIGGER New_Buff_trigger
      INSTEAD OF INSERT ON V_BUFF
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouveau SORT
        INSERT INTO SORT(Id, Nom, Description, Niveau, DegatsBase, Composantes, TempsIncantation, Portee, Nom_EcoleMagie)
        VALUES (:NEW.Id, :NEW.Nom, :NEW.Description, :NEW.Niveau, :NEW.DegatsBase, :NEW.Composantes, :NEW.TempsIncantation, :NEW.Portee, :NEW.Nom_EcoleMagie);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM SORT;

        -- Nouveau BUFF
        INSERT INTO BUFF(Id)
        VALUES (New_Id);
      END;
      /
   
   -- Création du trigger INSTEAD OF UPDATE pour V_BUFF
      CREATE OR REPLACE TRIGGER Update_Buff_trigger
      INSTEAD OF UPDATE ON V_BUFF
      FOR EACH ROW
      BEGIN
        -- Mise à jour du SORT
        UPDATE SORT
        SET Nom = :NEW.Nom,
            Description = :NEW.Description,
            Niveau = :NEW.Niveau,
            DegatsBase = :NEW.DegatsBase,
            Composantes = :NEW.Composantes,
            TempsIncantation = :NEW.TempsIncantation,
            Portee = :NEW.Portee,
            Nom_EcoleMagie = :NEW.Nom_EcoleMagie
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_BUFF
      CREATE OR REPLACE TRIGGER Delete_Buff_trigger
      INSTEAD OF DELETE ON V_BUFF
      FOR EACH ROW
      BEGIN
        -- Suppression du Buff
        DELETE FROM BUFF
        WHERE Id = :OLD.Id;

        -- Suppression du Sort
        DELETE FROM SORT
        WHERE Id = :OLD.Id;
      END;
      /

-- POUVOIR
   CREATE TABLE POUVOIR(
      Id NUMBER PRIMARY KEY,
      CONSTRAINT fk_sort_pouvoir FOREIGN KEY (Id) REFERENCES SORT(Id)
   );

   -- Création de la View pour POUVOIR
      CREATE OR REPLACE VIEW V_POUVOIR AS
        SELECT S.Id, S.Nom, S.Description, S.Niveau, S.DegatsBase, S.Composantes, S.TempsIncantation, S.Portee, S.Nom_EcoleMagie
        FROM SORT S
        JOIN POUVOIR P ON S.Id = P.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_POUVOIR
      CREATE OR REPLACE TRIGGER New_Pouvoir_trigger
      INSTEAD OF INSERT ON V_POUVOIR
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouveau SORT
        INSERT INTO SORT(Id, Nom, Description, Niveau, DegatsBase, Composantes, TempsIncantation, Portee, Nom_EcoleMagie)
        VALUES (:NEW.Id, :NEW.Nom, :NEW.Description, :NEW.Niveau, :NEW.DegatsBase, :NEW.Composantes, :NEW.TempsIncantation, :NEW.Portee, :NEW.Nom_EcoleMagie);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM SORT;

        -- Nouveau POUVOIR
        INSERT INTO POUVOIR(Id)
        VALUES (New_Id);
      END;
      /
   
   -- Création du trigger INSTEAD OF UPDATE pour V_POUVOIR
      CREATE OR REPLACE TRIGGER Update_Pouvoir_trigger
      INSTEAD OF UPDATE ON V_POUVOIR
      FOR EACH ROW
      BEGIN
        -- Mise à jour du SORT
        UPDATE SORT
        SET Nom = :NEW.Nom,
            Description = :NEW.Description,
            Niveau = :NEW.Niveau,
            DegatsBase = :NEW.DegatsBase,
            Composantes = :NEW.Composantes,
            TempsIncantation = :NEW.TempsIncantation,
            Portee = :NEW.Portee,
            Nom_EcoleMagie = :NEW.Nom_EcoleMagie
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_POUVOIR
      CREATE OR REPLACE TRIGGER Delete_Pouvoir_trigger
      INSTEAD OF DELETE ON V_POUVOIR
      FOR EACH ROW
      BEGIN
        -- Suppression du POUVOIR
        DELETE FROM POUVOIR
        WHERE Id = :OLD.Id;

        -- Suppression du Sort
        DELETE FROM SORT
        WHERE Id = :OLD.Id;
      END;
      /

-- RACIAL
   CREATE TABLE RACIAL(
      Id NUMBER PRIMARY KEY,
      CONSTRAINT fk_sort_racial FOREIGN KEY (Id) REFERENCES SORT(Id)
   );

   -- Création de la View pour RACIAL
      CREATE OR REPLACE VIEW V_RACIAL AS
        SELECT S.Id, S.Nom, S.Description, S.Niveau, S.DegatsBase, S.Composantes, S.TempsIncantation, S.Portee, S.Nom_EcoleMagie
        FROM SORT S
        JOIN RACIAL R ON S.Id = R.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_RACIAL
      CREATE OR REPLACE TRIGGER New_Racial_trigger
      INSTEAD OF INSERT ON V_RACIAL
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouveau SORT
        INSERT INTO SORT(Id, Nom, Description, Niveau, DegatsBase, Composantes, TempsIncantation, Portee, Nom_EcoleMagie)
        VALUES (:NEW.Id, :NEW.Nom, :NEW.Description, :NEW.Niveau, :NEW.DegatsBase, :NEW.Composantes, :NEW.TempsIncantation, :NEW.Portee, :NEW.Nom_EcoleMagie);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM SORT;

        -- Nouveau RACIAL
        INSERT INTO RACIAL(Id)
        VALUES (New_Id);
      END;
      /
   
   -- Création du trigger INSTEAD OF UPDATE pour V_RACIAL
      CREATE OR REPLACE TRIGGER Update_Racial_trigger
      INSTEAD OF UPDATE ON V_RACIAL
      FOR EACH ROW
      BEGIN
        -- Mise à jour du SORT
        UPDATE SORT
        SET Nom = :NEW.Nom,
            Description = :NEW.Description,
            Niveau = :NEW.Niveau,
            DegatsBase = :NEW.DegatsBase,
            Composantes = :NEW.Composantes,
            TempsIncantation = :NEW.TempsIncantation,
            Portee = :NEW.Portee,
            Nom_EcoleMagie = :NEW.Nom_EcoleMagie
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_RACIAL
      CREATE OR REPLACE TRIGGER Delete_Racial_trigger
      INSTEAD OF DELETE ON V_RACIAL
      FOR EACH ROW
      BEGIN
        -- Suppression du RACIAL
        DELETE FROM RACIAL
        WHERE Id = :OLD.Id;

        -- Suppression du Sort
        DELETE FROM SORT
        WHERE Id = :OLD.Id;
      END;
      /

-- COMPETENCE
   CREATE TABLE COMPETENCE(
      Id NUMBER PRIMARY KEY,
      CONSTRAINT fk_sort_competence FOREIGN KEY (Id) REFERENCES SORT(Id)
   );

   -- Création de la View pour COMPETENCE
      CREATE OR REPLACE VIEW V_COMPETENCE AS
        SELECT S.Id, S.Nom, S.Description, S.Niveau, S.DegatsBase, S.Composantes, S.TempsIncantation, S.Portee, S.Nom_EcoleMagie
        FROM SORT S
        JOIN COMPETENCE C ON S.Id = C.Id;

   -- Création du trigger INSTEAD OF INSERT pour V_COMPETENCE
      CREATE OR REPLACE TRIGGER New_Competence_trigger
      INSTEAD OF INSERT ON V_COMPETENCE
      FOR EACH ROW
      DECLARE
        New_Id NUMBER;
      BEGIN
        -- Nouveau SORT
        INSERT INTO SORT(Id, Nom, Description, Niveau, DegatsBase, Composantes, TempsIncantation, Portee, Nom_EcoleMagie)
        VALUES (:NEW.Id, :NEW.Nom, :NEW.Description, :NEW.Niveau, :NEW.DegatsBase, :NEW.Composantes, :NEW.TempsIncantation, :NEW.Portee, :NEW.Nom_EcoleMagie);
  
        -- Récupérer l'ID généré
        SELECT MAX(Id) INTO New_Id FROM SORT;

        -- Nouveau COMPETENCE
        INSERT INTO COMPETENCE(Id)
        VALUES (New_Id);
      END;
      /
   
   -- Création du trigger INSTEAD OF UPDATE pour V_COMPETENCE
      CREATE OR REPLACE TRIGGER Update_Competence_trigger
      INSTEAD OF UPDATE ON V_COMPETENCE
      FOR EACH ROW
      BEGIN
        -- Mise à jour du SORT
        UPDATE SORT
        SET Nom = :NEW.Nom,
            Description = :NEW.Description,
            Niveau = :NEW.Niveau,
            DegatsBase = :NEW.DegatsBase,
            Composantes = :NEW.Composantes,
            TempsIncantation = :NEW.TempsIncantation,
            Portee = :NEW.Portee,
            Nom_EcoleMagie = :NEW.Nom_EcoleMagie
        WHERE Id = :NEW.Id;
      END;
      /

   -- Création du trigger INSTEAD OF DELETE pour V_COMPETENCE
      CREATE OR REPLACE TRIGGER Delete_Competence_trigger
      INSTEAD OF DELETE ON V_COMPETENCE
      FOR EACH ROW
      BEGIN
        -- Suppression du COMPETENCE
        DELETE FROM COMPETENCE
        WHERE Id = :OLD.Id;

        -- Suppression du Sort
        DELETE FROM SORT
        WHERE Id = :OLD.Id;
      END;
      /

-- FACTION_PERSONNAGE
   CREATE TABLE FACTION_PERSONNAGE(
      Id_Personnage NUMBER(5),
      Id_Faction NUMBER(5),
      Grade VARCHAR(255) DEFAULT 'Étranger',
      Reputation NUMBER(5) DEFAULT 0,
      PRIMARY KEY(Id_Personnage, Id_Faction),
      CONSTRAINT fk_personnage_fp FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_faction_fp FOREIGN KEY(Id_Faction) REFERENCES FACTION(Id)
   );

-- HAUTFAIT_PERSONNAGE
   CREATE TABLE HAUTFAIT_PERSONNAGE(
      Id_Personnage NUMBER(5),
      Id_HautFait NUMBER(5),
      PRIMARY KEY(Id_Personnage, Id_HautFait),
      CONSTRAINT fk_personnage_hp FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_hautfait_hp FOREIGN KEY(Id_HautFait) REFERENCES HAUTFAIT(Id)
   );

-- PERSONNAGE_TITRE
   CREATE TABLE PERSONNAGE_TITRE(
      Id_Personnage NUMBER(5),
      Id_Titre NUMBER(5),
      EstActif  NUMBER(1) DEFAULT 0,
      PRIMARY KEY(Id_Personnage, Id_Titre),
      CONSTRAINT fk_personnage_pt FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_titre_pt FOREIGN KEY(Id_Titre) REFERENCES TITRE(Id)
   );

-- LANGUE_PERSONNAGE
   CREATE TABLE LANGUE_PERSONNAGE(
      Id_Personnage NUMBER(5),
      Id_Langue NUMBER(5),
      PRIMARY KEY(Id_Personnage, Id_Langue),
      CONSTRAINT fk_personnage_lp FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_langue_lp FOREIGN KEY(Id_Langue) REFERENCES LANGUE(Id)
   );

-- LANGUE_RACE
   CREATE TABLE LANGUE_RACE(
      Nom_Race VARCHAR(255),
      Id_Langue NUMBER(5),
      PRIMARY KEY(Nom_Race, Id_Langue),
      CONSTRAINT fk_race_lr FOREIGN KEY(Nom_Race) REFERENCES RACE(Nom),
      CONSTRAINT fk_langue_lr FOREIGN KEY(Id_Langue) REFERENCES LANGUE(Id)
   );

-- MONSTRE_TYPEMONSTRE
   CREATE TABLE MONSTRE_TYPEMONSTRE(
      Id_Monstre NUMBER(5),
      Id_Typemonstre NUMBER(5),
      PRIMARY KEY(Id_Monstre, Id_Typemonstre),
      CONSTRAINT fk_monstre_mt FOREIGN KEY(Id_Monstre) REFERENCES MONSTRE(Id),
      CONSTRAINT fk_typemonstre_mt FOREIGN KEY(Id_Typemonstre) REFERENCES TYPEMONSTRE(Id)
   );

-- ARME_TYPEARME
   CREATE TABLE ARME_TYPEARME(
      Id_Arme NUMBER(5),
      Id_Typearme NUMBER(5),
      PRIMARY KEY(Id_Arme, Id_Typearme),
      CONSTRAINT fk_arme_at FOREIGN KEY(Id_Arme) REFERENCES ARME(Id),
      CONSTRAINT fk_typearme_at FOREIGN KEY(Id_Typearme) REFERENCES TYPEARME(Id)
   );

-- ARMURE_TYPEARMURE
   CREATE TABLE ARMURE_TYPEARMURE(
      Id_Armure NUMBER(5),
      Id_Typearmure NUMBER(5),
      PRIMARY KEY(Id_Armure, Id_Typearmure),
      CONSTRAINT fk_armure_at FOREIGN KEY(Id_Armure) REFERENCES ARMURE(Id),
      CONSTRAINT fk_typearmure_at FOREIGN KEY(Id_Typearmure) REFERENCES TYPEARMURE(Id)
   );

-- METIER_RECETTE
   CREATE TABLE METIER_RECETTE(
      Id_Metier NUMBER(5),
      Id_Recette NUMBER(5),
      NiveauRequis NUMBER(5) DEFAULT 1,
      PRIMARY KEY(Id_Metier, Id_Recette),
      CONSTRAINT fk_metier_mr FOREIGN KEY(Id_Metier) REFERENCES METIER(Id),
      CONSTRAINT fk_recette_mr FOREIGN KEY(Id_Recette) REFERENCES RECETTE(Id)
   );

-- METIER_OUTIL
   CREATE TABLE METIER_OUTIL(
      Id_Metier NUMBER(5),
      Id_Outil NUMBER(5),
      PRIMARY KEY(Id_Metier, Id_Outil),
      CONSTRAINT fk_metier_mo FOREIGN KEY(Id_Metier) REFERENCES METIER(Id),
      CONSTRAINT fk_outil_mo FOREIGN KEY(Id_Outil) REFERENCES OUTIL(Id)
   );

-- ITEM_RECETTE
   CREATE TABLE ITEM_RECETTE(
      Id_Item NUMBER(5),
      Id_Recette NUMBER(5),
      Quantite NUMBER(5) DEFAULT 1,
      PRIMARY KEY(Id_Item, Id_Recette),
      CONSTRAINT fk_item_item_recette FOREIGN KEY(Id_Item) REFERENCES ITEM(Id),
      CONSTRAINT fk_recette_item_recette FOREIGN KEY(Id_Recette) REFERENCES RECETTE(Id)
   );

-- CLASSE_TYPEARME
   CREATE TABLE CLASSE_TYPEARME(
      Nom_Classe VARCHAR(255),
      Id_Typearme NUMBER(5),
      PRIMARY KEY(Nom_Classe, Id_Typearme),
      CONSTRAINT fk_classe_classe_typearme FOREIGN KEY(Nom_Classe) REFERENCES CLASSE(Nom),
      CONSTRAINT fk_typearme_classe_typearme FOREIGN KEY(Id_Typearme) REFERENCES TYPEARME(Id)
   );

-- CLASSE_TYPEARMURE
   CREATE TABLE CLASSE_TYPEARMURE(
      Nom_Classe VARCHAR(255),
      Id_Typearmure NUMBER(5),
      PRIMARY KEY(Nom_Classe, Id_Typearmure),
      CONSTRAINT fk_classe_ct FOREIGN KEY(Nom_Classe) REFERENCES CLASSE(Nom),
      CONSTRAINT fk_typearmure_ct FOREIGN KEY(Id_Typearmure) REFERENCES TYPEARMURE(Id)
   );

-- CLASSE_COMPETENCE
   CREATE TABLE CLASSE_COMPETENCE(
      Id_Competence NUMBER(5),
      Nom_Classe VARCHAR(255),
      PRIMARY KEY(Id_Competence, Nom_Classe),
      CONSTRAINT fk_competence_cc FOREIGN KEY(Id_Competence) REFERENCES COMPETENCE(Id),
      CONSTRAINT fk_classe_cc FOREIGN KEY(Nom_Classe) REFERENCES CLASSE(Nom)
   );

-- RACE_RACIAL
   CREATE TABLE RACE_RACIAL(
      Id_Racial NUMBER(5),
      Nom_Race VARCHAR(255),
      PRIMARY KEY(Id_Racial, Nom_Race),
      CONSTRAINT fk_racial_race_racial FOREIGN KEY(Id_Racial) REFERENCES RACIAL(Id),
      CONSTRAINT fk_race_race_racial FOREIGN KEY(Nom_Race) REFERENCES RACE(Nom)
   );

-- COMBAT
   CREATE TABLE COMBAT(
      Id_PJ NUMBER(5),
      Id_Monstre NUMBER(5),
      Resultat VARCHAR(255) DEFAULT 'victoire',
      DateCombat DATE DEFAULT SYSDATE,
      PRIMARY KEY(Id_PJ, Id_Monstre, DateCombat),
      CONSTRAINT fk_pj_combat FOREIGN KEY(Id_PJ) REFERENCES PJ(Id),
      CONSTRAINT fk_monstre_combat FOREIGN KEY(Id_Monstre) REFERENCES MONSTRE(Id)
   );

-- METIER_PERSONNAGE
   CREATE TABLE METIER_PERSONNAGE(
      Id_Personnage NUMBER(5),
      Id_Metier NUMBER(5),
      Niveau NUMBER(5) DEFAULT 1,
      PRIMARY KEY(Id_Personnage, Id_Metier),
      CONSTRAINT fk_personnage_mp FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_metier_mp FOREIGN KEY(Id_Metier) REFERENCES METIER(Id)
   );

-- PERSONNAGE_RECETTE
   CREATE TABLE PERSONNAGE_RECETTE(
      Id_Personnage NUMBER(5),
      Id_Recette NUMBER(5),
      PRIMARY KEY(Id_Personnage, Id_Recette),
      CONSTRAINT fk_personnage_pr FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_recette_pr FOREIGN KEY(Id_Recette) REFERENCES RECETTE(Id)
   );

-- GRIMOIRE
   CREATE TABLE GRIMOIRE(
      Id_Personnage NUMBER(5),
      Id_Sort NUMBER(5),
      PRIMARY KEY(Id_Personnage, Id_Sort),
      CONSTRAINT fk_personnage_grimoire FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_sort_grimoire FOREIGN KEY(Id_Sort) REFERENCES SORT(Id)
   );

-- INVENTAIRE
   CREATE TABLE INVENTAIRE(
      Id_Personnage NUMBER(5),
      Id_Item NUMBER(5),
      PRIMARY KEY(Id_Personnage, Id_Item),
      CONSTRAINT fk_personnage_inventaire FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_item_inventaire FOREIGN KEY(Id_Item) REFERENCES ITEM(Id)
   );

-- EVENEMENT_MONSTRE
   CREATE TABLE EVENEMENT_MONSTRE(
      Id_Monstre NUMBER(5),
      Id_Evenement NUMBER(5),
      PRIMARY KEY(Id_Monstre, Id_Evenement),
      CONSTRAINT fk_monstre_evenement_monstre FOREIGN KEY(Id_Monstre) REFERENCES MONSTRE(Id),
      CONSTRAINT fk_evenement_evenement_monstre FOREIGN KEY(Id_Evenement) REFERENCES EVENEMENT(Id)
   );

-- EVENEMENT_ITEM
   CREATE TABLE EVENEMENT_ITEM(
      Id_Item NUMBER(5),
      Id_Evenement NUMBER(5),
      PRIMARY KEY(Id_Item, Id_Evenement),
      CONSTRAINT fk_item_evenement_item FOREIGN KEY(Id_Item) REFERENCES ITEM(Id),
      CONSTRAINT fk_evenement_evenement_item FOREIGN KEY(Id_Evenement) REFERENCES EVENEMENT(Id)
   );

-- CALENDRIER_EVENEMENT
   CREATE TABLE CALENDRIER_EVENEMENT(
      DateEvent DATE DEFAULT SYSDATE,
      Id NUMBER(5),
      PRIMARY KEY(DateEvent, Id),
      CONSTRAINT fk_evenement_ce FOREIGN KEY(Id) REFERENCES EVENEMENT(Id)
   );

-- SUITEQUETE
   CREATE TABLE SUITEQUETE(
      Id_Fils NUMBER(5),
      Id_Pere NUMBER(5),
      PRIMARY KEY(Id_Fils, Id_Pere),
      CONSTRAINT fk_quetefils_suitequete FOREIGN KEY(Id_Fils) REFERENCES QUETE(Id),
      CONSTRAINT fk_quetepere_suitequete FOREIGN KEY(Id_Pere) REFERENCES QUETE(Id)
   );

-- EVENEMENT_QUETE
   CREATE TABLE EVENEMENT_QUETE(
      Id_Quete NUMBER(5),
      Id_Evenement NUMBER(5),
      PRIMARY KEY(Id_Quete, Id_Evenement),
      CONSTRAINT fk_quete_evenement_quete FOREIGN KEY(Id_Quete) REFERENCES QUETE(Id),
      CONSTRAINT fk_evenement_evenement_quete FOREIGN KEY(Id_Evenement) REFERENCES EVENEMENT(Id)
   );

-- BUFF_PERSONNAGE
   CREATE TABLE BUFF_PERSONNAGE(
      Id_Personnage NUMBER(5),
      Id_Buff NUMBER(5),
      Duree NUMBER(5) DEFAULT 60,
      PRIMARY KEY(Id_Personnage, Id_Buff),
      CONSTRAINT fk_personnage_buff_personnage FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_buff_buff_personnage FOREIGN KEY(Id_Buff) REFERENCES BUFF(Id)
   );

-- PERSONNAGE_QUETE
   CREATE TABLE PERSONNAGE_QUETE(
      Id_Personnage NUMBER(5),
      Id_Quete NUMBER(5),
      Statut VARCHAR(255) DEFAULT 'En Cours',
      DateDebut DATE DEFAULT SYSDATE,
      DateFin DATE,
      PRIMARY KEY(Id_Personnage, Id_Quete),
      CONSTRAINT fk_personnage_personnage_quete FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_quete_personnage_quete FOREIGN KEY(Id_Quete) REFERENCES QUETE(Id)
   );

-- PERSONNAGE_QUETEJOURNALIERE
   CREATE TABLE PERSONNAGE_QUETEJOURNALIERE(
      Id_Personnage NUMBER(5),
      Id_Quete NUMBER(5),
      Code_Jour DATE DEFAULT SYSDATE,
      Statut VARCHAR(255) DEFAULT 'En Cours',
      DateDebut DATE DEFAULT SYSDATE,
      DateFin DATE,
      PRIMARY KEY(Id_Personnage, Id_Quete, Code_Jour),
      CONSTRAINT fk_personnage_pqj FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_quetejournaliere_pqj FOREIGN KEY(Id_Quete) REFERENCES QUETE(Id)
   );

-- METIER_TYPERESSOURCE
   CREATE TABLE METIER_TYPERESSOURCE(
      Id_Typeressource NUMBER(5),
      Id_Metier NUMBER(5),
      PRIMARY KEY(Id_Typeressource, Id_Metier),
      CONSTRAINT fk_ressource_metier_ressource FOREIGN KEY(Id_Typeressource) REFERENCES TYPERESSOURCE(Id),
      CONSTRAINT fk_metier_metier_ressource FOREIGN KEY(Id_Metier) REFERENCES METIER(Id)
   );

-- ITEMQUETE_QUETE
   CREATE TABLE ITEMQUETE_QUETE(
      Id_Item NUMBER(5),
      Id_Quete NUMBER(5),
      PRIMARY KEY(Id_Item, Id_Quete),
      CONSTRAINT fk_itemquete_itemquete_quete FOREIGN KEY(Id_Item) REFERENCES ITEMQUETE(Id),
      CONSTRAINT fk_quete_itemquete_quete FOREIGN KEY(Id_Quete) REFERENCES QUETE(Id)
   );

-- APPARENCEPOSSIBLE_FACTION
   CREATE TABLE APPARENCEPOSSIBLE_FACTION(
      Id_Faction NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Faction, Id_Apparence),
      CONSTRAINT fk_faction_apf FOREIGN KEY(Id_Faction) REFERENCES FACTION(Id),
      CONSTRAINT fk_apparence_apf FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_FACTION
   CREATE TABLE APPARENCE_FACTION(
      Id_Faction NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Faction, Id_Apparence),
      CONSTRAINT fk_faction_af FOREIGN KEY(Id_Faction) REFERENCES FACTION(Id),
      CONSTRAINT fk_apparence_af FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_good_af FOREIGN KEY (Id_Apparence, Id_Faction) REFERENCES APPARENCEPOSSIBLE_FACTION(Id_Apparence, Id_Faction)
   );

-- APPARENCEPOSSIBLE_HAUTFAIT
   CREATE TABLE APPARENCEPOSSIBLE_HAUTFAIT(
      Id_Hautfait NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Hautfait, Id_Apparence),
      CONSTRAINT fk_hautfait_aph FOREIGN KEY(Id_Hautfait) REFERENCES HAUTFAIT(Id),
      CONSTRAINT fk_apparence_aph FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_HAUTFAIT
   CREATE TABLE APPARENCE_HAUTFAIT(
      Id_Hautfait NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Hautfait, Id_Apparence),
      CONSTRAINT fk_hautfait_ah FOREIGN KEY(Id_Hautfait) REFERENCES HAUTFAIT(Id),
      CONSTRAINT fk_apparence_ah FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_good_ah FOREIGN KEY (Id_Apparence, Id_Hautfait) REFERENCES APPARENCEPOSSIBLE_HAUTFAIT(Id_Apparence, Id_Hautfait)
   );

-- APPARENCEPOSSIBLE_TITRE
   CREATE TABLE APPARENCEPOSSIBLE_TITRE(
      Id_Titre NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Titre, Id_Apparence),
      CONSTRAINT fk_titre_apt FOREIGN KEY(Id_Titre) REFERENCES TITRE(Id),
      CONSTRAINT fk_apparence_apt FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_TITRE
   CREATE TABLE APPARENCE_TITRE(
      Id_Titre NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Titre, Id_Apparence),
      CONSTRAINT fk_titre_at FOREIGN KEY(Id_Titre) REFERENCES TITRE(Id),
      CONSTRAINT fk_apparence_at FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodat FOREIGN KEY (Id_Apparence, Id_Titre) REFERENCES APPARENCEPOSSIBLE_TITRE(Id_Apparence, Id_Titre)
   );

-- APPARENCEPOSSIBLE_PERSONNAGE
   CREATE TABLE APPARENCEPOSSIBLE_PERSONNAGE(
      Id_Personnage NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Personnage, Id_Apparence),
      CONSTRAINT fk_personnage_app FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_apparence_app FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_PERSONNAGE
   CREATE TABLE APPARENCE_PERSONNAGE(
      Id_Personnage NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Personnage, Id_Apparence),
      CONSTRAINT fk_personnage_ap FOREIGN KEY(Id_Personnage) REFERENCES PERSONNAGE(Id),
      CONSTRAINT fk_apparence_ap FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodap FOREIGN KEY (Id_Apparence, Id_Personnage) REFERENCES APPARENCEPOSSIBLE_PERSONNAGE(Id_Apparence, Id_Personnage)
   );

-- APPARENCEPOSSIBLE_RACE
   CREATE TABLE APPARENCEPOSSIBLE_RACE(
      Nom_Race VARCHAR(255),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Nom_Race, Id_Apparence),
      CONSTRAINT fk_race_apr FOREIGN KEY(Nom_Race) REFERENCES RACE(Nom),
      CONSTRAINT fk_apparence_apr FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_RACE
   CREATE TABLE APPARENCE_RACE(
      Nom_Race VARCHAR(255),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Nom_Race, Id_Apparence),
      CONSTRAINT fk_race_ar FOREIGN KEY(Nom_Race) REFERENCES RACE(Nom),
      CONSTRAINT fk_apparence_ar FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodar FOREIGN KEY (Id_Apparence, Nom_Race) REFERENCES APPARENCEPOSSIBLE_RACE(Id_Apparence, Nom_Race)
   );

-- APPARENCEPOSSIBLE_CLASSE
   CREATE TABLE APPARENCEPOSSIBLE_CLASSE(
      Nom_Classe VARCHAR(255),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Nom_Classe, Id_Apparence),
      CONSTRAINT fk_classe_apc FOREIGN KEY(Nom_Classe) REFERENCES CLASSE(Nom),
      CONSTRAINT fk_apparence_apc FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_CLASSE
   CREATE TABLE APPARENCE_CLASSE(
      Nom_Classe VARCHAR(255),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Nom_Classe, Id_Apparence),
      CONSTRAINT fk_classe_ac FOREIGN KEY(Nom_Classe) REFERENCES CLASSE(Nom),
      CONSTRAINT fk_apparence_ac FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodac FOREIGN KEY (Id_Apparence, Nom_Classe) REFERENCES APPARENCEPOSSIBLE_CLASSE(Id_Apparence, Nom_Classe)
   );

-- APPARENCEPOSSIBLE_SORT
   CREATE TABLE APPARENCEPOSSIBLE_SORT(
      Id_Sort NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Sort, Id_Apparence),
      CONSTRAINT fk_sort_aps FOREIGN KEY(Id_Sort) REFERENCES SORT(Id),
      CONSTRAINT fk_apparence_aps FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_SORT
   CREATE TABLE APPARENCE_SORT(
      Id_Sort NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Sort, Id_Apparence),
      CONSTRAINT fk_sort_as FOREIGN KEY(Id_Sort) REFERENCES SORT(Id),
      CONSTRAINT fk_apparence_as FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodas FOREIGN KEY (Id_Apparence, Id_Sort) REFERENCES APPARENCEPOSSIBLE_SORT(Id_Apparence, Id_Sort)
   );

-- APPARENCEPOSSIBLE_METIER
   CREATE TABLE APPARENCEPOSSIBLE_METIER(
      Id_Metier NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Metier, Id_Apparence),
      CONSTRAINT fk_metier_apm FOREIGN KEY(Id_Metier) REFERENCES METIER(Id),
      CONSTRAINT fk_apparence_apm FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_METIER
   CREATE TABLE APPARENCE_METIER(
      Id_Metier NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Metier, Id_Apparence),
      CONSTRAINT fk_metier_am FOREIGN KEY(Id_Metier) REFERENCES METIER(Id),
      CONSTRAINT fk_apparence_am FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodam FOREIGN KEY (Id_Apparence, Id_Metier) REFERENCES APPARENCEPOSSIBLE_METIER(Id_Apparence, Id_Metier)
   );

-- APPARENCEPOSSIBLE_ITEM
   CREATE TABLE APPARENCEPOSSIBLE_ITEM(
      Id_Item NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Item, Id_Apparence),
      CONSTRAINT fk_item_api FOREIGN KEY(Id_Item) REFERENCES ITEM(Id),
      CONSTRAINT fk_apparence_api FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_ITEM
   CREATE TABLE APPARENCE_ITEM(
      Id_Item NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Item, Id_Apparence),
      CONSTRAINT fk_item_ai FOREIGN KEY(Id_Item) REFERENCES ITEM(Id),
      CONSTRAINT fk_apparence_ai FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodai FOREIGN KEY (Id_Apparence, Id_Item) REFERENCES APPARENCEPOSSIBLE_ITEM(Id_Apparence, Id_Item)
   );

-- APPARENCEPOSSIBLE_EVENEMENT
   CREATE TABLE APPARENCEPOSSIBLE_EVENEMENT(
      Id_Evenement NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Evenement, Id_Apparence),
      CONSTRAINT fk_evenement_ape FOREIGN KEY(Id_Evenement) REFERENCES EVENEMENT(Id),
      CONSTRAINT fk_apparence_ape FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_EVENEMENT
   CREATE TABLE APPARENCE_EVENEMENT(
      Id_Evenement NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Evenement, Id_Apparence),
      CONSTRAINT fk_evenement_ae FOREIGN KEY(Id_Evenement) REFERENCES EVENEMENT(Id),
      CONSTRAINT fk_apparence_ae FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodae FOREIGN KEY (Id_Apparence, Id_Evenement) REFERENCES APPARENCEPOSSIBLE_EVENEMENT(Id_Apparence, Id_Evenement)
   );

-- APPARENCEPOSSIBLE_QUETE
   CREATE TABLE APPARENCEPOSSIBLE_QUETE(
      Id_Quete NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Quete, Id_Apparence),
      CONSTRAINT fk_quete_apq FOREIGN KEY(Id_Quete) REFERENCES QUETE(Id),
      CONSTRAINT fk_apparence_apq FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_QUETE
   CREATE TABLE APPARENCE_QUETE(
      Id_Quete NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Quete, Id_Apparence),
      CONSTRAINT fk_quete_aq FOREIGN KEY(Id_Quete) REFERENCES QUETE(Id),
      CONSTRAINT fk_apparence_aq FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodaq FOREIGN KEY (Id_Apparence, Id_Quete) REFERENCES APPARENCEPOSSIBLE_QUETE(Id_Apparence, Id_Quete)
   );

-- APPARENCEPOSSIBLE_LIEUX
   CREATE TABLE APPARENCEPOSSIBLE_LIEUX(
      Id_Lieux NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Lieux, Id_Apparence),
      CONSTRAINT fk_lieux_apl FOREIGN KEY(Id_Lieux) REFERENCES LIEUX(Id),
      CONSTRAINT fk_apparence_apl FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id)
   );

-- APPARENCE_LIEUX
   CREATE TABLE APPARENCE_LIEUX(
      Id_Lieux NUMBER(5),
      Id_Apparence NUMBER(5),
      PRIMARY KEY(Id_Lieux, Id_Apparence),
      CONSTRAINT fk_lieux_al FOREIGN KEY(Id_Lieux) REFERENCES LIEUX(Id),
      CONSTRAINT fk_apparence_al FOREIGN KEY(Id_Apparence) REFERENCES APPARENCE(Id),
      CONSTRAINT fk_goodal FOREIGN KEY (Id_Apparence, Id_Lieux) REFERENCES APPARENCEPOSSIBLE_LIEUX(Id_Apparence, Id_Lieux)
   );
