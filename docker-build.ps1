Param(
    [string]$WindowsVersion = "ltsc2022",
    [string]$TagVersion = "0.0.2"
) 

# Ensure you are authenticated to the ACR.
# If this fails, relogin to Azure using 'az login'.
az acr login --name acrawdemo

Write-Host "Switching Docker to Linux engine."
& "${env:ProgramFiles}\Docker\Docker\DockerCli.exe" -SwitchLinuxEngine

Write-Host "Building Linux console."
docker build .\K8sPoc.Console --file .\K8sPoc.Console\Dockerfile --tag acrawdemo.azurecr.io/k8spoc-console-linux:${TagVersion}
docker push acrawdemo.azurecr.io/k8spoc-console-linux:${TagVersion}

Write-Host "Building Linux web API client console."
docker build .\K8sPoc.ConsoleApiClient --file .\K8sPoc.ConsoleApiClient\Dockerfile --tag acrawdemo.azurecr.io/k8spoc-consoleapiclient-linux:${TagVersion}
docker push acrawdemo.azurecr.io/k8spoc-consoleapiclient-linux:${TagVersion}

Write-Host "Building Linux web API."
docker build .\K8sPoc.WebApi --file .\K8sPoc.WebApi\Dockerfile --tag acrawdemo.azurecr.io/k8spoc-webapi-linux:${TagVersion}
docker push acrawdemo.azurecr.io/k8spoc-webapi-linux:${TagVersion}

Write-Host "Switching Docker to Windows engine."
& "${env:ProgramFiles}\Docker\Docker\DockerCli.exe" -SwitchWindowsEngine

Write-Host "Building Windows console."
docker build .\K8sPoc.Console --file .\K8sPoc.Console\Dockerfile.Windows --build-arg WIN_VERSION=${WindowsVersion} --tag acrawdemo.azurecr.io/k8spoc-console-win-${WindowsVersion}:${TagVersion}
docker push acrawdemo.azurecr.io/k8spoc-console-win-${WindowsVersion}:${TagVersion}

Write-Host "Building Windows web API client console."
docker build .\K8sPoc.ConsoleApiClient --file .\K8sPoc.ConsoleApiClient\Dockerfile.Windows --build-arg WIN_VERSION=${WindowsVersion} --tag acrawdemo.azurecr.io/k8spoc-consoleapiclient-win-${WindowsVersion}:${TagVersion}
docker push acrawdemo.azurecr.io/k8spoc-consoleapiclient-win-${WindowsVersion}:${TagVersion}

Write-Host "Building Windows web API."
docker build .\K8sPoc.WebApi --file .\K8sPoc.WebApi\Dockerfile.Windows --build-arg WIN_VERSION=${WindowsVersion} --tag acrawdemo.azurecr.io/k8spoc-webapi-win-${WindowsVersion}:${TagVersion}
docker push acrawdemo.azurecr.io/k8spoc-webapi-win-${WindowsVersion}:${TagVersion}

