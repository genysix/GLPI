<?php
header("Content-type: application/json");
require_once('connexion.php');

// Ce que l'on recois depuis l'application
$objJson = json_decode(file_get_contents("php://input"))[0];
$pseudo= $objJson->pseudo;
$mdp = $objJson->mdp;

$sql = "SELECT * FROM Utilisateurs WHERE Username = :compte AND Password = :mdp";
$res = $connexion->prepare($sql);
$res->bindValue(':compte',$pseudo);
$res->bindValue(':mdp',$mdp);
$res->execute();
$res->SetFetchMode(PDO::FETCH_OBJ);
$ligne = $res->fetch();

if($ligne->fk_Statut == 1){
    $statut="Administrateur";
}else if($ligne->fk_Statut == 2){
    $statut="Technicien";
}else{
    $statut="Utilisateur";
}

echo '{"id":"'.$ligne->ID.'", "nom":"'.$ligne->Nom.'", "prenom":"'.$ligne->Prenom.'","pseudo":"'.$ligne->Username.'", "statut":"'.$statut.'"}';

?>