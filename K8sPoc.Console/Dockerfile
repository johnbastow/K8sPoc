# docker build . --tag acrawdemo.azurecr.io/k8spoc-console
# docker run acrawdemo.azurecr.io/k8spoc-console
# docker push acrawdemo.azurecr.io/k8spoc-console

# Use full .NET SDK image for build.
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /App

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore K8sPoc.Console.csproj
# Build and publish a release
RUN dotnet publish K8sPoc.Console.csproj --no-restore --configuration Release --output out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "K8sPoc.Console.dll"]