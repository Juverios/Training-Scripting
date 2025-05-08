#!/bin/bash
########                                 #######
####                                        ####
####    Script Machine à café Version 1     ####
####                                        ####
########                                ########

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
            # Message de confirmation de la boisson
            echo "Vous avez choisi un café ! Bonne dégustation !"
            exit 0
            ;;
        2)  
            # Message de confirmation de la boisson
            echo "Vous avez choisi un thé ! Bonne dégustation !"
            exit 0
            ;;
        3)
            # Message de confirmation de la boisson
            echo "Vous avez choisi un chocolat chaud ! Bonne dégustation !"
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
