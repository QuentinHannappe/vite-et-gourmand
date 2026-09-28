-- Vite & Gourmand : jeu de donnees pour PostgreSQL (deploiement fly.io)

INSERT INTO "user" (id, email, roles, password, nom, prenom, telephone, adresse, ville, pays, is_active) VALUES
(1, 'jose@admin.fr',               '["ROLE_ADMIN"]',   '$2y$13$W5MXilPiWUofmobB/0g/0enhlWVMrilEkl77PCiW6PFwUuw.nwRue', 'proprietaire', 'jose',   '0600000000', '1 rue de la paix', 'bordeaux', 'france', true),
(3, 'client1@test.fr',             '["ROLE_USER"]',    '$2y$13$N4an3QNov77NdPiV2jcY1uPXT48N9zrzlWPTLUXKN0.q5hvl1YaBq', 'MARTIN',       'Claire', '0600000001', '541 route de la tour', 'SCIEZ',   'France', true),
(4, 'client2@test.fr',             '["ROLE_USER"]',    '$2y$13$PNtGsdbWwjM.Zi2KpqVYBeDK0WKl1eKFiBKYTjpKxyFOClKj0Kvae', 'DURAND',       'Paul',   '0600000002', '541 route de la tour', 'SCIEZ',   'France', true),
(5, 'client3@test.fr',             '["ROLE_USER"]',    '$2y$13$8f19u9KX.N/UVFiUf0G91uyfaFC0TyBuNuFzjZ87p7sh/ooqgh.h2', 'PETIT',        'Lea',    '0600000003', '541 route de la tour', 'SCIEZ',   'France', true),
(6, 'employe@viteetgourmand.com',  '["ROLE_EMPLOYE"]', '$2y$13$jedtBnHGg205PfJMnwflgO.1AJO/J4Qac1kVmWNM5rpmcgKS/7b1O', '', '', '', '', '', '', false),
(7, 'employe@test.fr',             '["ROLE_EMPLOYE"]', '$2y$13$VRHC4Gj49E.PbOYpEScL7eyhkmicHMojBkZY4.x/603uOmoMWV9ua', '', '', '', '', '', '', true),
(8, 'client@test.fr',              '["ROLE_USER"]',    '$2y$13$i3P5cgPOClisY9IdLOMBOu/dCkcq7yFw3r.yPTkf25zhU6Jfcy0Ri', 'Client', 'Test', '0600000000', '1 rue de la paix', 'Bordeaux', 'France', true);

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
(18, '6a0829c4af495', '2026-05-16 08:24:36', '2026-05-22', '10:00', '1 rue de la paix, bordeaux',  850.0, 10, 0, 'terminée',   false, false, 1, 1),
(19, '6a082acc72c7b', '2026-05-16 08:29:00', '2026-05-22', '13:00', '1 rue de la paix, bordeaux', 1147.5, 15, 0, 'terminée',   false, false, 1, 1),
(45, '6a0832f184f3b', '2026-05-16 09:03:45', '2026-05-21', '10:00', '1 rue de la paix, bordeaux',  850.0, 10, 0, 'en attente', false, false, 1, 1),
(50, '6a083833183a9', '2026-05-16 09:26:11', '2026-05-16', '10:00', '1 rue de la paix, bordeaux',  841.5, 11, 0, 'en attente', false, false, 1, 1),
(51, '6a1809d600710', '2026-05-28 09:24:38', '2026-05-31', '12:00', '1 rue de la paix, Bordeaux', 1170.0, 20, 5, 'terminée',   false, false, 8, 2),
(52, '6a195965301c7', '2026-05-29 09:16:21', '2026-05-29', '16:00', '1 rue de la paix, bordeaux',  841.5, 11, 0, 'en attente', false, false, 1, 1),
(57, '6a195a7c576ec', '2026-05-29 09:21:00', '2026-06-07', '14:00', '1 rue de la paix, bordeaux',  841.5, 11, 0, 'en attente', false, false, 1, 1),
(59, '6a195d6494903', '2026-05-29 09:33:24', '2026-06-07', '15:00', '1 rue de la paix, bordeaux',  841.5, 11, 0, 'en attente', false, false, 1, 1);

INSERT INTO avis (id, note, commentaire, statut, commande_id) VALUES
(1, 5, 'super',               'validé',     18),
(2, 5, 'Tres bien merci !',   'validé',     19),
(3, 5, 'Tres bien , merci.',  'en attente', 51);

-- Les identifiants ont ete inseres explicitement.
-- Il faut donc replacer les compteurs de PostgreSQL apres la derniere valeur,
-- sinon le prochain enregistrement reutiliserait un identifiant deja pris.
SELECT setval('user_id_seq',       (SELECT MAX(id) FROM "user"));
SELECT setval('theme_id_seq',      (SELECT MAX(id) FROM theme));
SELECT setval('regime_id_seq',     (SELECT MAX(id) FROM regime));
SELECT setval('allergenes_id_seq', (SELECT MAX(id) FROM allergenes));
SELECT setval('plat_id_seq',       (SELECT MAX(id) FROM plat));
SELECT setval('menu_id_seq',       (SELECT MAX(id) FROM menu));
SELECT setval('commandes_id_seq',  (SELECT MAX(id) FROM commandes));
SELECT setval('avis_id_seq',       (SELECT MAX(id) FROM avis));
