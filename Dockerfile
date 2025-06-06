# Etapa 1 - Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS base
USER app
WORKDIR /app
EXPOSE 80

# Copia os arquivos da solution e restaura
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ./azul.sln ./
COPY ./ContaAzul/ContaAzul.csproj ./ContaAzul/
RUN dotnet restore ./ContaAzul/ContaAzul.csproj

# Copia o restante dos arquivos e publica
COPY . ./
WORKDIR /src/ContaAzul
RUN dotnet publish -c Release -o /app/publish

# Etapa 2 - Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 80
ENTRYPOINT ["dotnet", "ContaAzul.dll"]
