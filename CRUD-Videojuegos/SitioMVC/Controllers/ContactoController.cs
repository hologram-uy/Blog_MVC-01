using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SitioMVC.Controllers
{
    public class ContactoController : BaseController
    {
        // GET: Contacto
        public ActionResult Index()
        {
            return View();
        }
    }
}