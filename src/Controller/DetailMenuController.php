<?php

namespace App\Controller;

use App\Repository\MenuRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class DetailMenuController extends AbstractController
{
   #[Route('/menus/{id}', name: 'app_menu_detail')]
public function detail(int $id, MenuRepository $menuRepository): Response
{
    $menu = $menuRepository->find($id);
    
    return $this->render('detail_menu/index.html.twig', [
        'menu' => $menu,
    ]);
}
}
