# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# 1. Copy EVERYTHING from the repo
COPY . .

# 2. Automatically find and publish the project file 
# This fixes MSB1003 by ensuring the command points directly to the file
RUN dotnet publish *.csproj -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

COPY --from=build /app/publish .

# Ensure this matches your project filename (DemoApp.dll)
ENTRYPOINT ["dotnet", "DemoApp.dll"]
