<?php
    header("Content-type: application/json");

    $HOTE='mysql-genysix.alwaysdata.net';
    $NOM_BD='genysix_admin';
    $USER='genysix';
    $MDP='Pass1234';

    try{
        $connexion = new PDO('mysql:host='.$HOTE.';dbname='.$NOM_BD,$USER,$MDP);
    }catch(Exception $e){
        echo $e->getMessage()." code: ".$e->getCode();
        die();
    }
?>