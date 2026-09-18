-- Vite & Gourmand : jeu de donnees pour PostgreSQL

INSERT INTO "user" (email, roles, password, nom, prenom, telephone, adresse, ville, pays, is_active) VALUES
('jose@admin.fr',    '["ROLE_ADMIN"]',   '$2y$13$W5MXilPiWUofmobB/0g/0enhlWVMrilEkl77PCiW6PFwUuw.nwRue', 'Proprietaire', 'Jose',  '0600000000', '1 rue de la Paix', 'bordeaux', 'France', true),
('employe@test.fr',  '["ROLE_EMPLOYE"]', '$2y$13$VRHC4Gj49E.PbOYpEScL7eyhkmicHMojBkZY4.x/603uOmoMWV9ua', 'Martin',       'Claire', '0600000001', '4 cours du Medoc',  'Bordeaux', 'France', true),
('client@test.fr',   '["ROLE_USER"]',    '$2y$13$i3P5cgPOClisY9IdLOMBOu/dCkcq7yFw3r.yPTkf25zhU6Jfcy0Ri', 'Durand',       'Paul',   '0600000002', '12 rue Sainte-Catherine', 'Sciez', 'France', true);

INSERT INTO theme (libelle, description) VALUES
('Noel',       'Menus de fin d annee'),
('Paques',     'Menus de printemps'),
('Classique',  'Menus du quotidien'),
('Evenements', 'Menus pour receptions professionnelles et privees');

INSERT INTO regime (libelle, description) VALUES
('Vegetarien',  'Sans viande ni poisson'),
('Vegan',       'Sans aucun produit d origine animale'),
('Sans gluten', 'Sans cereales contenant du gluten');

INSERT INTO allergenes (libelle) VALUES
('Gluten'),
('Lactose'),
('Fruits a coque'),
('Oeuf');

INSERT INTO plat (titre, description, type, photo) VALUES
('Foie gras maison',     'Foie gras mi-cuit et sa confiture de figues',    'entree',  'foie-gras.jpg'),
('Veloute de potimarron','Veloute onctueux et ses eclats de noisettes',    'entree',  'veloute.jpg'),
('Filet de boeuf',       'Filet de boeuf grille et sa sauce au poivre',    'plat',    'filet-boeuf.jpg'),
('Risotto aux legumes',  'Risotto cremeux aux legumes de saison',          'plat',    'risotto.jpg'),
('Buche de Noel',        'Buche au chocolat et ses eclats de noisettes',   'dessert', 'buche.jpg'),
('Tarte aux fruits',     'Tarte fine aux fruits frais de saison',          'dessert', 'tarte.jpg');

INSERT INTO horaire (jour, heure_ouverture, heure_fermeture) VALUES
('Lundi',    '00:00', '00:00'),
('Mardi',    '11:00', '22:00'),
('Mercredi', '11:00', '22:00');

INSERT INTO menu (titre, description, personnes_min, prix_par_personne, quantite_restante, conditions, theme_id) VALUES
('Menu Noel Prestige',   'Un menu raffine pour celebrer Noel en famille',        6,  85, 10, 'Commander 2 semaines a l avance minimum.', 1),
('Menu Paques Gourmand', 'Les saveurs du printemps, avec des produits frais',    4,  65,  8, 'Commander 1 semaine a l avance minimum.',  2),
('Menu Classique',       'Notre menu incontournable pour tous vos evenements',   2,  45, 15, 'Commander 3 jours a l avance minimum.',    3);

INSERT INTO image (chemin, menu_id) VALUES
('menu-noel-1.jpg',      1),
('menu-paques-1.jpg',    2),
('menu-classique-1.jpg', 3);

INSERT INTO menu_plat (menu_id, plat_id) VALUES
(1, 1), (1, 3), (1, 5),
(2, 2), (2, 4), (2, 6),
(3, 2), (3, 3), (3, 6);

INSERT INTO menu_regime (menu_id, regime_id) VALUES
(2, 1),
(3, 1), (3, 3);

INSERT INTO plat_allergenes (plat_id, allergenes_id) VALUES
(1, 1),
(2, 3),
(5, 1), (5, 2), (5, 3),
(6, 1), (6, 4);

INSERT INTO commandes (numero_commande, date_commande, date_presta, heure_livraison, adresse_livraison, prix_menu, nombre_personnes, prix_livraison, statut, pret_materiel, restitution_materiel, users_id, menu_id) VALUES
('6a0829c4af495', '2026-05-16 08:24:36', '2026-05-22', '10:00', '12 rue Sainte-Catherine, Sciez', 180.00, 4,  5, 'terminée',   false, false, 3, 3),
('6a082acc72c7b', '2026-05-28 09:24:38', '2026-06-04', '12:00', '12 rue Sainte-Catherine, Sciez', 364.50, 9,  5, 'en attente', false, false, 3, 3);

INSERT INTO avis (note, commentaire, statut, commande_id) VALUES
(5, 'Tres bon menu, livraison a l heure.', 'valide', 1);
