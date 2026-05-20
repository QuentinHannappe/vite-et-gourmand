<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Repository\CommandesRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Component\Mailer\MailerInterface;
use App\Repository\AvisRepository;




final class EmployeController extends AbstractController
{
    #[Route('/employe', name: 'app_employe')]
    public function index(CommandesRepository $commandesRepository, Request $request, Avisrepository $avisRepository,): Response
    {
    $statut = $request->query->get('statut');
    $client = $request->query->get('client');
    
    if ($statut) {
    $commandes = $commandesRepository->findBy(['statut' => $statut]);
    } elseif ($client) {
    $commandes = $commandesRepository->findByClient($client);
    } else {
    $commandes = $commandesRepository->findAll();
    }

    $avis = $avisRepository->findBy(['statut' => 'en attente']);


        return $this->render('employe/index.html.twig', [
            'statut' => $statut,
            'client' => $client,
            'commandes' => $commandes,
            'avis' => $avis,
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
     return $this->redirectToRoute('app_employe');
    }



    #[Route('/employe/avis/{id}/statut', name: 'app_valider_avis')]
    public function validerAvis(int $id, AvisRepository $avisRepository, Request $request, EntityManagerInterface $entityManager, CommandesRepository $commandesRepository): Response
    {
    $avis = $avisRepository->find($id);
    $statut = $request->request->get('statut');
    $avis->setStatut($statut);
    $entityManager->persist($avis);
    $entityManager->flush();
    return $this->redirectToRoute('app_employe');
    }


}