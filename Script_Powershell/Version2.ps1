########                                 #######
####                                        ####
####    Script Machine à café Version 1     ####
####                                        ####
########                                ########

# On va créer un script interactif pour commander une script:boisson

### On déclare les variables dans le script 
$script:boisson = ""
$script:Choix_Sucre = ""
$script:Choix_Gobelet = ""

### On crée la fonction pour gérer le sucre
function Sucre {
    # On créer la demande pour le choix du sucre
    $choix = Read-Host "Voulez-vous du sucre ? (O/N)"
    # On vérifie si le choix est O on ajoute du sucre 
    if ($choix -match '^[Oo]$') {
        # On créer la demande pour le nombre de sucre
        $Nombre_Sucre = Read-Host "Combien voulez-vous de sucre ? (1-3)"
        # On vérifie si le choix est valide
        if ($Nombre_Sucre -match "^[1-3]$") {
            # Si le choix est valide, on l'enregistre dans la variable
            $script:Choix_Sucre = "$Nombre_Sucre sucre"
        } 
        else {
            Write-Host "Erreur ...  veuillez choisir un nombre valide (1-3)."
            # On relance la fonction si le choix est invalide
            Sucre
        }
        # On vérifie si le choix est N on ne met pas de sucre
    } 
    elseif ($choix -match '^[Nn]$') {
        $script:Choix_Sucre = "sans sucre"
    }
    else {
        Write-Host "Choix invalide, veuillez choisir "O" ou "N"."
        # On relance la fonction si le choix est invalide
        Sucre
    }
}

### On crée la fonction pour gérer les goblets
function Gobelets {
    # On créer la demande pour le choix du gobelet
    $choix = Read-Host "Voulez-vous un gobelet ? O/N"
    # On vérifie si le choix est O on ajoute un gobelet
    if ($choix -match "^[Oo]$") {
        $script:Choix_Gobelet = "avec gobelet"
    }
    # On vérifie si le choix est N on ne met pas de gobelet
    elseif ($choix -match "^[Nn]$") {
        $script:Choix_Gobelet = "sans gobelet"
    } 
    else {
        # On affiche un message d'erreur si le choix est invalide
        Write-Host "Erreur... veuillez répondre par O ou N."
        # On relance la fonction si le choix est invalide
        Gobelets
    }
}
### On va créer un menu avec 3 choix dans une fonction
function Machine {
    Clear-Host
    # On créer le menu avec 3 choix
    Write-Host "Bienvenue dans la machine à café !"
    Write-Host "1. Café"
    Write-Host "2. Thé"
    Write-Host "3. Chocolat chaud"
    Write-Host "4. Quitter"
    $choix = Read-Host "Veuillez entrer votre choix (1-4)"
    # On affiche un message en fonction du choix de l'utilisateur
    switch ($choix) {
        1 { 
            $script:boisson = "Café" 
            # On appelle la fonction pour le sucre
            Sucre
            # On appelle la fonction pour le gobelet
            Gobelets
            # On résume la commande de l'utilisateur
            Write-Host "Vous avez commandé un $script:boisson $script:Choix_Sucre $script:Choix_Gobelet."
        }
        2 {
            $script:boisson = "Thé"
            # On appelle la fonction pour le sucre
            Sucre
            # On appelle la fonction pour le gobelet
            Gobelets 
            # On résume la commande de l'utilisateur
            Write-Host "Vous avez commandé un $script:boisson $script:Choix_Sucre $script:Choix_Gobelet."
        }
        3 {
            $script:boisson = "Chocolat chaud" 
            # On appelle la fonction pour le sucre
            Sucre
            # On appelle la fonction pour le gobelet
            Gobelets
            # On résume la commande de l'utilisateur
            Write-Host "Vous avez commandé un $script:boisson $script:Choix_Sucre $script:Choix_Gobelet."
        }
        4 { 
            Write-Host "Merci d'avoir utilisé la machine à café !" 
            exit 
        }
        default {
            Write-Host "Erreur... veuillez entrer un choix valide."
            # On relance la fonction si le choix est invalide
            sleep 1
            Machine
        }
    }
}

Machine