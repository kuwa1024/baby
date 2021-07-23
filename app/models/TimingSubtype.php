<?php

namespace app\models;

class TimingSubtype
{
    public function getList()
    {
        $sql = 'SELECT * FROM timing_subtype ORDER BY sort';
        return Db::query($sql);
    }
}
