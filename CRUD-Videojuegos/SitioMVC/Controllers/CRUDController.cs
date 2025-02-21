using SitioMVC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.Mvc;

namespace SitioMVC.Controllers
{
    public class CRUDController : Controller
    {
        private readonly VideojuegosDBEntities db = new VideojuegosDBEntities();
        public ActionResult Listado()
        {
            try
            {
                List<Juegos> listado = db.Juegos.ToList();

                return View(listado);
            }
            catch (Exception ex)
            {
                return View($"Error: {ex.Message} - método {nameof(Listado)}");
            }
        }
    }
}