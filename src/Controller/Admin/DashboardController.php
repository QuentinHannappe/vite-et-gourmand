<?php

namespace App\Controller\Admin;

use EasyCorp\Bundle\EasyAdminBundle\Attribute\AdminDashboard;
use EasyCorp\Bundle\EasyAdminBundle\Config\Dashboard;
use EasyCorp\Bundle\EasyAdminBundle\Config\MenuItem;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractDashboardController;
use Symfony\Component\HttpFoundation\Response;
use App\Controller\Admin\MenuCrudController;
use App\Controller\Admin\PlatCrudController;
use App\Controller\Admin\HoraireCrudController;


#[AdminDashboard(routePath: '/gestionmenu', routeName: 'gestionmenu')]
class DashboardController extends AbstractDashboardController
{
    public function index(): Response
    {
        
      return $this->redirectToRoute('gestionmenu_menu_index');

        // Option 1. You can make your dashboard redirect to some common page of your backend
        //
        // return $this->redirectToRoute('admin_user_index');

        // Option 2. You can make your dashboard redirect to different pages depending on the user
        //
        // if ('jane' === $this->getUser()->getUsername()) {
        //     return $this->redirectToRoute('...');
        // }

        // Option 3. You can render some custom template to display a proper dashboard with widgets, etc.
        // (tip: it's easier if your template extends from @EasyAdmin/page/content.html.twig)
        //
        // return $this->render('some/path/my-dashboard.html.twig');
    }

    public function configureDashboard(): Dashboard
    {
        return Dashboard::new()
            ->setTitle('Vite Et Gourmand');
    }

    public function configureMenuItems(): iterable
{
    return [
        MenuItem::linkToDashboard('Dashboard', 'fa fa-home'),
        MenuItem::linkTo(MenuCrudController::class, 'Menus', 'fa fa-list'),
        MenuItem::linkTo(PlatCrudController::class, 'Plats', 'fa fa-utensils'),
        MenuItem::linkTo(HoraireCrudController::class, 'Horaires', 'fa fa-clock'),
    ];
}
}
