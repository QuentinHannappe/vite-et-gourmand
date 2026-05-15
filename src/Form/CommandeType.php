<?php

namespace App\Form;

use App\Entity\Commandes;
use App\Entity\Menu;
use App\Entity\User;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
class CommandeType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            
            ->add('date_presta')
            ->add('heure_livraison', ChoiceType::class, [
    'choices' => [
        '10h00' => '10:00',
        '11h00' => '11:00',
        '12h00' => '12:00',
        '13h00' => '13:00',
        '14h00' => '14:00',
        '15h00' => '15:00',
        '16h00' => '16:00',
        '17h00' => '17:00',
        '18h00' => '18:00',
        '19h00' => '19:00',
        '20h00' => '20:00',
    ],
    'label' => 'Heure de livraison',
])
            ->add('adresse_livraison')
            ->add('nombre_personnes')
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Commandes::class,
        ]);
    }
}
