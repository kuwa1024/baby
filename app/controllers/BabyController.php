<?php

namespace app\controllers;

use app\models\Timing;
use app\models\TimingSubtype;
use app\models\TimingType;

class BabyController extends Controller
{
    public function index()
    {
        // タイプ一覧
        $timing_type_obj = new TimingType();
        $type_list = $timing_type_obj->getList();
        $this->smarty->assign('type_list', $type_list);

        // サブタイプ一覧
        $timing_subtype_obj = new TimingSubtype();
        $subtype_list = $timing_subtype_obj->getList();
        $this->smarty->assign('subtype_list', $subtype_list);

        // タイミング一覧
        $timing_obj = new Timing();
        $params = [
            'type_id' => $this->request['type_id'],
            'page' => $this->request['page'] ?: 1,
            'page_size' => 20,
        ];
        list($timing_list, $page) = $timing_obj->getList($params);

        // アサイン
        $this->smarty->assign('page', $page);
        $this->smarty->assign('timing_list', $timing_list);
        $this->smarty->display('index.tpl');
    }

    public function add()
    {
        // バリデーション
        $this->v->labels([
            'type_id' => '種別',
            'subtype_id' => 'サブ種別',
        ]);
        $this->v->rule('min', 'type_id', 1);
        $this->v->rule('integer', 'subtype_id');

        if(!$this->v->validate()) {
            $this->smarty->assign('err_msg', $this->v->errors());
            $this->index();
            exit;
        }

        $timing_obj = new Timing();
        $params = [
            'type_id' => $this->request['type_id'],
            'subtype_id' => $this->request['subtype_id'],
        ];
        $timing_obj->add($params);

        header('Location: /');
    }

    public function edit()
    {
        // バリデーション
        $timing_id = intval($this->request['id']);

        // 取得
        $timing_obj = new Timing();
        $timing = $timing_obj->get(['timing_id' => $timing_id]);

        if (!$timing['timing_id']) {
            header('Location: /');
            exit;
        }

        // タイプ一覧
        $timing_type_obj = new TimingType();
        $type_list = $timing_type_obj->getList();
        $this->smarty->assign('type_list', $type_list);

        // サブタイプ一覧
        $timing_subtype_obj = new TimingSubtype();
        $subtype_list = $timing_subtype_obj->getList();
        $this->smarty->assign('subtype_list', $subtype_list);

        // アサイン
        $this->smarty->assign('type_list', $type_list);
        $this->smarty->assign('subtype_list', $subtype_list);
        $this->smarty->assign('timing', $timing);
        $this->smarty->display('edit.tpl');
    }

    public function update($request)
    {
        // バリデーション
        $timing_id = intval($request['id']);
        $date = $request['date'];
        $time = str_replace(' ', '', $request['time']);
        $type_id = intval($request['type_id']);
        $subtype_id = intval($request['subtype_id']);

        if (!$timing_id) {
            header('Location: /');
        }

        $timing_obj = new Timing();
        $params = [
            'datetime' => $date . ' ' . $time,
            'type_id' => $type_id,
            'subtype_id' => $subtype_id,
            'timing_id' => $timing_id,
        ];
        $timing_obj->edit($params);

        header('Location: /');
    }

    public function delete()
    {
        // バリデーション
        $timing_id = intval($this->request['id']);

        // 取得
        $timing_obj = new Timing();
        $timing = $timing_obj->get(['timing_id' => $timing_id]);

        if (!$timing['timing_id']) {
            header('Location: /');
            exit;
        }

        $timing_obj = new Timing();
        $params = [
            'timing_id' => $timing_id,
        ];
        $timing_obj->delete($params);

        header('Location: /');
    }
}
