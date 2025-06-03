$CSVFile = "C:\Scripts\Utilisateurs.csv"
$CSVData = Import-CSV -Path $CSVFile -Delimiter ";" -Encoding UTF8

Foreach ($Utilisateur in $CSVData) {

    $UtilisateurPrenom = $Utilisateur.Prenom
    $UtilisateurNom = $Utilisateur.Nom
    $Departement = $Utilisateur.Departement
    $Service = $Utilisateur.Service
    $UtilisateurMotDePasse = "Azerty1*"
    $UtilisateurLogin = ($UtilisateurPrenom).Substring(0, 1) + "." + $UtilisateurNom

    # Chemin dynamique pour le placement des utilisateurs dans les OU
    $OUPath = "OU=$Departement,OU=$Service,DC=ECOTECHSOLUTION,DC=LAN"

    # Vérifier la présence de l'utilisateur dans l'AD
    if (Get-ADUser -Filter { SamAccountName -eq $UtilisateurLogin }) {
        Write-Warning "L'identifiant $UtilisateurLogin existe d�ja� dans l'AD"
    }
    else {
        New-ADUser -Name "$UtilisateurPrenom $UtilisateurNom" `
            -DisplayName "$UtilisateurPrenom $UtilisateurNom" `
            -GivenName $UtilisateurPrenom `
            -Surname $UtilisateurNom `
            -UserPrincipalName $UtilisateurLogin `
            -Path $OUPath `
            -AccountPassword(ConvertTo-SecureString $UtilisateurMotDePasse -AsPlainText -Force) `
            -ChangePasswordAtLogon $true `
            -Enabled $true

        Write-Output "Cr�ation de l'utilisateur : $UtilisateurLogin ($UtilisateurNom $UtilisateurPrenom)"
    }
}
