# ========================
# Build Stage
# ========================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY . .

# 👇 specify correct folder name
RUN dotnet publish DemoApp/DemoApp.csproj -c Release -o /app/publish /p:UseAppHost=false

# ========================
# Runtime Stage
# ========================
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "DemoApp.dll"]
