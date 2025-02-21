using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SitioMVC.Controllers
{
    public class HomeController : BaseController
    {        
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Other()
        {
            return View();
        }
    }
}