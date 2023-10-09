# DnD
## Nom du Projet : "En recherche"

## Description du Projet :

"En recherche" est un jeu d'aventure unique qui vous transporte dans un monde fantastique rempli de mystères et de découvertes. Imaginez-vous plongé(e) dans un livre interactif où vous êtes le héros. Tout se passe par le biais de simples textes que vous pouvez explorer à l'aide de commandes simples, comme si vous lisiez un livre dont vous êtes le personnage principal.

L'univers n'a pas encore de nom, certain s'entendent à dire qu'au vu des conflits entre les peuples chacun veux donner un nom différent à ce monde. D'autre dise que le créateur manque juste d'imagination pour trouver un nom correct et prononcable par le commun des mortels.

## Caractéristiques Principales :

### Un Monde Vivant :
Explorez un univers en constante évolution où les saisons changent, les villes grandissent, et vos choix ont un impact sur le monde qui vous entoure.

### Une Aventure Épique :
Plongez dans une histoire palpitante remplie de quêtes, de secrets et de personnages fascinants. Vos décisions influenceront le cours de l'histoire.

### Créez Votre Héros :
Personnalisez votre propre personnage en choisissant sa race, sa classe et son apparence. Devenez un mage puissant, un guerrier courageux ou un voleur rusé, c'est vous qui décidez.

### Interaction Simple :
Vous n'avez besoin que de quelques commandes textuelles pour naviguer, interagir avec des personnages, résoudre des énigmes, combattre des monstres et explorer ce monde fantastique.

### Le Pouvoir des Procédures :
Tout, des déplacements aux combats, est géré de manière transparente grâce à des procédures spéciales qui rendent l'expérience fluide et immersive.

"Les Chroniques de l'Éther" est bien plus qu'un simple jeu textuel, c'est une aventure interactive où votre imagination est la seule limite. Préparez-vous à vivre une expérience captivante où chaque choix compte, chaque aventure est unique et chaque recoin du monde recèle un nouveau mystère à découvrir.





## Techniquement : 
Projet de Base de Données pour un Jeu de Rôle (RPG)
Ce projet de base de données a été conçu pour gérer efficacement les données d'un jeu de rôle (RPG) fictif. La base de données comprend des tables pour stocker des informations sur les types de monstres, les écoles de magie, les classes de personnages, les races, les factions, les hauts faits, les titres, les langues, les types de ressources, les types de consommables, les objets, les armures, les armes, les outils, les objets divers, les objets consommables, les ressources, les types d'armures, les types d'armes, les métiers, les recettes de fabrication d'objets, les types de lieux, les lieux, les types de quêtes, les quêtes et les événements ainsi que les apparences.

Cette base de données RPG est conçue pour soutenir les opérations liées à la gestion d'un monde virtuel de jeu de rôle. Voici comment utiliser chaque composant de la base de données :


Types de Monstres (TYPEMONSTRE)
    • Cette table stocke les types de monstres, tels que "Gobelins", "Dragons", etc.

Écoles de Magie (ECOLEMAGIE)
    • Stocke des informations sur les écoles de magie comme "Magie des éléments" ou "Magie noire".

Classes de Personnages (CLASSE)
    • Permet de définir les classes de personnages jouables, comme "Guerrier", "Mage", etc.

Races de Personnages (RACE)
    • Contient des informations sur les différentes races de personnages, telles que "Humains", "Elfes", etc.

Factions (FACTION)
    • Cette table permet de gérer les factions présentes dans le monde du jeu.

Hauts Faits (HAUTFAIT)
    • Stocke les hauts faits que les joueurs peuvent accomplir en jeu.

Titres (TITRE)
    • Gère les titres que les personnages peuvent obtenir et afficher.

Langues (LANGUE)
    • Stocke les langues qui existent dans le monde du jeu.

Types de Ressources (TYPERESSOURCE)
    • Permet de définir les différents types de ressources, comme "Minerais", "Plantes", etc.

