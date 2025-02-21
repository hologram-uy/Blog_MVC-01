using System;
using System.Web.Mvc;
using System.Data.Entity;
using SitioMVC.Models;

namespace SitioMVC.Controllers
{
    public abstract class BaseController : Controller
    {
        protected readonly VideojuegosDBEntities db;

        public BaseController()
        {
            db = new VideojuegosDBEntities();
        }

        protected override void Dispose(bool disposing)
        {
            if(disposing)
            {
                db.Dispose();
            }

            base.Dispose(disposing);
        }
    }
}