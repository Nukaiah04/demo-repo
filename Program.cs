var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "CI/CD Working Successfully in GCP 🚀");

app.MapGet("/health", () => "Healthy");

app.Run();