Types de Consommables (TYPECONSOMMABLE)
    • Contient les types de consommables, tels que "Potions", "Nourriture", etc.

Objets (ITEM)
    • Table principale pour stocker tous les objets du jeu, y compris les armures, les armes, les outils, etc.

Armures (ARMURE) et Armes (ARME)
    • Stockent des informations spécifiques sur les armures et les armes, telles que les points de vie de base, les dégâts de base, etc.

Objets de Quête (ITEMQUETE), Outils (OUTIL) et Objets Divers (DIVERS)
    • Ces tables gèrent respectivement les objets liés à des quêtes, les outils et les objets divers.

Objets Consommables (CONSOMMABLE)
    • Stocke des informations sur les objets consommables, y compris leurs effets et leurs types.

Ressources (RESSOURCE)
    • Contient des informations sur les ressources disponibles dans le jeu, liées aux objets de fabrication.

Types d'Armures (TYPEARMURE) et Types d'Armes (TYPEARME)
    • Gèrent les différents types d'armures et d'armes.

Métiers (METIER) et Recettes de Fabrication (RECETTE)
    • Ces tables permettent de gérer les métiers et les recettes de fabrication d'objets.

Types de Lieux (TYPELIEUX)
    • Stocke les catégories de lieux dans le monde du jeu.

Lieux (LIEUX)
    • Contient des informations détaillées sur les lieux spécifiques, y compris leur type.

Types de Quêtes (TYPEQUETE)
    • Cette table gère les catégories de quêtes dans le jeu.

Quêtes (QUETE) et Événements (EVENEMENT)
    • Gèrent les quêtes et les événements spécifiques du jeu, avec des informations telles que le titre, la description, les dates, etc.

