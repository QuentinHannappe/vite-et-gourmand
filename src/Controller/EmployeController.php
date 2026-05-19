<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Repository\CommandesRepository;
use Doctrine\ORM\EntityManagerInterface;



final class EmployeController extends AbstractController
{
    #[Route('/employe', name: 'app_employe')]
    public function index(CommandesRepository $commandesRepository, Request $request): Response
    {
    $statut = $request->query->get('statut');
    $client = $request->query->get('client');
    
    if ($statut) {
    $commandes = $commandesRepository->findBy(['statut' => $statut]);}   
    else {
    $commandes = $commandesRepository->findByClient($client);
    }

        return $this->render('employe/index.html.twig', [
            'statut' => $statut,
            'client' => $client,
            'commandes' => $commandes,
        ]);
    }

    #[Route('/profile/commande/{id}/statut', name: 'app_statut')]
    public function changerStatut(int $id, EntityManagerInterface $entityManager, CommandesRepository $commandesRepository, Request $request): Response
    {
        $commande = $commandesRepository->find($id);
        $statut = $request->request->get('statut');
        $commande->setStatut($statut);

            $entityManager->persist($commande);
            $entityManager->flush();

     return $this->redirectToRoute('app_employe');
    }
}
