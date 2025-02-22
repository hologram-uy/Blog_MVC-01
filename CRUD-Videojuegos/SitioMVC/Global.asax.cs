using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace SitioMVC
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }

        protected void Application_Error()
        {
            var exception = Server.GetLastError();

            if (exception is HttpException httpException)
            {
                if (httpException.GetHttpCode() == 404)
                {
                    Response.Clear();
                    Server.ClearError();
                    Response.Redirect("~/Error/NotFound");
                }
            }
        }
    }
}
