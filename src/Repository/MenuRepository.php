<?php

namespace App\Repository;

use App\Entity\Menu;
use App\Data\SearchData;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Menu>
 */
class MenuRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Menu::class);
    }

  public function findSearch(SearchData $search): array
{
    $query = $this->createQueryBuilder('m');

    if (!empty($search->theme)) {
        $query->andWhere('m.theme IN (:theme)')
              ->setParameter('theme', $search->theme);
    }

    if (!empty($search->regime)) {
    $query->join('m.regimes', 'r')
          ->andWhere('r.id IN (:regime)')
          ->setParameter('regime', $search->regime);
}

    if (!empty($search->min)) {
        $query->andWhere('m.prix_par_personne >= :min')
              ->setParameter('min', $search->min);
    }

    if (!empty($search->max)) {
        $query->andWhere('m.prix_par_personne <= :max')
              ->setParameter('max', $search->max);
    }

    if (!empty($search->minPersonnes)) {
        $query->andWhere('m.personnes_min >= :minPersonnes')
              ->setParameter('minPersonnes', $search->minPersonnes);
    }

    return $query->getQuery()->getResult();
}  
}