## MCD :
![Image du MCD Complet de la BDD DnD](https://myoctocat.com/assets/images/base-octocat.svg)

Avec cette base de données, vous pouvez gérer de manière centralisée toutes les données nécessaires pour créer et jouer à votre jeu de rôle. Vous pouvez insérer, mettre à jour et interroger les informations pour créer des aventures passionnantes et des expériences de jeu immersives pour vos joueurs.
## Liste des tables : 
-- TYPEMONSTRE
-- ECOLEMAGIE
-- CLASSE
-- RACE 
-- FACTION
-- HAUTFAIT
-- TITRE
-- LANGUE
-- TYPERESSOURCE
-- TYPECONSOMMABLE
-- ITEM
-- ARMURE
-- ARME
-- ITEMQUETE
-- OUTIL
-- DIVERS
-- CONSOMMABLE
-- RESSOURCE
-- TYPEARMURE
-- TYPEARME
-- METIER
-- RECETTE
-- TYPELIEUX
-- LIEUX
-- TYPEQUETE
-- QUETE
-- EVENEMENT
-- APPARENCE
-- CLASSE_RACE
-- PERSONNAGE
-- PJ
-- PNJ
-- ALLIE
-- MONSTRE
-- SORT
-- BUFF
-- POUVOIR
-- RACIAL
-- COMPETENCE
-- FACTION_PERSONNAGE
-- HAUTFAIT_PERSONNAGE
-- PERSONNAGE_TITRE
-- LANGUE_PERSONNAGE
-- LANGUE_RACE
-- MONSTRE_TYPEMONSTRE
-- ARME_TYPEARME
-- ARMURE_TYPEARMURE
-- METIER_RECETTE
-- METIER_OUTIL
-- ITEM_RECETTE
-- CLASSE_TYPEARME
-- CLASSE_TYPEARMURE
-- CLASSE_COMPETENCE
-- RACE_RACIAL
-- COMBAT
-- METIER_PERSONNAGE
-- PERSONNAGE_RECETTE
-- GRIMOIRE
-- INVENTAIRE
-- EVENEMENT_MONSTRE
-- EVENEMENT_ITEM
-- CALENDRIER_EVENEMENT
-- SUITEQUETE
-- EVENEMENT_QUETE
-- BUFF_PERSONNAGE
-- PERSONNAGE_QUETE
-- PERSONNAGE_QUETEJOURNALIERE
-- METIER_TYPERESSOURCE
-- ITEMQUETE_QUETE
-- APPARENCEPOSSIBLE_FACTION
-- APPARENCE_FACTION
-- APPARENCEPOSSIBLE_HAUTFAIT
-- APPARENCE_HAUTFAIT
-- APPARENCEPOSSIBLE_TITRE
-- APPARENCE_TITRE
-- APPARENCEPOSSIBLE_PERSONNAGE
-- APPARENCE_PERSONNAGE
-- APPARENCEPOSSIBLE_RACE
-- APPARENCE_RACE
-- APPARENCEPOSSIBLE_CLASSE
-- APPARENCE_CLASSE
-- APPARENCEPOSSIBLE_SORT
-- APPARENCE_SORT
-- APPARENCEPOSSIBLE_METIER
-- APPARENCE_METIER
-- APPARENCEPOSSIBLE_ITEM
-- APPARENCE_ITEM
-- APPARENCEPOSSIBLE_EVENEMENT
-- APPARENCE_EVENEMENT
-- APPARENCEPOSSIBLE_QUETE
-- APPARENCE_QUETE
-- APPARENCEPOSSIBLE_LIEUX
-- APPARENCE_LIEUX





## CONSTRAINT majeures : 
contrainte sur la classe PERSONNAGE -> la paire Nom_Race et Nom_Classe DOIVENT être présente dans la table de liaison CLASSE_RACE
contrainte sur les classe APPARENCE_ -> L'Id_APPARENCE DOIT être présent dans la table de liaison homonyme APPARENCEPOSSIBLE_



Vous pouvez trouver le MCD de la BDD sur le github : "DnD.png"! C'est un beau dessin digne d'être imprimé sur poster (surtout si on veux pouvoir lire quelque chose.)


# liste des views et procédures à venir:
## Vues (Views) :
	Vue des Informations du Personnage (Character Information View) :
		Cette vue pourrait regrouper toutes les informations essentielles d'un personnage, telles que son nom, sa classe, sa race, ses statistiques, son équipement, etc.

	Vue de l'équipement du Personnage (Stuff Information View) :
		Permet de consulter l'équipement du personnage, couplée a une procédure de gestion de l'équipement pour les changement.

	Vue des Quêtes Disponibles (Available Quests View) :
		Affiche la liste des quêtes actuellement disponibles pour le joueur, en fonction de son niveau, de sa faction, etc.

	Vue de l'Inventaire (Inventory View) :
		Regroupe tous les objets et équipements détenus par le personnage, avec des détails sur chaque objet.

	Vue de l'État de la Santé (Health Status View) :
		Affiche l'état de santé actuel du personnage, y compris les points de vie, les points de mana, etc.

	Vue des Hauts Faits Accomplis (Achievements View) :
		Montre les hauts faits accomplis par le personnage et ses récompenses associées.

	Vue des Quêtes Accomplies (Completed Quests View) :
		Liste les quêtes que le personnage a déjà terminées, avec des détails sur les récompenses obtenues.

	Vue des Monstres Rencontrés (Encountered Monsters View) :
		Montre la liste des monstres que le personnage a rencontrés au cours de son aventure, avec des statistiques.

	Vue des Magasins (Shops View) :
		Affiche la liste des objets disponibles à l'achat dans les différents magasins du jeu.

	Vue de la Carte du Monde (World Map View) :
		Permet au joueur de visualiser la carte du monde, les lieux découverts et les chemins disponibles.

	Vue des Statistiques du Personnage (Character Stats View) :
		Affiche les statistiques actuelles du personnage, telles que la santé, la force, l'intelligence, etc.

	Vue des Quêtes Actives (Active Quests View) :
		Montre les quêtes actuellement en cours, leurs objectifs et leurs états.

	Vue des Dialogues (Dialogue View) :
		Affiche les dialogues entre le personnage et les PNJ, permettant au joueur de choisir les réponses.

	Vue des Alliés et des Suiveurs (Allies and Followers View) :
		Montre les personnages alliés ou les créatures qui suivent le personnage.

	Vue des Informations sur le Monde (World Information View) :
		Affiche des informations sur les factions, l'histoire du monde, les cultures, etc.

	Vue des Statuts et des Malus (Status and Debuffs View) :
		Affiche les statuts actuels du personnage, comme empoisonné, paralysé, etc.

	Vue des Hauts Faits (Achievements View) :
		Montre les réalisations accomplies par le personnage au fil du jeu.

	Vue des Compétences et des Capacités (Skills and Abilities View) :
		Affiche les compétences et les capacités du personnage, avec leurs descriptions.

	Vue de l'Historique des Actions (Action History View) :
		Permet de revoir les actions récentes du personnage et les événements importants.

	Vue des Ressources Naturelles (Natural Resources View) :
		Affiche les ressources naturelles collectées, telles que les plantes, les minéraux, etc.

	Vue des Liens Sociaux (Social Links View) :
		Montre les relations du personnage avec d'autres PNJ et leur évolution.

	Vue des Statistiques Mondiales (World Statistics View) :
		Affiche des statistiques globales sur le monde du jeu, comme la population, le commerce, etc.

## Procédures Stockées :

	Procédure de Création de Personnage (Character Creation Procedure) :
		Permet au joueur de créer un nouveau personnage en choisissant sa classe, sa race, son nom, etc.

	Procédure de Déplacement du Personnage (Move Character Procedure) :
		Gère le déplacement du personnage d'une carte à une autre, en vérifiant les collisions, les transitions, etc.

	Procédure de gestion de l'équipement (Stuff Change Procedure) :
		Permet au personnage de changer son équipement.

	Procédure de Début de Quête (Start Quest Procedure) :
		Démarre une nouvelle quête pour le personnage, mettant à jour la base de données en conséquence.

	Procédure de Fin de Quête (Complete Quest Procedure) :
		Marque une quête comme terminée lorsque le joueur l'a accomplie avec succès, avec mise à jour des récompenses et des progrès.

	Procédure d'Attaque (Attack Procedure) :
		Gère les mécanismes de combat, y compris le calcul des dégâts, la mise à jour de la santé, etc.

	Procédure d'Intéraction avec un PNJ (NPC Interaction Procedure) :
		Gère les interactions avec les personnages non-joueurs (PNJ), y compris les dialogues, les quêtes, etc.

	Procédure de Gestion de l'Inventaire (Inventory Management Procedure) :
		Permet au joueur d'équiper, déséquiper, jeter, ou utiliser des objets de son inventaire.

	Procédure de Niveau Suivant (Level Up Procedure) :
		Gère la montée de niveau du personnage en mettant à jour ses statistiques et en débloquant de nouvelles capacités.

	Procédure de Gestion de l'Équipement (Equipment Management Procedure) :
		Gère l'équipement du personnage, y compris l'ajout, la suppression et les améliorations d'objets.

	Procédure de Gestion des Conversations (Conversation Management Procedure) :
		Gère les dialogues et les interactions avec les PNJ dans le jeu.

	Procédure de Gestion des Événements (Event Management Procedure) :
		Gère les événements spéciaux du jeu, tels que les rencontres aléatoires, les pièges, etc.

	Procédure de Gestion des Statistiques (Statistics Management Procedure) :
		Met à jour et calcule les statistiques du personnage en fonction de ses actions et de son équipement.

	Procédure de Gestion des Magasins (Shop Management Procedure) :
		Gère l'achat et la vente d'objets dans les magasins du jeu, avec mise à jour de l'inventaire.

	Procédure de Gestion des Effets (Effect Management Procedure) :
		Gère les effets temporaires sur le personnage, tels que les buffs, les débuffs, les empoisonnements, etc.

	Procédure de Gestion des Quêtes Secondaires (Side Quest Management Procedure) :
		Gère les quêtes secondaires et leurs interactions avec la quête principale.

	Procédure de Gestion des Options (Options Management Procedure) :
		Permet au joueur de régler les options de jeu, telles que le volume sonore, la langue, etc.

	Procédure de Gestion des Événements de Jeu (Game Event Management Procedure) :
		Gère les événements spécifiques au jeu, tels que les déclencheurs d'histoire, les changements de météo, etc.

	Procédure de Gestion de la Mort du Personnage (Character Death Management Procedure) :
		Gère les conséquences de la mort du personnage, telles que la réapparition, la perte d'objets, etc.

	Procédure de Gestion du Loot (Loot Management Procedure) :
		Gère les récompenses et le butin que le joueur peut obtenir après avoir vaincu des ennemis ou accompli des quêtes.

	Procédure de Sauvegarde (Save Game Procedure) :
		Enregistre l'état actuel du jeu, y compris les informations du personnage, les quêtes en cours, etc.

	Procédure de Gestion des Compétences (Skill Management Procedure) :
		Gère l'attribution, la mise à niveau et l'utilisation des compétences spéciales du personnage.

	Procédure de Gestion des Factions (Faction Management Procedure) :
		Gère les relations du personnage avec différentes factions ou groupes dans le jeu.

	Procédure de Gestion de l'Énergie/Vitalité (Energy/Vitality Management Procedure) :
		Gère la vitalité ou l'énergie du personnage, nécessaire pour certaines actions ou compétences.

	Procédure de Gestion de l'Économie (Economy Management Procedure) :
		Gère l'économie du jeu, y compris les prix des objets, les taux de change, etc.

	Procédure de Gestion des Effets Climatiques (Weather Effects Procedure) :
		Gère les effets météorologiques dans le jeu, affectant la visibilité, les déplacements, etc.

	Procédure de Gestion des Métiers :
		Ensemble de procédures à déterminer

	Procédure de Gestion des Compagnons (Companion Management Procedure) :
		Gère les personnages compagnons qui peuvent rejoindre le personnage principal.

	Procédure de Gestion des Énigmes (Puzzle Management Procedure) :
		Gère les énigmes et les casse-tête que le joueur doit résoudre pour progresser.

	Procédure de Gestion des Effets Sonores (Sound Effects Management Procedure) :
		Gère la lecture d'effets sonores pour améliorer l'immersion du joueur.

	Procédure de Gestion des Notifications (Notification Management Procedure) :
		Envoie des notifications au joueur pour des événements importants ou des rappels.

	Procédure de Gestion des Événements en Temps Réel (Real-Time Event Management Procedure) :
		Gère les événements en temps réel, tels que le passage du jour à la nuit, les cycles de marée, etc.

	Procédure de Gestion des Améliorations d'Équipement (Equipment Upgrades Procedure) :
		Permet au joueur d'améliorer les objets existants avec des enchantements ou des améliorations.

	Procédure de Gestion des Capacités Magiques (Magic Ability Management Procedure) :
		Gère l'acquisition, l'apprentissage et l'utilisation de sorts ou de capacités magiques.

	Procédure de Gestion de la Diplomatie (Diplomacy Management Procedure) :
		Gère les interactions diplomatiques avec d'autres personnages ou factions.

	Procédure de Gestion des Transitions de Scène (Scene Transition Procedure) :
		Gère les transitions fluides entre différentes scènes ou zones du jeu.

	Procédure de Gestion des Événements Spéciaux (Special Event Management Procedure) :
		Gère des événements spéciaux uniques dans le jeu, comme des fêtes ou des célébrations.

	Procédure de Gestion des Combats de Boss (Boss Battle Procedure) :
		Gère les combats de boss épiques, avec des mécanismes de combat spéciaux.

	Procédure de Gestion des Conséquences Morales (Morality Consequence Procedure) :
		Suit les choix moraux du joueur et affecte le déroulement de l'histoire.

	Procédure de Gestion des Secrets et des Découvertes (Secrets and Discoveries Procedure) :
		Gère la révélation de secrets ou de découvertes cachées dans le jeu.

	Procédure de Gestion des Rangs et des Réputations (Rank and Reputation Management Procedure) :
		Suit le rang et la réputation du personnage auprès des diverses factions et influences l'interaction avec elles.

	Procédure de Gestion de l'Horloge du Jeu (Game Clock Management Procedure) :
		Gère le passage du temps dans le jeu, influençant les événements et les opportunités.

	Procédure de Gestion des Livres et des Tomes (Book and Tome Management Procedure) :
		Permet aux joueurs de lire des livres et des tomes pour en apprendre davantage sur l'histoire du monde du jeu.

	Procédure de Gestion des Malédictions (Curse Management Procedure) :
		Gère les malédictions qui peuvent affecter le personnage et nécessitent des quêtes pour être levées.

	Procédure de Gestion des Rêves et des Visions (Dream and Vision Management Procedure) :
		Introduit des éléments narratifs via des rêves et des visions du personnage.

	Procédure de Gestion des Blessures et de la Guérison (Injury and Healing Procedure) :
		Gère les blessures subies par le personnage et les méthodes de guérison disponibles.

	Procédure de Gestion des Collections (Collection Management Procedure) :
		Permet au joueur de collectionner des objets rares ou précieux.

	Procédure de Gestion de la Faune et de la Flore (Flora and Fauna Management Procedure) :
		Gère la variété des créatures et des plantes que le joueur peut rencontrer.

	Procédure de Gestion de l'Exploration (Exploration Management Procedure) :
		Encourage et récompense l'exploration du monde du jeu.

	Procédure de Gestion des Histoires Secondaires (Side Story Management Procedure) :
		Crée des histoires secondaires indépendantes pour les joueurs à découvrir.

	Procédure de Gestion de la Magie Noire (Dark Magic Management Procedure) :
		Traite de la magie noire et de ses conséquences potentielles.

	Procédure de Gestion des Changements de Saison (Season Change Procedure) :
		Modifie les conditions météorologiques, les ressources et les défis en fonction des saisons.

	Procédure de Gestion des Alliances et des Trahisons (Alliance and Betrayal Procedure) :
		Gère les alliances qui peuvent être forgées ou brisées avec d'autres personnages ou factions.

	Procédure de Gestion de la Technologie (Technology Management Procedure) :
		Introduit des éléments technologiques dans un monde fantastique, le cas échéant.

	Procédure de Gestion de la Corruption (Corruption Management Procedure) :
		Traite des effets de la corruption sur le monde et le personnage.

	Procédure de Gestion des Rituels (Ritual Management Procedure) :
		Permet au joueur de participer à des rituels magiques ou religieux.

	Procédure de Gestion des Catastrophes Naturelles (Natural Disaster Management Procedure) :
		Introduit des catastrophes naturelles comme les tremblements de terre, les tempêtes, etc.

	Procédure de Gestion des Divinités (Deity Management Procedure) :
		Gère les relations du personnage avec les dieux ou les divinités du monde du jeu.

	Procédure de Gestion des Croyances et de la Religion (Belief and Religion Management Procedure) :
		Traite de la croyance religieuse du personnage et de ses interactions avec les cultes.

	Procédure de Gestion des Révélations et des Mystères (Revelation and Mystery Management Procedure) :
		Gère les révélations et les mystères clés de l'histoire du jeu.

	Procédure de Gestion des relations entre Joueurs et/ou PNJ : 
		Gère les niveau de relation (amitié/amour) inter-personnage.





...
# Et plein d'autre encore!

## Existant : 
-- Script de création de la Base de Données
-- Scripr d'enregistrement de données dans la base (en deux épisodes)

# BASE ORACLE ! Portage sur PostgreSQL, MongoDB, et SQLServer a venir apres création des views et procédures.
