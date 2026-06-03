<?php

namespace App\DataFixtures;

use App\Entity\User;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class AppFixtures extends Fixture
{
    public function __construct(
        private UserPasswordHasherInterface $hasher
    ) {}

    public function load(ObjectManager $manager): void
    {
        $admin = new User();
        $admin->setEmail('admin@vite-gourmand.fr');
        $admin->setRoles(['ROLE_ADMIN']);
        $admin->setNom('Admin');
        $admin->setPrenom('Jose');
        $admin->setTelephone('0600000000');
        $admin->setAdresse('1 rue de la Paix');
        $admin->setVille('Bordeaux');
        $admin->setPays('France');
        $admin->setIsActive(true);

        $password = $this->hasher->hashPassword($admin, 'Admin@jose');
        $admin->setPassword($password);

        $manager->persist($admin);
        $manager->flush();
    }
}