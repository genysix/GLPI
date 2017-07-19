<?php
header("Content-type: application/json");
require_once('connexion.php');
    //Affiche les tickets des user
    $sql = "SELECT Utilisateurs.id, Utilisateurs.Nom, Utilisateurs.Prenom, Utilisateurs.Username, Statuts.statut FROM Utilisateurs, Statuts WHERE Statuts.ID = Utilisateurs.fk_Statut";
    $res = $connexion->prepare($sql);
    $res->execute();

$tab = array();
$i=0;
$num = $res->rowCount();
//Test si au moin une ligne a étéprise dans la base de donnée
if($num > 0){
    $erreur=0;
}else{
    $erreur=1;
}
while($ligne = $res->fetch(PDO::FETCH_ASSOC)){
    foreach($ligne AS $key => $value){
        $tab[$i][$key] = strval(utf8_encode($value));
    }
    $i++;
}
echo json_encode($tab);
?>