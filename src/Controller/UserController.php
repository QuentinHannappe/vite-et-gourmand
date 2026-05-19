<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Repository\CommandesRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use App\Form\ProfilType;
use App\Form\CommandeType;




final class UserController extends AbstractController
{
    #[Route('/profile', name: 'app_profile')]
    public function index(CommandesRepository $commandesRepository): Response
    {   
        $user = $this->getUser();
        $commande = $commandesRepository->findBy(['users' => $user]);
        return $this->render('user/index.html.twig', [
            'commande' => $commande,
        ]);
    }

    #[Route('/profile/edit', name: 'app_profil')]
    public function register(Request $request, EntityManagerInterface $entityManager): Response
    {
        $user = $this->getUser();
        $form = $this->createForm(ProfilType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($user);
            $entityManager->flush();
        return $this->redirectToRoute('app_profil');
    }
    return $this->render('user/edit.html.twig', [
    'form' => $form,
     ]);
    }

    #[Route('/profile/commande/{id}/annuler', name: 'app_annuler')]
    public function annuler(int $id, EntityManagerInterface $entityManager, CommandesRepository $commandesRepository): Response
    {
        $commande = $commandesRepository->find($id);
        $commande->setStatut('Annulée');

            $entityManager->persist($commande);
            $entityManager->flush();

     return $this->redirectToRoute('app_profile');
    }


    #[Route('/commande/{id}/modifier', name: 'app_modifier_commande')]
    public function modifier(int $id, CommandesRepository $commandesRepository, EntityManagerInterface $entityManager, Request $request): Response
    {
    $user = $this->getUser();
    $commande = $commandesRepository->find($id);
    
    $form = $this->createForm(CommandeType::class, $commande);
        $form->handleRequest($request);

    if ($form->isSubmitted() && $form->isValid()) {
        $menu = $commande->getMenu();
        $commande->setPrixMenu($menu->getPrixParPersonne() * $commande->getNombrePersonnes());
        if ($commande->getNombrePersonnes() >= $menu->getPersonnesMin() +5){
        $commande->setPrixMenu($menu->getPrixParPersonne() * $commande->getNombrePersonnes() *0.90);
        }
        
            $entityManager->persist($commande);
            $entityManager->flush();

return $this->redirectToRoute('app_profile');
    }

return $this->render('user/modifier_commande.html.twig', [
    'form' => $form,
    'commande' => $commande,
]);
}

}