<?php
header("Content-type: application/json");
require_once('connexion.php');

$objJson = json_decode(file_get_contents("php://input"))[0];
$id = $objJson->id; 
    //Affiche les tickets des user
$sql = "SELECT Tickets.ID, Tickets.Titre, Etats.Etat, Urgences.Urgence
FROM Statuts, Utilisateurs, Actions, Tickets, Etats, Urgences
WHERE Utilisateurs.fk_Statut = Statuts.ID
AND Utilisateurs.ID = :id
AND Actions.fk_Utilisateurs = Utilisateurs.ID
AND Actions.fk_Tickets = Tickets.ID
AND Etats.ID = Tickets.fk_Etat
AND Urgences.ID = Tickets.fk_Urgence
GROUP BY Tickets.ID";

    $res = $connexion->prepare($sql);
    $res->bindValue(':id',$id);
    $res->execute();

    $tab = array();
    $i=0;
    $num = $res->rowCount();
    
    while($ligne = $res->fetch(PDO::FETCH_ASSOC)){
        foreach($ligne AS $key => $value){
            $tab[$i][$key] = strval(utf8_encode($value));
        }
        $i++;
    }
    echo json_encode($tab);
?>