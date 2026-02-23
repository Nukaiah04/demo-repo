var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/devops", () => "DevOps Practice Endpoint 🚀");
app.MapGet("/health", () => "Healthy");

// 🔥 New Feature Endpoint (Only in feature branch)
app.MapGet("/feature-info", () =>
{
    return new
    {
        Project = "Simple Project",
        Environment = "Feature Branch",
        Status = "Working",
        Time = DateTime.Now
    };
});

app.Run();
