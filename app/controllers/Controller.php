<?php

namespace app\controllers;

use Smarty;
use Valitron\Validator;

class Controller
{
    protected $smarty;
    protected $request;
    protected $v;

    public function __construct($request)
    {
        $this->smarty = new Smarty();
        $this->smarty->escape_html = true;
        $this->smarty->template_dir = __DIR__ . '/../../templates/';
        $this->smarty->compile_dir = __DIR__ . '/../../templates_c/';

        $this->request = $request;

        Validator::lang('ja');
        $this->v = new Validator($request);
    }
}
