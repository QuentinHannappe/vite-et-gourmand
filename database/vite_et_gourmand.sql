-- Vite & Gourmand : creation de la base et jeu de donnees

CREATE DATABASE vite_et_gourmand
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE vite_et_gourmand;

-- Tables sans cle etrangere

CREATE TABLE user (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    email      VARCHAR(180) NOT NULL,
    roles      JSON         NOT NULL,
    password   VARCHAR(255) NOT NULL,
    nom        VARCHAR(100) NOT NULL,
    prenom     VARCHAR(100) NOT NULL,
    telephone  VARCHAR(20)  NOT NULL,
    adresse    VARCHAR(255) NOT NULL,
    ville      VARCHAR(100) NOT NULL,
    pays       VARCHAR(100) NOT NULL,
    is_active  TINYINT(1)   NOT NULL DEFAULT 1,
    CONSTRAINT uq_user_email UNIQUE (email)
);

CREATE TABLE theme (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    libelle     VARCHAR(50) NOT NULL,
    description LONGTEXT    NOT NULL
);

CREATE TABLE regime (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    libelle     VARCHAR(50) NOT NULL,
    description LONGTEXT    NOT NULL
);

CREATE TABLE allergenes (
    id      INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);

CREATE TABLE plat (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    titre       VARCHAR(150) NOT NULL,
    description LONGTEXT     NOT NULL,
    type        VARCHAR(20)  NOT NULL,
    photo       VARCHAR(255) NOT NULL
);

CREATE TABLE horaire (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    jour            VARCHAR(20) NOT NULL,
    heure_ouverture VARCHAR(5)  NOT NULL,
    heure_fermeture VARCHAR(5)  NOT NULL
);

-- Tables avec cles etrangeres

CREATE TABLE menu (
    id                INT AUTO_INCREMENT PRIMARY KEY,
    titre             VARCHAR(150) NOT NULL,
    description       LONGTEXT     NOT NULL,
    personnes_min     INT          NOT NULL,
    prix_par_personne DOUBLE       NOT NULL,
    quantite_restante INT          NOT NULL,
    conditions        LONGTEXT     NOT NULL,
    theme_id          INT          NOT NULL,
    CONSTRAINT fk_menu_theme
        FOREIGN KEY (theme_id) REFERENCES theme (id)
);

CREATE TABLE image (
    id      INT AUTO_INCREMENT PRIMARY KEY,
    chemin  VARCHAR(255) NOT NULL,
    menu_id INT          NOT NULL,
    CONSTRAINT fk_image_menu
        FOREIGN KEY (menu_id) REFERENCES menu (id)
        ON DELETE CASCADE
);

CREATE TABLE commandes (
    id                   INT AUTO_INCREMENT PRIMARY KEY,
    numero_commande      VARCHAR(50)  NOT NULL,
    date_commande        DATETIME     NOT NULL,
    date_presta          DATE         NOT NULL,
    heure_livraison      VARCHAR(5)   NOT NULL,
    adresse_livraison    VARCHAR(255) NOT NULL,
    prix_menu            DOUBLE       NOT NULL,
    nombre_personnes     INT          NOT NULL,
    prix_livraison       DOUBLE       NOT NULL,
    statut               VARCHAR(50)  NOT NULL DEFAULT 'en attente',
    pret_materiel        TINYINT(1)   NOT NULL DEFAULT 0,
    restitution_materiel TINYINT(1)   NOT NULL DEFAULT 0,
    users_id             INT          NOT NULL,
    menu_id              INT          NOT NULL,
    CONSTRAINT uq_commandes_numero UNIQUE (numero_commande),
    CONSTRAINT fk_commandes_user
        FOREIGN KEY (users_id) REFERENCES user (id),
    CONSTRAINT fk_commandes_menu
        FOREIGN KEY (menu_id)  REFERENCES menu (id)
);

CREATE TABLE avis (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    note        INT         NOT NULL,
    commentaire LONGTEXT    NOT NULL,
    statut      VARCHAR(50) NOT NULL DEFAULT 'en attente',
    commande_id INT         NOT NULL,
    CONSTRAINT uq_avis_commande UNIQUE (commande_id),
    CONSTRAINT fk_avis_commande
        FOREIGN KEY (commande_id) REFERENCES commandes (id)
);

CREATE TABLE reset_password_request (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    selector     VARCHAR(20)  NOT NULL,
    hashed_token VARCHAR(100) NOT NULL,
    requested_at DATETIME     NOT NULL,
    expires_at   DATETIME     NOT NULL,
    user_id      INT          NOT NULL,
    CONSTRAINT fk_reset_user
        FOREIGN KEY (user_id) REFERENCES user (id)
        ON DELETE CASCADE
);

-- Tables de jointure

