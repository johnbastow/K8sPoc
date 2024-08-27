# docker build . --tag acrawdemo.azurecr.io/k8spoc-consoleapiclient
# docker run -e WEB_API_HOST=www.microsoft.com acrawdemo.azurecr.io/k8spoc-consoleapiclient
# docker push acrawdemo.azurecr.io/k8spoc-consoleapiclient

# Use full .NET SDK image for build.
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /App

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore K8sPoc.ConsoleApiClient.csproj
# Build and publish a release
RUN dotnet publish K8sPoc.ConsoleApiClient.csproj --no-restore --configuration Release --output out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "K8sPoc.ConsoleApiClient.dll"]