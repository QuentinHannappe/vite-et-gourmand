<?php

namespace App\Controller;

use App\Entity\User;
use App\Repository\UserRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Repository\CommandesRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Component\Mailer\MailerInterface;
use App\Repository\AvisRepository;
use Symfony\Bundle\SecurityBundle\Security;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use App\Form\EmployeType;





final class AdminController extends AbstractController
{
    #[Route('/admin', name: 'app_admin')]
    public function index(CommandesRepository $commandesRepository, Request $request, Avisrepository $avisRepository, UserRepository $userRepository): Response
    {
    $statut = $request->query->get('statut');
    $client = $request->query->get('client');
    $employes = $userRepository->findAll();


    if ($statut) {
    $commandes = $commandesRepository->findBy(['statut' => $statut]);
    } elseif ($client) {
    $commandes = $commandesRepository->findByClient($client);
    } else {
    $commandes = $commandesRepository->findAll();
    }

    $avis = $avisRepository->findBy(['statut' => 'en attente']);


        return $this->render('admin/index.html.twig', [
            'statut' => $statut,
            'client' => $client,
            'commandes' => $commandes,
            'avis' => $avis,
            'employes' => $employes
        ]);
    }

    #[Route('/profile/commande/{id}/statut', name: 'app_statut')]
    public function changerStatut(int $id, EntityManagerInterface $entityManager, CommandesRepository $commandesRepository, Request $request, MailerInterface $mailer): Response
    {
        $commande = $commandesRepository->find($id);
        $statut = $request->request->get('statut');
        $commande->setStatut($statut);

            $entityManager->persist($commande);
            $entityManager->flush();

    if ($statut == 'terminée') {
    $user = $commande->getUsers();
    $email = (new TemplatedEmail())
             ->from('contact@vite-et-gourmand.fr')
             ->to($user->getEmail())
             ->subject('Laissez un avis')
             ->htmlTemplate('emails/avis.html.twig')
             ->context(['user' => $user, 'commande' => $commande]);
            $mailer->send($email);
    }
     return $this->redirectToRoute('app_admin');
    }



    #[Route('/admin/avis/{id}/statut', name: 'app_valider_avis')]
    public function validerAvis(int $id, AvisRepository $avisRepository, Request $request, EntityManagerInterface $entityManager, CommandesRepository $commandesRepository): Response
    {
    $avis = $avisRepository->find($id);
    $statut = $request->request->get('statut');
    $avis->setStatut($statut);
    $entityManager->persist($avis);
    $entityManager->flush();
    return $this->redirectToRoute('app_admin');
    }

    
    
    #[Route('/admin/employe/creer', name: 'app_creer_employe')]
    public function register(Request $request, UserPasswordHasherInterface $userPasswordHasher, Security $security, EntityManagerInterface $entityManager, MailerInterface $mailer): Response
    {
        $user = new User();
        $user->setNom('');
        $user->setPrenom('');
        $user->setTelephone('');
        $user->setAdresse('');
        $user->setVille('');
        $user->setPays('');
        $user->setIsActive(true);
        $user->setRoles(['ROLE_EMPLOYE']);
        $form = $this->createForm(EmployeType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            /** @var string $password */
            $password = $form->get('password')->getData();

            // encode the plain password
            $user->setPassword($userPasswordHasher->hashPassword($user, $password));

            $entityManager->persist($user);
            $entityManager->flush();

            $email = (new TemplatedEmail())
             ->from('contact@vite-et-gourmand.fr')
             ->to($user->getEmail())
             ->subject('bienvenu')
             ->htmlTemplate('emails/bienvenu.html.twig')
             ->context(['user' => $user]);
            $mailer->send($email);

            
            return $this->redirectToRoute('app_admin');
        }

        return $this->render('admin/creer_employe.html.twig', [
            'form' => $form,
        ]);
    }

    #[Route('/admin/employe/{id}/desactiver', name: 'app_desactiver_employe')]
    public function annuler(int $id, EntityManagerInterface $entityManager, UserRepository $userRepository): Response
    {
        $user = $userRepository->find($id);
        $user->setIsActive(false);

            $entityManager->persist($user);
            $entityManager->flush();

     return $this->redirectToRoute('app_admin');
    }


}
