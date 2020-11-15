mkdir c:\flowfinity_artifacts
curl https://azrflowfinitynonprod.blob.core.windows.net/actions-versions/FlowfinityActions_20.1_20.1.3741.zip -o c:\flowfinity_artifacts\flowfinity_actions.zip
Install-WindowsFeature -name Web-Server -IncludeManagementTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment
$smtp = get-WindowsFeature "smtp-server"
add-WindowsFeature $smtp
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install dotnetfx -A
New-NetFirewallRule -DisplayName “HTTP” -Direction Inbound -Action Allow -Protocol TCP -LocalPort 80
New-NetFirewallRule -DisplayName “SMTP” -Direction Inbound -Action Allow -Protocol TCP -LocalPort 25
New-NetFirewallRule -DisplayName “SMTP” -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8002
New-NetFirewallRule -DisplayName “SMTP” -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8102
New-NetFirewallRule -DisplayName “SMTP” -Direction Inbound -Action Allow -Protocol TCP -LocalPort 7890
add-windowsfeature web-asp-net
add-windowsfeature Net-Framework-45-Core
install-windowsfeature AD-Domain-Services