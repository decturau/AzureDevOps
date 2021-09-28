$organization = '' #Found in the URL after dev.azure.com
$Project = ''  #Found in the URL after the org
$Repo = '' #Name of repo. Found in URL after _git or check the repo name from the portal
$Provider = 'TfsGit' #Git uses TfsGit. 
$Path = '/file.conf' #Name of file you want to retrieve. Can be found in the URL after path=
$Branch = 'main' #Git branch name
$TokenUser = '' #Anything can be put here
$Token = '' #Personal Access Token generated in the DevOps portal 
$creds = "$($TokenUser):$($Token)"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$basicAuthHeader = "Basic $encodedCreds" #Sets header value for basic auth 
$Headers = @{
    Authorization = $basicAuthHeader
}

#Compose URL
$URL = "https://dev.azure.com/$organization/$project/_apis/sourceProviders/$Provider/filecontents?repository=$Repo&path=$Path&commitOrBranch=$Branch&api-version=5.0-preview.1" 

#Get Raw content
(Invoke-WebRequest -Uri $URL -Headers $headers).Content
