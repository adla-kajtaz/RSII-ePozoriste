using EasyNetQ;
using ePozoriste.Model;
using ePozoriste.Subscriber;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.DependencyInjection;
using System.Runtime.InteropServices;
static IHostBuilder CreateHostBuilder() =>
    Host.CreateDefaultBuilder().ConfigureServices((hostContext, services) =>
    {
        services.AddHostedService<RabbitMQHostedService>();
    });

CreateHostBuilder().Build().Run();
public class RabbitMQHostedService : IHostedService
{
    private IBus _bus;
    private EmailService _service;
    private EmailSendGridService _sendGridService;


    public RabbitMQHostedService()
    {
        _service = new EmailService();
        _sendGridService = new EmailSendGridService();
        _bus = RabbitHutch.CreateBus("host=rabbitMQ");
        while (true)
        {
            try
            {
                _bus.PubSub.Subscribe<KupovinaNotifikacija>("Nova_kupovina", HandleTextMessage);
                Console.WriteLine("Subscribe successful,listening for messages.");
                break;
            }
            catch
            {
                Console.WriteLine("Subscribe failed,retrying...");
                Thread.Sleep(5000);
            }
        }
    }
    public Task StartAsync(CancellationToken cancellationToken)
    {
        return Task.CompletedTask;
    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        _bus.Dispose();
        //console log "Dispoing"
        Console.WriteLine("Stop async");
        return Task.CompletedTask;
    }
    private Task HandleTextMessage(KupovinaNotifikacija entity)
    {
        Console.WriteLine($"Purchase received: {entity?.KupovinaNotifikacijaId}, Predstava: {entity?.NazivPredstave}, Email: {entity.Email}");
        _sendGridService.Send("Nova kupovina", $"Kupili ste karte za predstavu {entity.NazivPredstave}.", entity.Email, entity.Email);
        _service.SendEmailAsync(entity.Email, "Nova kupovina na ePozoristu!", $"Kupili ste karte za predstavu {entity.NazivPredstave}.");
        return Task.CompletedTask;
    }
}