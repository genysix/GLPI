
-- Montre toutes les actions d'un ticket (Page ticket_show.php)
SELECT Statuts.Statut, Utilisateurs.Nom, Utilisateurs.Prenom, Utilisateurs.Username, Actions.Commentaire, TypeAction.Nom, Jours.Jours, Heures.Heures, Tickets.Titre, Etats.Etat, Urgences.Urgence, Pannes.Descritpion, Objets.Inventaire, Objets.Nom, Categories.Categorie, SoftHard.Type
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
AND CatSoftHard.ID = Tickets.fk_CatSoftHard


-- Montre tous les tickets d'un utilisateur (Page tickets_user_show.php)
SELECT Tickets.ID, Tickets.Titre, Etats.Etat, Urgences.Urgence
FROM Statuts, Utilisateurs, Actions, Tickets, Etats, Urgences
WHERE Utilisateurs.fk_Statut = Statuts.ID
AND Utilisateurs.ID = :id
AND Actions.fk_Utilisateurs = Utilisateurs.ID
AND Actions.fk_Tickets = Tickets.ID
AND Etats.ID = Tickets.fk_Etat
AND Urgences.ID = Tickets.fk_Urgence
GROUP BY Tickets.ID

-- Montre tous les tickets sauf résolus (Page waiting_tickets.php)
SELECT Tickets.ID, Tickets.Titre, Etats.Etat, Urgences.Urgence
FROM Statuts, Utilisateurs, Actions, Tickets, Etats, Urgences
WHERE Utilisateurs.fk_Statut = Statuts.ID
AND Utilisateurs.ID = Actions.fk_Utilisateurs
AND Actions.fk_Utilisateurs = Utilisateurs.ID
AND Actions.fk_Tickets = Tickets.ID
AND Etats.ID = Tickets.fk_Etat
AND Urgences.ID = Tickets.fk_Urgence
AND Etats.ID != 2
GROUP BY Tickets.ID

-- Montre tous les tickets résolus (Page solved_tickets.php)
SELECT Tickets.ID, Tickets.Titre, Etats.Etat, Urgences.Urgence
FROM Statuts, Utilisateurs, Actions, Tickets, Etats, Urgences
WHERE Utilisateurs.fk_Statut = Statuts.ID
AND Utilisateurs.ID = Actions.fk_Utilisateurs
AND Actions.fk_Utilisateurs = Utilisateurs.ID
AND Actions.fk_Tickets = Tickets.ID
AND Etats.ID = Tickets.fk_Etat
AND Urgences.ID = Tickets.fk_Urgence
AND Etats.ID = 2
GROUP BY Tickets.ID
-- Créer DateHeure
-- Créer Heure
-- Créer Date

-- Créer un ticket (Page create_tickets.php)
-- Créer Panne
INSERT INTO Pannes(Descritpion) VALUES (:description)
-- Créer Ticket
INSERT INTO  Tickets(Titre, fk_Etat, fk_Urgence, fk_CatSoftHard, fk_Panne, fk_Objet) VALUES (:titre, 5, :urgence, :catSoftHard, :panne, :objet)
-- Créer Action création
INSERT INTO Actions(Commentaire, fk_DateHeure, fk_utilisateurs, fk_TypeAction, fk_Tickets) VALUES (:commentaire, :dateheure, :utilisateur, 2, LAST_INSERT_ID())

-- Créer Action
SELECT LAST_INSERT_ID()
-- Recuperer ID dans variable pour passer plus loin
INSERT INTO Actions(Commentaire, fk_DateHeure, fk_utilisateurs, fk_TypeAction, fk_Tickets) VALUES (:commentaire, :dateheure, :utilisateur, :typeaction, :ID)



-- Gerer user page
-- Montre tous les utilisateurs (Page show_users.php)
SELECT Utilisateurs.Nom, Utilisateurs.Prenom, Utilisateurs.Username, Statuts.statut FROM Utilisateurs, Statuts WHERE Statuts.ID = Utilisateurs.fk_Statut

-- Modifier un utilisateur sans modif mot de passe (Page edit_user.php)
UPDATE Utilisateurs set Utilisateurs.nom=:nom, Utilisateurs.Prenom=:prenom, Utilisateurs.Username=:username, Utilisateurs.fk_Statut=:statut WHERE Utilisateurs.ID=:id

-- Modifier un utilisateur en resettant mot de passe 
UPDATE Utilisateurs set Utilisateurs.nom=:nom, Utilisateurs.Prenom=:prenom, Utilisateurs.Username=:username, Utilisateurs.Password="Pass1234", Utilisateurs.fk_Statut=:statut WHERE Utilisateurs.ID=:id

-- créer un utilisateur (Page create_user.php)
INSERT INTO Utilisateurs(Nom, Prenom, Username, Password, fk_Statut) VALUES (:nom, :prenom, :username, :password, :statut)

-- Créer objet
INSERT INTO Objets(Inventaire, Nom) VALUES(:inventaire, :nom)
-- drop user
Delete From Utilisateurs Where Utilisateurs.ID = :id