CREATE TABLE menu_plat (
    menu_id INT NOT NULL,
    plat_id INT NOT NULL,
    PRIMARY KEY (menu_id, plat_id),
    CONSTRAINT fk_menu_plat_menu
        FOREIGN KEY (menu_id) REFERENCES menu (id) ON DELETE CASCADE,
    CONSTRAINT fk_menu_plat_plat
        FOREIGN KEY (plat_id) REFERENCES plat (id) ON DELETE CASCADE
);

CREATE TABLE menu_regime (
    menu_id   INT NOT NULL,
    regime_id INT NOT NULL,
    PRIMARY KEY (menu_id, regime_id),
    CONSTRAINT fk_menu_regime_menu
        FOREIGN KEY (menu_id)   REFERENCES menu (id)   ON DELETE CASCADE,
    CONSTRAINT fk_menu_regime_regime
        FOREIGN KEY (regime_id) REFERENCES regime (id) ON DELETE CASCADE
);

CREATE TABLE plat_allergenes (
    plat_id       INT NOT NULL,
    allergenes_id INT NOT NULL,
    PRIMARY KEY (plat_id, allergenes_id),
    CONSTRAINT fk_plat_allergenes_plat
        FOREIGN KEY (plat_id)       REFERENCES plat (id)       ON DELETE CASCADE,
    CONSTRAINT fk_plat_allergenes_allergene
        FOREIGN KEY (allergenes_id) REFERENCES allergenes (id) ON DELETE CASCADE
);
-- Jeu de donnees
--
-- Les identifiants sont indiques explicitement pour que les cles etrangeres
-- restent coherentes entre les tables.
-- Les mots de passe sont des hachages bcrypt, jamais du texte en clair.
-- Les coordonnees personnelles ont ete remplacees par des valeurs de test.

INSERT INTO user (id, email, roles, password, nom, prenom, telephone, adresse, ville, pays, is_active) VALUES
(1, 'jose@admin.fr',               '["ROLE_ADMIN"]',   '$2y$13$W5MXilPiWUofmobB/0g/0enhlWVMrilEkl77PCiW6PFwUuw.nwRue', 'proprietaire', 'jose',   '0600000000', '1 rue de la paix', 'bordeaux', 'france', 1),
(3, 'client1@test.fr',             '["ROLE_USER"]',    '$2y$13$N4an3QNov77NdPiV2jcY1uPXT48N9zrzlWPTLUXKN0.q5hvl1YaBq', 'MARTIN',       'Claire', '0600000001', '541 route de la tour', 'SCIEZ',   'France', 1),
(4, 'client2@test.fr',             '["ROLE_USER"]',    '$2y$13$PNtGsdbWwjM.Zi2KpqVYBeDK0WKl1eKFiBKYTjpKxyFOClKj0Kvae', 'DURAND',       'Paul',   '0600000002', '541 route de la tour', 'SCIEZ',   'France', 1),
(5, 'client3@test.fr',             '["ROLE_USER"]',    '$2y$13$8f19u9KX.N/UVFiUf0G91uyfaFC0TyBuNuFzjZ87p7sh/ooqgh.h2', 'PETIT',        'Lea',    '0600000003', '541 route de la tour', 'SCIEZ',   'France', 1),
(6, 'employe@viteetgourmand.com',  '["ROLE_EMPLOYE"]', '$2y$13$jedtBnHGg205PfJMnwflgO.1AJO/J4Qac1kVmWNM5rpmcgKS/7b1O', '', '', '', '', '', '', 0),
(7, 'employe@test.fr',             '["ROLE_EMPLOYE"]', '$2y$13$VRHC4Gj49E.PbOYpEScL7eyhkmicHMojBkZY4.x/603uOmoMWV9ua', '', '', '', '', '', '', 1),
(8, 'client@test.fr',              '["ROLE_USER"]',    '$2y$13$i3P5cgPOClisY9IdLOMBOu/dCkcq7yFw3r.yPTkf25zhU6Jfcy0Ri', 'Client', 'Test', '0600000000', '1 rue de la paix', 'Bordeaux', 'France', 1);

INSERT INTO theme (id, libelle, description) VALUES
(1, 'Noël',       ''),
(2, 'Pâques',     ''),
(3, 'Classique',  ''),
(4, 'Evénements', '');

INSERT INTO regime (id, libelle, description) VALUES
(1, 'Classique',   ''),
(2, 'Végetarien',  ''),
(3, 'Vegan',       ''),
(4, 'Sans gluten', '');

INSERT INTO allergenes (id, libelle) VALUES
(1, 'Gluten'),
(2, 'Lactose'),
(3, 'Fruits à coque'),
(4, 'Oeufs'),
(5, 'Poisson'),
(6, 'Crustacés');

