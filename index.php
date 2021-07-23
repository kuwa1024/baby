<?php
require_once __DIR__ . '/vendor/autoload.php';
require_once __DIR__ . '/configs/config.php';

$dispatcher = FastRoute\simpleDispatcher(function (FastRoute\RouteCollector $r) {
    $r->addRoute('GET', '/', 'app\controllers\BabyController@index');
    $r->addRoute('POST', '/add', 'app\controllers\BabyController@add');
    $r->addRoute('GET', '/edit/{id:\d+}', 'app\controllers\BabyController@edit');
    $r->addRoute('POST', '/edit/{id:\d+}', 'app\controllers\BabyController@update');
    $r->addRoute('GET', '/delete/{id:\d+}', 'app\controllers\BabyController@delete');
});

$httpMethod = $_SERVER['REQUEST_METHOD'];
$uri = $_SERVER['REQUEST_URI'];

if (false !== $pos = strpos($uri, '?')) {
    $uri = substr($uri, 0, $pos);
}
$uri = rawurldecode($uri);

$routeInfo = $dispatcher->dispatch($httpMethod, $uri);
switch ($routeInfo[0]) {
    case FastRoute\Dispatcher::NOT_FOUND:
        header($_SERVER['SERVER_PROTOCOL'] . ' 404 Not Found');
        break;
    case FastRoute\Dispatcher::FOUND:
        $handler = $routeInfo[1];
        $targets = explode('@', $handler);
        $vars = array_merge((array)$_REQUEST, (array)$routeInfo[2]);
        $action = new $targets[0]($vars);
        call_user_func([$action, $targets[1]]);
        break;
}
