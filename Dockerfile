# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# 1. Copy everything from your GitHub repo
COPY . .

# 2. DEBUG: This will print your file structure to the logs 
# so we can see where the .csproj actually is!
RUN ls -R

# 3. Build using the project name directly. 
# Based on your previous code, it should be in DemoApp/
RUN dotnet publish "DemoApp/DemoApp.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

COPY --from=build /app/publish .

# 4. Final DLL Check
# If your project is DemoApp.csproj, the output is DemoApp.dll
ENTRYPOINT ["dotnet", "DemoApp.dll"]
