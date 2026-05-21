<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Repository\AvisRepository;


final class HomeController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function index(AvisRepository $avisRepository): Response
    {
        $avis = $avisRepository->findBy(['statut' => 'valide']);
        return $this->render('home/index.html.twig', [
            'avis' => $avis,
        ]);
    }
}
