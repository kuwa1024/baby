<?php

namespace app\models;

class TimingType
{
    public function getList()
    {
        $sql = 'SELECT * FROM timing_type ORDER BY sort';
        return Db::query($sql);
    }
}
