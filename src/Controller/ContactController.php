<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\HttpFoundation\Request;
use App\Form\ContactType;



final class ContactController extends AbstractController
{
    
    #[Route('/contact', name: 'app_contact')]
    public function contact(Request $request, MailerInterface $mailer): Response
    {      
      $form = $this->createForm(ContactType::class);
      $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid())
        {
            $email = (new TemplatedEmail())
             ->from($form->get('email')->getData())
             ->to('contact@viteetgourmand.com')
             ->subject($form->get('titre')->getData())
             ->htmlTemplate('emails/contact.html.twig')
             ->context([
               'nom' => $form->get('nom')->getData(),
               'description' => $form->get('description')->getData(),
               'emailClient' => $form->get('email')->getData(),
               'titre' => $form->get('titre')->getData(),

    ]);
            $mailer->send($email);

            
            return $this->redirectToRoute('app_home');
        }

        return $this->render('contact/index.html.twig', [
            'form' => $form,
        ]);
    }
}