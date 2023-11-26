using Stripe;
using Microsoft.Extensions.Configuration;

namespace ePozoriste.Services
{
    public class StripeService
    {
		private readonly string apiKey;
		public StripeService(IConfiguration configuration)
		{
			apiKey = configuration["StripeSettings:ApiKey"] ?? Environment.GetEnvironmentVariable("STRIPE_API_KEY");
		}
		public string KreirajKupoivnu(int iznos, string opis)
		{
			StripeConfiguration.ApiKey = apiKey;
			var options = new PaymentIntentCreateOptions
			{
				Amount = iznos * 100,
				Currency = "EUR",
				Description = opis,
			};
			var service = new PaymentIntentService();
			var paymentIntent = service.Create(options);

			return paymentIntent.ClientSecret;
		}
	}
}
