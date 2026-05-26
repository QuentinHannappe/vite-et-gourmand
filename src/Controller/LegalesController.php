<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class LegalesController extends AbstractController
{
    #[Route('/legales', name: 'app_legales')]
    public function legales(): Response
    {
        return $this->render('legales/index.html.twig', [
            'controller_name' => 'LegalesController',
        ]);
    }

    #[Route('/cgv', name: 'app_cgv')]
    public function cgv(): Response
    {
        return $this->render('legales/cgv.html.twig', [
            'controller_name' => 'LegalesController',
        ]);
    }
}
