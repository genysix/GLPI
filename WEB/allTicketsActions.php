<?php
header("Content-type: application/json");
require_once('connexion.php');

$objJson = json_decode(file_get_contents("php://input"))[0];
$id = $objJson->id; 

    //Affiche les tickets des user
$sql = "SELECT Statuts.Statut, Utilisateurs.Nom, Utilisateurs.Prenom, Utilisateurs.Username, Actions.Commentaire, TypeAction.Nom, Jours.Jours, Heures.Heures, Tickets.Titre, Etats.Etat, Urgences.Urgence, Pannes.Descritpion, Objets.Inventaire, Objets.Nom, Categories.Categorie, SoftHard.Type
FROM Statuts, Utilisateurs, Actions, TypeAction, Jours, Heures, DateHeures, Tickets, Etats, Urgences, Pannes, Objets, CatSoftHard, Categories, SoftHard
WHERE Utilisateurs.fk_Statut = Statuts.ID
AND Utilisateurs.ID = Actions.fk_Utilisateurs
AND TypeAction.ID = Actions.fk_TypeAction
AND DateHeures.ID = Actions.fk_DateHeure
AND Actions.fk_Tickets = Tickets.ID
AND Jours.ID = DateHeures.fk_Jours
AND Heures.ID = DateHeures.fk_Heures
AND Tickets.ID = :id
AND Etats.ID = Tickets.fk_Etat
AND Urgences.ID = Tickets.fk_Urgence
AND Pannes.ID = Tickets.fk_Panne
AND Objets.ID = Tickets.fk_Objet
AND Categories.ID = CatSoftHard.fk_Categories
AND SoftHard.ID = CatSoftHard.fk_SoftHard
AND CatSoftHard.ID = Tickets.fk_CatSoftHard";

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