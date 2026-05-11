-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : lun. 11 mai 2026 à 11:47
-- Version du serveur : 9.6.0
-- Version de PHP : 8.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `vite_et_gourmand`
--

-- --------------------------------------------------------

--
-- Structure de la table `allergenes`
--

CREATE TABLE `allergenes` (
  `id` int NOT NULL,
  `libelle` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `allergenes`
--

INSERT INTO `allergenes` (`id`, `libelle`) VALUES
(1, 'Gluten'),
(2, 'Lactose'),
(3, 'Fruits à coque'),
(4, 'Oeufs'),
(5, 'Poisson'),
(6, 'Crustacés');

-- --------------------------------------------------------

--
-- Structure de la table `avis`
--

CREATE TABLE `avis` (
  `id` int NOT NULL,
  `note` int NOT NULL,
  `commentaire` longtext NOT NULL,
  `statut` varchar(50) NOT NULL,
  `commande_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

CREATE TABLE `commandes` (
  `id` int NOT NULL,
  `numero_commande` varchar(50) NOT NULL,
  `date_commande` datetime NOT NULL,
  `date_presta` date NOT NULL,
  `heure_livraison` varchar(5) NOT NULL,
  `adresse_livraison` varchar(255) NOT NULL,
  `prix_menu` double NOT NULL,
  `nombre_personnes` int NOT NULL,
  `prix_livraison` double NOT NULL,
  `statut` varchar(50) NOT NULL,
  `pret_materiel` tinyint NOT NULL,
  `restitution_materiel` tinyint NOT NULL,
  `users_id` int NOT NULL,
  `menu_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20260428072845', '2026-04-28 07:33:05', 91);

-- --------------------------------------------------------

--
-- Structure de la table `horaire`
--

CREATE TABLE `horaire` (
  `id` int NOT NULL,
  `jour` varchar(20) NOT NULL,
  `heure_ouverture` varchar(5) NOT NULL,
  `heure_fermeture` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `image`
--

CREATE TABLE `image` (
  `id` int NOT NULL,
  `chemin` varchar(255) NOT NULL,
  `menu_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `menu`
--

CREATE TABLE `menu` (
  `id` int NOT NULL,
  `titre` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  `personnes_min` int NOT NULL,
  `prix_par_personne` double NOT NULL,
  `quantite_restante` int NOT NULL,
  `conditions` longtext NOT NULL,
  `theme_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `menu`
--

INSERT INTO `menu` (`id`, `titre`, `description`, `personnes_min`, `prix_par_personne`, `quantite_restante`, `conditions`, `theme_id`) VALUES
(1, 'Menu Noël Prestige', 'Un menu raffiné pour célébrer Noël en famille avec des produits nobles et savoureux', 6, 85, 10, 'Commander 2 semaines à l\'avance minimum. Livraison possible dans tout le département.', 1),
(2, 'Menu Pâques Gourmand', 'Savourez les saveurs du printemps avec notre menu spécial Pâques élaboré avec des produits frais', 4, 65, 8, 'Commander 1 semaine à l\'avance minimum.', 2),
(3, 'Menu Classique', 'Notre menu incontournable pour tous vos événements du quotidien', 2, 45, 15, 'Commander 3 jours à l\'avance minimum.', 3),
(4, 'Menu Événement', 'Un menu haut de gamme pour vos événements professionnels et privés', 10, 95, 5, 'Commander 3 semaines à l\'avance minimum. Devis sur demande pour les grands groupes.', 4);

-- --------------------------------------------------------

--
-- Structure de la table `menu_plat`
--

CREATE TABLE `menu_plat` (
  `menu_id` int NOT NULL,
  `plat_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `menu_plat`
--

INSERT INTO `menu_plat` (`menu_id`, `plat_id`) VALUES
(1, 1),
(1, 3),
(1, 5),
(2, 2),
(2, 4),
(2, 6),
(3, 7),
(3, 8),
(3, 9),
(4, 1),
(4, 5),
(4, 8);

-- --------------------------------------------------------

--
-- Structure de la table `menu_regime`
--

CREATE TABLE `menu_regime` (
  `menu_id` int NOT NULL,
  `regime_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `menu_regime`
--

INSERT INTO `menu_regime` (`menu_id`, `regime_id`) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 1),
(4, 1);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `plat`
--

CREATE TABLE `plat` (
  `id` int NOT NULL,
  `titre` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  `type` varchar(20) NOT NULL,
  `photo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `plat`
--

INSERT INTO `plat` (`id`, `titre`, `description`, `type`, `photo`) VALUES
(1, 'Foie gras maison', 'Foie gras fait maison avec sa confiture de figues', 'entree', 'assets/img/menu/menu-item-1.png'),
(2, 'Velouté de butternut', 'Velouté onctueux de butternut et ses épices douces', 'entree', 'assets/img/menu/menu-item-2.png'),
(3, 'Saumon en croûte', 'Saumon en croûte feuilletée et sa sauce hollandaise', 'plat', 'assets/img/menu/menu-item-3.png'),
(4, 'Magret de canard', 'Magret de canard rôti et sa sauce aux cerises', 'plat', 'assets/img/menu/menu-item-4.png'),
(5, 'Bûche de Noël', 'Bûche de Noël au chocolat et ses éclats de noisettes', 'dessert', 'assets/img/menu/menu-item-5.png'),
(6, 'Tarte aux fraises', 'Tarte aux fraises fraîches et sa crème pâtissière', 'dessert', 'assets/img/menu/menu-item-6.png'),
(7, 'Salade de chèvre chaud', 'Salade gourmande au chèvre chaud et ses noix', 'entree', 'assets/img/menu/menu-item-1.png'),
(8, 'Filet de bœuf', 'Filet de bœuf grillé et sa sauce au poivre', 'plat', 'assets/img/menu/menu-item-2.png'),
(9, 'Mousse au chocolat', 'Mousse au chocolat noir et sa chantilly maison', 'dessert', 'assets/img/menu/menu-item-3.png');

-- --------------------------------------------------------

--
-- Structure de la table `plat_allergenes`
--

CREATE TABLE `plat_allergenes` (
  `plat_id` int NOT NULL,
  `allergenes_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `regime`
--

CREATE TABLE `regime` (
  `id` int NOT NULL,
  `libelle` varchar(50) NOT NULL,
  `description` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `regime`
--

INSERT INTO `regime` (`id`, `libelle`, `description`) VALUES
(1, 'Classique', ''),
(2, 'Végetarien', ''),
(3, 'Vegan', ''),
(4, 'Sans gluten', '');

-- --------------------------------------------------------

--
-- Structure de la table `theme`
--

CREATE TABLE `theme` (
  `id` int NOT NULL,
  `libelle` varchar(50) NOT NULL,
  `description` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `theme`
--

INSERT INTO `theme` (`id`, `libelle`, `description`) VALUES
(1, 'Noël', ''),
(2, 'Pâques', ''),
(3, 'Classique', ''),
(4, 'Evénements', '');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `ville` varchar(100) NOT NULL,
  `pays` varchar(100) NOT NULL,
  `is_active` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `nom`, `prenom`, `telephone`, `adresse`, `ville`, `pays`, `is_active`) VALUES
(1, 'jose@admin.fr', '[\"ROLE_ADMIN\"]', '$2y$13$W5MXilPiWUofmobB/0g/0enhlWVMrilEkl77PCiW6PFwUuw.nwRue', 'proprietaire', 'jose', '0600000000', '1 rue de la paix', 'bordeaux', 'france', 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `allergenes`
--
ALTER TABLE `allergenes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `avis`
--
ALTER TABLE `avis`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8F91ABF082EA2E54` (`commande_id`);

--
-- Index pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_35D4282C67B3B43D` (`users_id`),
  ADD KEY `IDX_35D4282CCCD7E912` (`menu_id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `horaire`
--
ALTER TABLE `horaire`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C53D045FCCD7E912` (`menu_id`);

--
-- Index pour la table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7D053A9359027487` (`theme_id`);

--
-- Index pour la table `menu_plat`
--
ALTER TABLE `menu_plat`
  ADD PRIMARY KEY (`menu_id`,`plat_id`),
  ADD KEY `IDX_E8775249CCD7E912` (`menu_id`),
  ADD KEY `IDX_E8775249D73DB560` (`plat_id`);

--
-- Index pour la table `menu_regime`
--
ALTER TABLE `menu_regime`
  ADD PRIMARY KEY (`menu_id`,`regime_id`),
  ADD KEY `IDX_79C112A4CCD7E912` (`menu_id`),
  ADD KEY `IDX_79C112A435E7D534` (`regime_id`);

--
-- Index pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0E3BD61CE16BA31DBBF396750` (`queue_name`,`available_at`,`delivered_at`,`id`);

--
-- Index pour la table `plat`
--
ALTER TABLE `plat`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `plat_allergenes`
--
ALTER TABLE `plat_allergenes`
  ADD PRIMARY KEY (`plat_id`,`allergenes_id`),
  ADD KEY `IDX_40BFC55DD73DB560` (`plat_id`),
  ADD KEY `IDX_40BFC55DC21A0BEF` (`allergenes_id`);

--
-- Index pour la table `regime`
--
ALTER TABLE `regime`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `theme`
--
ALTER TABLE `theme`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `allergenes`
--
ALTER TABLE `allergenes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `avis`
--
ALTER TABLE `avis`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `commandes`
--
ALTER TABLE `commandes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `horaire`
--
ALTER TABLE `horaire`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `image`
--
ALTER TABLE `image`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `plat`
--
ALTER TABLE `plat`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `regime`
--
ALTER TABLE `regime`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `theme`
--
ALTER TABLE `theme`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `avis`
--
ALTER TABLE `avis`
  ADD CONSTRAINT `FK_8F91ABF082EA2E54` FOREIGN KEY (`commande_id`) REFERENCES `commandes` (`id`);

--
-- Contraintes pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD CONSTRAINT `FK_35D4282C67B3B43D` FOREIGN KEY (`users_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FK_35D4282CCCD7E912` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`);

--
-- Contraintes pour la table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `FK_C53D045FCCD7E912` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`);

--
-- Contraintes pour la table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `FK_7D053A9359027487` FOREIGN KEY (`theme_id`) REFERENCES `theme` (`id`);

--
-- Contraintes pour la table `menu_plat`
--
ALTER TABLE `menu_plat`
  ADD CONSTRAINT `FK_E8775249CCD7E912` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_E8775249D73DB560` FOREIGN KEY (`plat_id`) REFERENCES `plat` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `menu_regime`
--
ALTER TABLE `menu_regime`
  ADD CONSTRAINT `FK_79C112A435E7D534` FOREIGN KEY (`regime_id`) REFERENCES `regime` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_79C112A4CCD7E912` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `plat_allergenes`
--
ALTER TABLE `plat_allergenes`
  ADD CONSTRAINT `FK_40BFC55DC21A0BEF` FOREIGN KEY (`allergenes_id`) REFERENCES `allergenes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_40BFC55DD73DB560` FOREIGN KEY (`plat_id`) REFERENCES `plat` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
