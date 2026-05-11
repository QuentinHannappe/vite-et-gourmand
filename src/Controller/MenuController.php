<?php

namespace App\Controller;

use App\Repository\MenuRepository;
use App\Data\SearchData;
use App\Form\SearchType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class MenuController extends AbstractController
{
#[Route('/menus', name: 'app_menu')]
public function index(MenuRepository $menuRepository, Request $request): Response
 {
    $data = new SearchData();
    $form = $this->createForm(SearchType::class, $data);
    $form->handleRequest($request);
    $menus = $menuRepository->findSearch($data);

    return $this->render('menu/index.html.twig', [
        'menus' => $menus,
        'form' => $form->createView()
    ]);
 }
}