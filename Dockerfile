# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project file first
COPY DemoApp/*.csproj ./DemoApp/
RUN dotnet restore ./DemoApp/DemoApp.csproj

# Copy everything else
COPY . .
WORKDIR /src/DemoApp
RUN dotnet publish -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:8080
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "HealthcareApp.dll"]
