<?php

namespace App\Form;

use App\Data\SearchData;
use App\Entity\Theme;
use App\Entity\Regime;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class SearchType extends AbstractType
{

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('theme', EntityType::class, [
                'label' => false,
                'required' => false,
                'class' => Theme::class,
                'expanded' => true,
                'multiple' => true,
                'row_attr' => ['class' => 'd-flex flex-wrap gap-2 flex-nowrap']

            ])
            ->add('regime', EntityType::class, [
                'label' => false,
                'required' => false,
                'class' => Regime::class,
                'expanded' => true,
                'multiple' => true,
                'row_attr' => ['class' => 'd-flex flex-wrap gap-2 flex-nowrap']

            ])
            ->add('min', NumberType::class, [
                'label' => false,
                'required' => false,
                'attr' => [
                    'placeholder' => 'Prix min'
                ],
                'row_attr' => ['class' => 'd-flex flex-wrap gap-1 flex-nowrap']
            ])
            ->add('max', NumberType::class, [
                'label' => false,
                'required' => false,
                'attr' => [
                    'placeholder' => 'Prix max'
                ],
                'row_attr' => ['class' => 'd-flex flex-wrap gap-1 flex-nowrap']
            ])
            ->add('minPersonnes', NumberType::class, [
                'label' => false,
                'required' => false,
                'attr' => [
                    'placeholder' => 'Min Personnes'
                ],
                'row_attr' => ['class' => 'd-flex flex-wrap gap-1 flex-nowrap']
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => SearchData::class,
            'method' => 'GET',
            'csrf_protection' => false
        ]);
    }

    public function getBlockPrefix()
    {
        return '';
    }

}