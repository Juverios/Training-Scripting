#!/bin/bash
########                                               #######
####                                                      ####
####     --   Script Machine à café Version 2  --         ####
####  --  Ajout de la gestion du sucre et des gobelets -- ####
####                                                      ####   
########                                              ########

# On déclare des variables globale pour stocker les choix de l'utilisateur
choix_gobelet=""
choix_sucre=""
boisson=""
# On crée une fonction pour gérer la quantité de sucre
sucre()
{
    # On demande à l'utilisateur s'il veut du sucre
    read -p "Voulez-vous du sucre ? (O/N) : " sucre
    # On vérifie la réponse de l'utilisateur
    if [[ $sucre = "O" || $sucre = "o" ]]; then
    # On demande à l'utilisateur combien de morceaux de sucre il veut
        read -p "Combien de morceaux de sucre voulez-vous ? (1-3) :" Nombre_sucre
    # On vérifie que le nombre de morceaux de sucre est valide
        if [[ $Nombre_sucre -ge 1 && $Nombre_sucre -le 3 ]]; then
            choix_sucre="avec $Nombre_sucre morceaux de sucre"
        # On vérifie si l'utilisateur a entré un nombre valide
        elif [[ $sucre -lt 1 || $sucre -gt 3 ]]; then
            echo "ERRREUR. Veuillez entrer un nombre valide (1-3)."
            # On relance la fonction pour demander à nouveau la quantité de sucre
            sucre
        fi
    elif  [[ $sucre = "N" || $sucre = "n" ]]; then
            choix_sucre="et sans sucre"
    else
            echo "ERRREUR. Veuillez choisir seulement avec (O/N)."
            # On relance la fonction pour demander à nouveau la quantité de sucre
            sucre
    fi
}
# On crée une fonction pour gérer les gobelets
gobelets()
{
    # On demande à l'utilisateur s'il veut un gobelet
    read -p "Voulez-vous un gobelet ? (O/N) : " gobelet
    # On vérifie la réponse de l'utilisateur
    if [[ $gobelet = "O" || $gobelet = "o" ]]; then
        choix_gobelet="avec gobelet"
    elif [[ $gobelet = "N" || $gobelet = "n" ]]; then
        choix_gobelet="sans gobelet"
    else
        echo "ERRREUR. Veuillez entrer O ou N."
        # On relance la fonction pour demander à nouveau le choix du gobelet
        gobelets
    fi
}
# On va créer un script interactif pour commander une boisson
# On va créer un menu avec 3 choix
Machine()
{
    echo "Bienvenue dans la machine à café !"
    echo "Que voulez-vous boire ?"
    echo "1. Café"
    echo "2. Thé"
    echo "3. Chocolat chaud"
    echo "4. Sortir"
    read -p "Entrez votre choix (1-4) : " choix
    # On va effectuer une action en fonction du choix de l'utilisateur
    case $choix in 
        1)
            boisson="café"
            # On demande à l'utilisateur s'il veut du sucre en appelant la fonction "sucre"
            sucre
            # On demande à l'utilisateur s'il veut un gobelet en appelant la fonction "gobelets"
            gobelets
            # Message de confirmation de la boisson
            echo  "Vous avez choisi un $boisson $choix_gobelet $choix_sucre ! Bonne dégustation !"
            exit 0
            ;;
        2)  
            boisson="thé"
            # On demande à l'utilisateur s'il veut du sucre en appelant la fonction "sucre"
            sucre
            # On demande à l'utilisateur s'il veut un gobelet en appelant la fonction "gobelets"
            gobelets
            # Message de confirmation de la boisson
            echo  "Vous avez choisi un $boisson $choix_gobelet $choix_sucre ! Bonne dégustation !"
            exit 0
            ;;
        3)
            boisson="chocolat chaud"
            # On demande à l'utilisateur s'il veut du sucre en appelant la fonction "sucre"
            sucre
            # On demande à l'utilisateur s'il veut un gobelet en appelant la fonction "gobelets"
            gobelets
            # Message de confirmation de la boisson
            # On affiche un message qui résume le choix de l'utilisateur
            echo "Vous avez choisi un $boisson $choix_gobelet $choix_sucre ! Bonne dégustation !"
            exit 0
            ;;
        4)
            # Message de confirmation de sortie
            echo "Merci d'avoir utilisé la machine à café ! À bientôt !"
            exit 0
            ;;
        *)
            # Si l'utilisateur entre un choix invalide, on affiche un message d'erreur
            echo "ERRREUR. Veuillez entrer un choix valide (1-4)."
            # On va relancer la fonction pour afficher le menu
            Machine
            ;;
    esac
}
# On va appeler la fonction pour afficher le menu
Machine
