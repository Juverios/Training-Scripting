$CSVFile = "C:\\Scripts\\EcoTechSolutions-User.csv"
$CSVData = Import-CSV -Path $CSVFile -Delimiter ";" -Encoding UTF8

foreach ($Utilisateur in $CSVData) {
    $Prenom = $Utilisateur.Prenom
    $Nom = $Utilisateur.Nom
    $Departement = $Utilisateur.Departement
    $Service = $Utilisateur.Service
    $ManagerPrenom = $Utilisateur.'Manager-Prenom'
    $ManagerNom = $Utilisateur.'Manager-Nom'
    $MotDePasse = "Azerty1*"
    $UtilisateurLogin = ($Prenom).Substring(0, 1) + "." + $Nom.ToLower()
    $OUPath = "OU=$Departement,OU=$Service,DC=ECOTECHSOLUTION,DC=LAN"

    # Création OU si nécessaire
    if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$OUPath'" -ErrorAction SilentlyContinue)) {
        $OU_Dep = "OU=$Departement,OU=Services,DC=ECOTECHSOLUTION,DC=LAN"
        if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$OU_Dep'" -ErrorAction SilentlyContinue)) {
            New-ADOrganizationalUnit -Name $Departement -Path "OU=Services,DC=ECOTECHSOLUTION,DC=LAN"
            Write-Host "Création de l'OU Département : $Departement"
        }
        New-ADOrganizationalUnit -Name $Service -Path $OU_Dep
        Write-Host "Création de l'OU Service : $Service dans $Departement"
    }

    # Préparer le nom du manager
    $ManagerLogin = ""
    $ManagerDN = $null
    if ($ManagerPrenom -and $ManagerNom) {
        $ManagerLogin = ($ManagerPrenom).Substring(0, 1) + "." + $ManagerNom
        $ManagerUser = Get-ADUser -Filter { SamAccountName -eq $ManagerLogin } 
        if (-not $ManagerUser) {
            # Créer un compte manager s’il n’existe pas
            New-ADUser -Name "$ManagerPrenom $ManagerNom" `
                -DisplayName "$ManagerPrenom $ManagerNom" `
                -GivenName $ManagerPrenom `
                -Surname $ManagerNom `
                -SamAccountName $ManagerLogin `
                -UserPrincipalName "$ManagerLogin@ecotechsolution.lan" `
                -Path $OUPath `
                -AccountPassword (ConvertTo-SecureString $MotDePasse -AsPlainText -Force) `
                -ChangePasswordAtLogon $true `
                -Enabled $true
            Write-Host "Création du manager : $ManagerLogin"
        }
        $ManagerUser = Get-ADUser -Filter { SamAccountName -eq $ManagerLogin }
        $ManagerDN = $ManagerUser.DistinguishedName
    }

    # Vérifier si l'utilisateur existe déjà
    if (Get-ADUser -Filter { SamAccountName -eq $L }) {
        Write-Warning "L'identifiant $L existe déjà dans l'AD"
    }
    else {
        # Créer l’utilisateur
        New-ADUser -Name "$Prenom $Nom" `
            -DisplayName "$Prenom $Nom" `
            -GivenName $Prenom `
            -Surname $Nom `
            -SamAccountName $L `
            -UserPrincipalName "$L@ecotechsolution.lan" `
            -Path $OUPath `
            -AccountPassword (ConvertTo-SecureString $MotDePasse -AsPlainText -Force) `
            -ChangePasswordAtLogon $true `
            -Enabled $true

        Write-Host "Utilisateur $L ($Nom $Prenom) créé dans $OUPath"
    }

    # On Associe le manager au nouvel utilisateur
    if ($ManagerDN) {
        try {
            Set-ADUser -Identity $L -Manager $ManagerDN
            Write-Host "Manager $ManagerLogin assigné à $L"
        }
        catch {
            Write-Warning "Impossible d’assigner le manager pour $L"
        }
    }
}
