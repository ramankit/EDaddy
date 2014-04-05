<?php

    $base_dir="http://localhost/edaddy/includes";
   // echo $_SERVER["SERVER_ADDR"];

    $bootstrap_path=$base_dir.'/bootstrap/bootstrap/css/bootstrap.css';
    $jquery_path=$base_dir.'/bootstrap/js/jquery-2.0.3.min.js';
    $jsplugins=$base_dir.'/bootstrap/js/bootstrap.min.js';
    $flat_ui=$base_dir.'/bootstrap/css/flat-ui.css';
    $yamm=$base_dir.'/bootstrap/yamm/yamm.css';

    echo '<link rel="stylesheet" href="'.$bootstrap_path.'" >';
    echo "\n\t";

    echo '<link rel="stylesheet" href="'.$flat_ui.'" >';
    echo "\n\t";

    echo '<link rel="stylesheet" href="'.$yamm.'" >';
    echo "\n\t";

    echo '<script src="'.$jquery_path.'"></script>';
    echo "\n\t";

    echo '<script src="'.$jsplugins.'"></script>';
    echo "\n\t";

?>