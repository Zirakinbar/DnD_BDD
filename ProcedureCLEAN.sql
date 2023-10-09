CREATE OR REPLACE PROCEDURE CleanAll(p_force IN BOOLEAN DEFAULT FALSE) AS
BEGIN
   -- Supprimer les déclencheurs
   FOR tr IN (SELECT trigger_name FROM user_triggers) LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP TRIGGER ' || tr.trigger_name;
         DBMS_OUTPUT.PUT_LINE('Déclencheur supprimé : ' || tr.trigger_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur lors de la suppression du déclencheur : ' || tr.trigger_name || ', erreur : ' || SQLERRM);
      END;
   END LOOP;

   -- Supprimer les vues
   FOR v IN (SELECT view_name FROM user_views) LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP VIEW ' || v.view_name;
         DBMS_OUTPUT.PUT_LINE('Vue supprimée : ' || v.view_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur lors de la suppression de la vue : ' || v.view_name || ', erreur : ' || SQLERRM);
      END;
   END LOOP;

   -- Supprimer les procédures stockées sauf elle-même
   FOR p IN (SELECT object_name FROM user_procedures WHERE object_name != 'CleanAll') LOOP
      BEGIN
         IF p_force THEN
            -- Supprimer en mode forcé
            EXECUTE IMMEDIATE 'DROP PROCEDURE ' || p.object_name || ' FORCE';
            DBMS_OUTPUT.PUT_LINE('Procédure supprimée (forcée) : ' || p.object_name);
         ELSE
            -- Supprimer normalement
            EXECUTE IMMEDIATE 'DROP PROCEDURE ' || p.object_name;
            DBMS_OUTPUT.PUT_LINE('Procédure supprimée : ' || p.object_name);
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur lors de la suppression de la procédure : ' || p.object_name || ', erreur : ' || SQLERRM);
      END;
   END LOOP;

   -- Supprimer les tables avec CASCADE CONSTRAINTS
   FOR t IN (SELECT table_name FROM user_tables) LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS';
         DBMS_OUTPUT.PUT_LINE('Table supprimée : ' || t.table_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur lors de la suppression de la table : ' || t.table_name || ', erreur : ' || SQLERRM);
      END;
   END LOOP;

   -- Supprimer les séquences
   FOR s IN (SELECT sequence_name FROM user_sequences) LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.sequence_name;
         DBMS_OUTPUT.PUT_LINE('Séquence supprimée : ' || s.sequence_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur lors de la suppression de la séquence : ' || s.sequence_name || ', erreur : ' || SQLERRM);
      END;
   END LOOP;

   COMMIT;
END;







-- cleanALLExceptProc
create or replace PROCEDURE CleanAll(p_force IN BOOLEAN DEFAULT TRUE) AS
BEGIN
   -- Supprimer les déclencheurs
   FOR tr IN (SELECT trigger_name FROM user_triggers) LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP TRIGGER ' || tr.trigger_name;
         DBMS_OUTPUT.PUT_LINE('Déclencheur supprimé : ' || tr.trigger_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur lors de la suppression du déclencheur : ' || tr.trigger_name || ', erreur : ' || SQLERRM);
      END;
   END LOOP;

   -- Supprimer les vues
   FOR v IN (SELECT view_name FROM user_views) LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP VIEW ' || v.view_name;
         DBMS_OUTPUT.PUT_LINE('Vue supprimée : ' || v.view_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur lors de la suppression de la vue : ' || v.view_name || ', erreur : ' || SQLERRM);
      END;
   END LOOP;

   -- Supprimer les tables avec CASCADE CONSTRAINTS
   FOR t IN (SELECT table_name FROM user_tables) LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS';
         DBMS_OUTPUT.PUT_LINE('Table supprimée : ' || t.table_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur lors de la suppression de la table : ' || t.table_name || ', erreur : ' || SQLERRM);
      END;
   END LOOP;

   -- Supprimer les séquences
   FOR s IN (SELECT sequence_name FROM user_sequences) LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.sequence_name;
         DBMS_OUTPUT.PUT_LINE('Séquence supprimée : ' || s.sequence_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur lors de la suppression de la séquence : ' || s.sequence_name || ', erreur : ' || SQLERRM);
      END;
   END LOOP;

   COMMIT;
END;





-- ResetTablesAndSequences
CREATE OR REPLACE PROCEDURE ResetTablesAndSequences AS
BEGIN
   -- Désactiver les contraintes de clé étrangère
   FOR fk IN (SELECT constraint_name FROM user_constraints WHERE constraint_type = 'R') LOOP
      BEGIN
         EXECUTE IMMEDIATE 'ALTER TABLE ' || fk.constraint_name || ' DISABLE CONSTRAINT ' || fk.constraint_name;
         DBMS_OUTPUT.PUT_LINE('Contrainte désactivée : ' || fk.constraint_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur lors de la désactivation de la contrainte : ' || fk.constraint_name || ', erreur : ' || SQLERRM);
      END;
   END LOOP;

   -- Vider les tables
   FOR t IN (SELECT table_name FROM user_tables) LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DELETE FROM ' || t.table_name;
         DBMS_OUTPUT.PUT_LINE('Table vidée : ' || t.table_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur lors de la suppression des données de la table : ' || t.table_name || ', erreur : ' || SQLERRM);
      END;
   END LOOP;

   -- Réinitialiser les séquences
   FOR s IN (SELECT sequence_name FROM user_sequences) LOOP
      BEGIN
         EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || s.sequence_name || ' RESTART';
         DBMS_OUTPUT.PUT_LINE('Séquence réinitialisée : ' || s.sequence_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur lors de la réinitialisation de la séquence : ' || s.sequence_name || ', erreur : ' || SQLERRM);
      END;
   END LOOP;

   -- Activer à nouveau les contraintes de clé étrangère
   FOR fk IN (SELECT constraint_name FROM user_constraints WHERE constraint_type = 'R') LOOP
      BEGIN
         EXECUTE IMMEDIATE 'ALTER TABLE ' || fk.constraint_name || ' ENABLE CONSTRAINT ' || fk.constraint_name;
         DBMS_OUTPUT.PUT_LINE('Contrainte activée : ' || fk.constraint_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur lors de l''activation de la contrainte : ' || fk.constraint_name || ', erreur : ' || SQLERRM);
      END;
   END LOOP;

   COMMIT;
END;
