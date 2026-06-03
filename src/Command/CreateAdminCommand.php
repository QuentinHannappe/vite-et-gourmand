<?php

namespace App\Command;

use App\Entity\User;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

#[AsCommand(name: 'app:create-admin')]
class CreateAdminCommand extends Command
{
    public function __construct(
        private EntityManagerInterface $em,
        private UserPasswordHasherInterface $hasher
    ) {
        parent::__construct();
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $admin = new User();
        $admin->setEmail('admin@vite-gourmand.fr');
        $admin->setRoles(['ROLE_ADMIN']);
        $admin->setNom('Admin');
        $admin->setPrenom('jose');
        $admin->setTelephone('0600000000');
        $admin->setAdresse('1 rue de la Paix');
        $admin->setVille('Bordeaux');
        $admin->setPays('France');
        $admin->setIsActive(true);

        $password = $this->hasher->hashPassword($admin, 'Admin@jose');
        $admin->setPassword($password);

        $this->em->persist($admin);
        $this->em->flush();

        $output->writeln('Compte admin créé avec succès !');

        return Command::SUCCESS;
    }
}