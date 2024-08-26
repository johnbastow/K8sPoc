# docker build . -t acrawdemo.azurecr.io/k8spoc-webapi
# docker run -ti --rm -p 8080:8080 acrawdemo.azurecr.io/k8spoc-webapi
# docker push acrawdemo.azurecr.io/k8spoc-webapi

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /App

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish --configuration Release --output out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /App
COPY --from=build-env /App/out .
EXPOSE 8080
ENTRYPOINT ["dotnet", "K8sPoc.WebApi.dll"]