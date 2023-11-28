// See https://aka.ms/new-console-template for more information

using EasyNetQ;
using ePozoriste.Model;
using ePozoriste.Subscriber;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System.Text;

Console.WriteLine("Hello, World!");

/*var factory = new ConnectionFactory { HostName = "localhost" };
using var connection = factory.CreateConnection();
using var channel = connection.CreateModel();

channel.QueueDeclare(queue: "nova_kupovina",
                     durable: false,
                     exclusive: false,
                     autoDelete: false,
                     arguments: null);

Console.WriteLine(" [*] Waiting for messages.");

var consumer = new EventingBasicConsumer(channel);
consumer.Received += (model, ea) =>
{
    var body = ea.Body.ToArray();
    var message = Encoding.UTF8.GetString(body);
    Console.WriteLine($" [x] Received {message}");
};
channel.BasicConsume(queue: "nova_kupovina",
                     autoAck: true,
                     consumer: consumer);

Console.WriteLine(" Press [enter] to exit.");
Console.ReadLine();*/

try
{
    using (var bus = RabbitHutch.CreateBus("host=localhost"))
    {
        bus.PubSub.Subscribe<KupovinaNotifikacija>("Nova_kupovina", HandleTextMessage);
        Console.WriteLine("Listening for messages. Hit <return> to quit.");
        Console.ReadLine();
    }
}
catch (Exception ex)
{
    Console.WriteLine($"Exception during RabbitMQ setup: {ex}");
}

async Task HandleTextMessage(KupovinaNotifikacija entity)
{
    Console.WriteLine($"Purchase received: {entity?.KupovinaNotifikacijaId}, {entity?.NazivPredstave}");
    EmailService emailService = new EmailService();
    await emailService.SendEmailAsync(entity.Email, "Nova kupovina na ePozoristu!", $"Kupili ste karte za predstavu {entity.NazivPredstave}.");

}
