<?php
define('BASEPATH', __DIR__ . '/system/');
define('APPPATH', __DIR__ . '/application/');

require_once APPPATH . 'third_party/smarty/libs/Smarty.class.php';
$smarty = new Smarty();
echo "Compile Dir: " . $smarty->getCompileDir() . "\n";
echo "Cache Dir: " . $smarty->getCacheDir() . "\n";
