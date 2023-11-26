using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using ePozoriste.Model;

namespace ePozoriste
{
    public class ErrorFilter : ExceptionFilterAttribute
    {
        public override void OnException(ExceptionContext context)
        {
            if (context.Exception is KorisnikException)
            {
                context.ModelState.AddModelError(((KorisnikException)context.Exception).Title, context.Exception.Message);
                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
            }
            else if (context.Exception is RecommendationException)
            {
                context.ModelState.AddModelError("Recommendation", context.Exception.Message);
                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.UnprocessableEntity;
            }
            else if (context.Exception is SalaException)
            {
                context.ModelState.AddModelError(((SalaException)context.Exception).Title, context.Exception.Message);
                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
            }
            else
            {
                context.ModelState.AddModelError("Server", "Greska na serveru");
                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            }
            var errorsDictionary = context.ModelState.Where(m => m.Value.Errors.Count > 0).ToDictionary(m => m.Key, m => m.Value.Errors.Select(e => e.ErrorMessage).ToList());
            context.Result = new ObjectResult(new { Errors = errorsDictionary });
        }
    }
}
