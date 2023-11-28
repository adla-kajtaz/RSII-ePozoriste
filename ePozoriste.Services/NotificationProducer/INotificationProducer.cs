using ePozoriste.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Services
{
    public interface INotificationProducer
    {
        public void SendingObject(KupovinaNotifikacija obj);
    }
}
