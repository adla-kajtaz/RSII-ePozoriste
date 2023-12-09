using EasyNetQ;
using ePozoriste.Model;
using ePozoriste.Subscriber;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.DependencyInjection;
static IHostBuilder CreateHostBuilder(string[] args) =>
    Host.CreateDefaultBuilder(args).ConfigureServices((hostContext, services) =>
    {
        services.AddHostedService<RabbitMQHostedService>();
    });

CreateHostBuilder(args).Build().Run();
public class RabbitMQHostedService : IHostedService
{
    private IBus _bus;
    private EmailService _service;

    public RabbitMQHostedService()
    {
        _service = new EmailService();
        _bus = RabbitHutch.CreateBus("host=rabbitMQ");
    }
    public Task StartAsync(CancellationToken cancellationToken)
    {
        _bus.PubSub.Subscribe<KupovinaNotifikacija>("Nova_kupovina", HandleTextMessage);
        Console.WriteLine("Listening for messages.");
        return Task.CompletedTask;
    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        _bus.Dispose();
        return Task.CompletedTask;
    }

    private Task HandleTextMessage(KupovinaNotifikacija entity)
    {
        Console.WriteLine($"Purchase received: {entity?.KupovinaNotifikacijaId}, Predstava: {entity?.NazivPredstave}, Email: {entity.Email}");
        _service.SendEmailAsync(entity.Email, "Nova kupovina na ePozoristu!", $"Kupili ste karte za predstavu {entity.NazivPredstave}.");
        return Task.CompletedTask;
    }
}