using EasyNetQ;
using ePozoriste.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Services
{
    public class NotificationProducer : INotificationProducer
    {
        private readonly string hostname = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitMQ";
        private readonly string username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest";
        private readonly string password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest";
        private readonly string virtualHost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

        public void SendingObject(KupovinaNotifikacija obj)
        {
            using var bus = RabbitHutch.CreateBus($"host={hostname};virtualHost={virtualHost};username={username};password={password}");

            bus.PubSub.Publish(obj);
        }
    }
}
