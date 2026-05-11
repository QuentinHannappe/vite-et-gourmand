<?php
namespace App\Data;
use App\Entity\Theme;
use App\Entity\Regime;
class SearchData
{

    /**
     * @var Theme[]
     */
    public $theme = [];

    /**
     * @var Regime
     */
    public $regime = [];

    /**
     * @var null|integer
     */
    public $max;

    /**
     * @var null|integer
     */
    public $min;

    /**
     * @var null|integer
     */
    public $minPersonnes;

}