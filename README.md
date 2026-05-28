Vite & Gourmand

Application web de commande de menus traiteur pour l'entreprise Vite & Gourmand, basée à Bordeaux.
Elle permet aux clients de consulter et commander des menus en ligne.


Prérequis:
- PHP 8.x
- Composer 2.x
- MySQL 8.x
- Symfony CLI
- Git


Installation:

1 Cloner le projet
git clone git@github.com:QuentinHannappe/vite-et-gourmand.git
cd vite-et-gourmand


2 Installer les dépendances
Le dossier vendor/ qui contient toutes les librairies Symfony n'est pas sur GitHub, la commande si dessous le recréer depuis le fichier composer.json :

composer install


3 Configurer l'environnement
Créer un fichier .env.local à la racine du projet avec ce contenu :

APP_ENV=dev
APP_SECRET=changeme
DATABASE_URL="mysql://root:VOTRE_MOT_DE_PASSE@127.0.0.1:3306/vite_et_gourmand?serverVersion=9.6.0&charset=utf8mb4"
MAILER_DSN="smtp://VOTRE_NOM_UTILISATEUR:VOTRE_MOT_DE_PASSE@sandbox.smtp.mailtrap.io:2525"
MESSENGER_TRANSPORT_DSN=doctrine://default?auto_setup=0

Ce projet utilise MySQL. Assurez vous que MySQL est installé et lancé sur votre machine. Remplacez "VOTRE_MOT_DE_PASSE" par votre mot de passe MySQL (si vous n'en avez pas, laissez vide : mysql://root:@127.0.0.1:3306/)
L'utilisateur par défaut est root dans l'adresse mysql, changez le si votre configuration est différente.

Ce projet utilise Mailtrap pour intercepter les emails en développement.
Créez un compte gratuit sur [mailtrap.io](https://mailtrap.io)
Allez dans Testing, Sandbox, Integration, choisissez Symfony
Copiez votre MAILER_DSN et remplacez la ligne correspondante dans le fichier .env.local


4 Créer la base de données
Créez une base de données MySQL nommée vite_et_gourmand depuis le terminal :

mysql -u root -p
CREATE DATABASE vite_et_gourmand;

si votre nom d'utilisateur MySQL n'est pas root, remplacez root par votre nom d'utilisateur.

Puis importez le fichier SQL fourni dans le dossier database/ :

mysql -u root -p vite_et_gourmand < database/vite_et_gourmand.sql

Ce fichier contient toute la structure des tables ainsi que les données de test (menus, plats, thèmes, régimes, allergènes et un compte administrateur).


5 Lancer le serveur

symfony serve -d

L'application est accessible sur http://127.0.0.1:8000


Identifiants de test:

Administrateur: jose@admin.fr , Mot de passe: Admin@jose
Employé: employe@test.fr , Mot de passe: employe
Utilisateur: client@test.fr , Mot de passe: client


Technologies utilisées
- Symfony 7 — Framework PHP back-end
- MySQL — Base de données relationnelle
- Bootstrap 5 — Framework CSS front-end
- EasyAdmin — Interface d'administration CRUD
- Symfony Mailer — Envoi d'emails automatiques
- Mailtrap — Interception des emails en développement
- Symfonycasts Reset Password Bundle — Réinitialisation de mot de passe