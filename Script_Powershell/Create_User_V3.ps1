$CSVFile = "C:\\Scripts\\EcoTechSolutions-User.csv"
$CSVData = Import-CSV -Path $CSVFile -Delimiter ";" -Encoding UTF8

# Mappage des départements vers leurs OUs
$ouMapping = @{
    "Commercial"     = "OU=Commercial,OU=Services,DC=ECOTECHSOLUTION,DC=LAN"
    "Comptabilité"   = "OU=Comptabilite,OU=Services,DC=ECOTECHSOLUTION,DC=LAN"
    "Informatique"   = "OU=Informatique,OU=Services,DC=ECOTECHSOLUTION,DC=LAN"
    "Ressources Humaines" = "OU=RH,OU=Services,DC=ECOTECHSOLUTION,DC=LAN"
    # Ajoute ici d'autres départements si nécessaire
}

foreach ($Utilisateur in $CSVData) {
    $UtilisateurPrenom = $Utilisateur.Prenom.Trim()
    $UtilisateurNom = $Utilisateur.Nom.Trim()
    $UtilisateurMotDePasse = "Azerty1*"
    $UtilisateurLogin = ($UtilisateurPrenom).Substring(0,1).ToLower() + "." + $UtilisateurNom.ToLower()
    $Departement = $Utilisateur.Departement.Trim()

    # Vérifier que le département a bien une OU correspondante
    if ($ouMapping.ContainsKey($Departement)) {
        $OUPath = $ouMapping[$Departement]

        # Vérifier si l'utilisateur existe déjà
        if (Get-ADUser -Filter {SamAccountName -eq $UtilisateurLogin}) {
            Write-Warning "L'identifiant $UtilisateurLogin existe déjà dans l'AD"
        } else {
            New-ADUser -Name "$UtilisateurPrenom $UtilisateurNom" `
                       -DisplayName "$UtilisateurPrenom $UtilisateurNom" `
                       -GivenName $UtilisateurPrenom `
                       -Surname $UtilisateurNom `
                       -SamAccountName $UtilisateurLogin `
                       -UserPrincipalName "$UtilisateurLogin@ecotechsolution.lan" `
                       -Path $OUPath `
                       -AccountPassword (ConvertTo-SecureString $UtilisateurMotDePasse -AsPlainText -Force) `
                       -ChangePasswordAtLogon $true `
                       -Enabled $true

            Write-Output "Création de l'utilisateur : $UtilisateurLogin ($UtilisateurNom $UtilisateurPrenom) dans $Departement"
        }
    } else {
        Write-Warning "Aucune OU trouvée pour le département '$Departement'. Utilisateur $UtilisateurLogin non créé."
    }
}
