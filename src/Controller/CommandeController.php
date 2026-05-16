<?php

namespace App\Controller;

use App\Entity\Commandes;
use Doctrine\ORM\EntityManagerInterface;
use App\Repository\MenuRepository;
use App\Form\CommandeType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Component\Mailer\MailerInterface;

final class CommandeController extends AbstractController
{
    #[Route('/commande/{id}', name: 'app_commande')]
    public function detail(int $id, MenuRepository $menuRepository, EntityManagerInterface $entityManager, Request $request, MailerInterface $mailer): Response
    {

    $menu = $menuRepository->find($id);
    
    $commande = new Commandes();
    $user = $this->getUser();
    $commande->setAdresseLivraison($user->getAdresse() . ', ' . $user->getVille());
    $form = $this->createForm(CommandeType::class, $commande);
        $form->handleRequest($request);

    if ($form->isSubmitted() && $form->isValid()) {
            
            $commande->setNumeroCommande(uniqid());        
            $commande->setUsers($this->getUser());
            $commande->setMenu($menu);
            $commande->setStatut('en attente');
            $commande->setPrixLivraison(0);
            if ($user->getVille() == 'bordeaux'){
              $commande->setPrixLivraison(0);
            }
             else $commande->setPrixLivraison(5);

            $commande->setPretMateriel(false);
            $commande->setRestitutionMateriel(false);
            $commande->setDateCommande(new \DateTime());
            $commande->setPrixMenu($menu->getPrixParPersonne() * $commande->getNombrePersonnes());
            if ($commande->getNombrePersonnes() >= $menu->getPersonnesMin() +5){
               $commande->setPrixMenu($menu->getPrixParPersonne() * $commande->getNombrePersonnes() *0.90);
            }
            $entityManager->persist($commande);
            $entityManager->flush();
            
            $email = (new TemplatedEmail())
             ->from('contact@vite-et-gourmand.fr')
             ->to($user->getEmail())
             ->subject('Confirmation de commande')
             ->htmlTemplate('emails/confirmation.html.twig')
             ->context(['commande' => $commande]);

            $mailer->send($email);

return $this->redirectToRoute('app_home');
    }
       
        return $this->render('commande/index.html.twig', [
            'menu' => $menu,
            'form'=> $form
        ]);
    }
}
