<?php

namespace app\models;

class Page
{
    public static function create($page, $page_size, $count, $query = [])
    {
        $page = $page ?: 1;
        $page_size = $page_size ?: 20;
        $page_first = max(1, $page - 4);
        $page_last = min(ceil($count / $page_size), $page + 4);

        $pager['count'] = $count;
        for ($i = $page_first; $i < $page_last; $i++) {
            $url = ($i == 1) ? './?' : './?page=' . $i . '&';
            if (count($query) > 1) {
                $url .= http_build_query($query);
            }
            $data = [
                'page' => $i,
                'this' => ($page == $i) ? true : false,
                'url' => $url,
            ];
            $pager['links'][] = $data;
        }

        return $pager;
    }
}
