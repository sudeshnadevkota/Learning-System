using System.Web.Mvc;
using System.Web.Routing;

namespace Learning_System
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            // 1. Tell MVC to ignore the exact root URL so it falls back to Default.aspx
            routes.IgnoreRoute("");

            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                // 2. REMOVE the default controller and action so it doesn't hijack the root URL
                defaults: new { id = UrlParameter.Optional }
            );
        }
    }
}