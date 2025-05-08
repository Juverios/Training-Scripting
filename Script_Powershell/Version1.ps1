########                                 #######
####                                        ####
####    Script Machine à café Version 1     ####
####                                        ####
########                                ########

# On va créer un script interactif pour commander une boisson
# On va créer un menu avec 3 choix
function Machine 
{
Clear-Host
    # On va créer le menu avec une boucle while tant que l'utilisateur choisi un choix valide
    While ($true) 
    {
        Write-Host "Bienvenue dans la machine à café !"
        Write-Host "1. Café"
        Write-Host "2. Thé"
        Write-Host "3. Chocolat chaud"
        Write-Host "4. Quitter"
        $choix = Read-Host "Veuillez entrer votre choix (1-4)"
        # On affiche un message en fonction du choix de l'utilisateur
        switch ($choix) 
        {
            1 { 
                Write-Host "Vous avez choisi un café. Bonne dégustation !" 
                exit
            }
            2 { 
                Write-Host "Vous avez choisi un thé. Bonne dégustation !"
                exit 
            }
            3 { 
                Write-Host "Vous avez choisi un chocolat chaud. Bonne dégustation !"
                exit
            }
            4 { 
                Write-Host "Merci d'avoir utilisé la machine à café !"; 
                exit 
            }
            default 
            { 
                Write-Host "Choix invalide, veuillez réessayer." 
            } 
        }
    }
}
Machine
