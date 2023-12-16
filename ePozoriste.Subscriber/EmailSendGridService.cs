﻿using SendGrid;
using SendGrid.Helpers.Mail;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePozoriste.Subscriber
{
    public class EmailSendGridService
    {
        private readonly string _apiKey;
        private readonly SendGridClient _client;
        private readonly EmailAddress _fromAddress;

        public EmailSendGridService()
        {
            _apiKey = "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"; //Add apiKey
            _client = new SendGridClient(_apiKey);
            _fromAddress = new EmailAddress("epozoriste@outlook.com", "epozoriste");
        }
        public async Task Send(string subject, string body, string toAddress, string name)
        {
            var to = new EmailAddress(toAddress, name);
            var plainTextContent = "and easy to do anywhere, even with C#";
            var msg = MailHelper.CreateSingleEmail(_fromAddress, to, subject, plainTextContent, body);
            await _client.SendEmailAsync(msg).ConfigureAwait(false);
        }
    }
}
