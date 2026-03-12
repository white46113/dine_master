<?php 
if (!defined('BASEPATH')) exit('No direct script access allowed');  
 
if (file_exists(__DIR__ . '/dompdf/autoload.inc.php')) {
    require_once __DIR__ . '/dompdf/autoload.inc.php';
    class Pdf extends Dompdf\Dompdf
    {
        public function __construct()
        {
             parent::__construct();
        } 
    }
} else {
    class Pdf
    {
        public function __construct() { }
        public function __call($name, $arguments) {
            log_message('error', "Pdf library: dompdf not found. Cannot call $name.");
        }
        public static function __callStatic($name, $arguments) {
            log_message('error', "Pdf library: dompdf not found. Cannot call static $name.");
        }
    }
}

?>