INSERT INTO plat (id, titre, description, type, photo) VALUES
(1, 'Foie gras maison',        'Foie gras fait maison avec sa confiture de figues',     'entree',  'assets/img/menu/menu-item-1.png'),
(2, 'Velouté de butternut',    'Velouté onctueux de butternut et ses épices douces',    'entree',  'assets/img/menu/menu-item-2.png'),
(3, 'Saumon en croûte',        'Saumon en croûte feuilletée et sa sauce hollandaise',   'plat',    'assets/img/menu/menu-item-3.png'),
(4, 'Magret de canard',        'Magret de canard rôti et sa sauce aux cerises',         'plat',    'assets/img/menu/menu-item-4.png'),
(5, 'Bûche de Noël',           'Bûche de Noël au chocolat et ses éclats de noisettes',  'dessert', 'assets/img/menu/menu-item-5.png'),
(6, 'Tarte aux fraises',       'Tarte aux fraises fraîches et sa crème pâtissière',     'dessert', 'assets/img/menu/menu-item-6.png'),
(7, 'Salade de chèvre chaud',  'Salade gourmande au chèvre chaud et ses noix',          'entree',  'assets/img/menu/menu-item-1.png'),
(8, 'Filet de bœuf',           'Filet de bœuf grillé et sa sauce au poivre',            'plat',    'assets/img/menu/menu-item-2.png'),
(9, 'Mousse au chocolat',      'Mousse au chocolat noir et sa chantilly maison',        'dessert', 'assets/img/menu/menu-item-3.png');

INSERT INTO menu (id, titre, description, personnes_min, prix_par_personne, quantite_restante, conditions, theme_id) VALUES
(1, 'Menu Noël Prestige',   'Un menu raffiné pour célébrer Noël en famille avec des produits nobles et savoureux',            6,  85, 10, 'Commander 2 semaines à l''avance minimum. Livraison possible dans tout le département.', 1),
(2, 'Menu Pâques Gourmand', 'Savourez les saveurs du printemps avec notre menu spécial Pâques élaboré avec des produits frais', 4,  65,  8, 'Commander 1 semaine à l''avance minimum.', 2),
(3, 'Menu Classique',       'Notre menu incontournable pour tous vos événements du quotidien',                                2,  45, 15, 'Commander 3 jours à l''avance minimum.', 3),
(4, 'Menu Événement',       'Un menu haut de gamme pour vos événements professionnels et privés',                            10,  95,  5, 'Commander 3 semaines à l''avance minimum. Devis sur demande pour les grands groupes.', 4);

INSERT INTO menu_plat (menu_id, plat_id) VALUES
(1, 1), (1, 3), (1, 5),
(2, 2), (2, 4), (2, 6),
(3, 7), (3, 8), (3, 9),
(4, 1), (4, 5), (4, 8);

INSERT INTO menu_regime (menu_id, regime_id) VALUES
(1, 1),
(2, 1), (2, 2),
(3, 1),
(4, 1);

INSERT INTO commandes (id, numero_commande, date_commande, date_presta, heure_livraison, adresse_livraison, prix_menu, nombre_personnes, prix_livraison, statut, pret_materiel, restitution_materiel, users_id, menu_id) VALUES
(18, '6a0829c4af495', '2026-05-16 08:24:36', '2026-05-22', '10:00', '1 rue de la paix, bordeaux',  850.0, 10, 0, 'terminée',   0, 0, 1, 1),
(19, '6a082acc72c7b', '2026-05-16 08:29:00', '2026-05-22', '13:00', '1 rue de la paix, bordeaux', 1147.5, 15, 0, 'terminée',   0, 0, 1, 1),
(45, '6a0832f184f3b', '2026-05-16 09:03:45', '2026-05-21', '10:00', '1 rue de la paix, bordeaux',  850.0, 10, 0, 'en attente', 0, 0, 1, 1),
(50, '6a083833183a9', '2026-05-16 09:26:11', '2026-05-16', '10:00', '1 rue de la paix, bordeaux',  841.5, 11, 0, 'en attente', 0, 0, 1, 1),
(51, '6a1809d600710', '2026-05-28 09:24:38', '2026-05-31', '12:00', '1 rue de la paix, Bordeaux', 1170.0, 20, 5, 'terminée',   0, 0, 8, 2),
(52, '6a195965301c7', '2026-05-29 09:16:21', '2026-05-29', '16:00', '1 rue de la paix, bordeaux',  841.5, 11, 0, 'en attente', 0, 0, 1, 1),
(57, '6a195a7c576ec', '2026-05-29 09:21:00', '2026-06-07', '14:00', '1 rue de la paix, bordeaux',  841.5, 11, 0, 'en attente', 0, 0, 1, 1),
(59, '6a195d6494903', '2026-05-29 09:33:24', '2026-06-07', '15:00', '1 rue de la paix, bordeaux',  841.5, 11, 0, 'en attente', 0, 0, 1, 1);

INSERT INTO avis (id, note, commentaire, statut, commande_id) VALUES
(1, 5, 'super',               'validé',     18),
(2, 5, 'Tres bien merci !',   'validé',     19),
(3, 5, 'Tres bien , merci.',  'en attente', 51);
