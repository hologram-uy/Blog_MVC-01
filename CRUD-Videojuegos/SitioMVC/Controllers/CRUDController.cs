using SitioMVC.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.Mvc;

namespace SitioMVC.Controllers
{
    public class CRUDController : BaseController
    {
        
        // Listado de Juegos
        public ActionResult Index()
        {
            try
            {
                var juegos = db.Juegos.AsNoTracking().ToList();
                
                return View(juegos);
            }
            catch (Exception ex)
            {
                return View("Error", new HandleErrorInfo(ex, nameof(CRUDController), nameof(Index)));
            }
        }

        // Detalle de un juego específico
        public ActionResult Detalle(int? id)
        {
            if (id == null)
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            try
            {
                var juego = db.Juegos.Find(id);
                if (juego == null)
                    return HttpNotFound();

                return View(juego);
            }
            catch (Exception ex)
            {
                return View("Error", new HandleErrorInfo(ex, nameof(CRUDController), nameof(Detalle)));
            }
        }

        // Formulario de creación
        public ActionResult Agregar()
        {
            return View();
        }

        // Agregar nuevo juego
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Agregar(Juegos juego)
        {
            if (!ModelState.IsValid)
                return View(juego);

            try
            {
                db.Juegos.Add(juego);
                db.SaveChanges();
                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", $"Error al guardar el juego. { ex.Message }");
                return View(juego);
            }
        }

        // Formulario de edición
        public ActionResult Editar(int? id)
        {
            if (id == null)
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            var juego = db.Juegos.Find(id);
            if (juego == null)
                return HttpNotFound();

            return View(juego);
        }

        // Procesar edición
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Editar(Juegos juego)
        {
            if (!ModelState.IsValid)
                return View(juego);

            try
            {
                db.Entry(juego).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", $"Error al actualizar el juego. {ex.Message}");
                return View(juego);
            }
        }

        // Confirmación de eliminación
        public ActionResult Eliminar(int? id)
        {
            if (id == null)
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);

            var juego = db.Juegos.Find(id);
            if (juego == null)
                return HttpNotFound();

            return View(juego);
        }

        // Procesar eliminación
        [HttpPost, ActionName("EliminarConfirmado")]
        [ValidateAntiForgeryToken]
        public ActionResult EliminarConfirmado(int id)
        {
            try
            {
                var juego = db.Juegos.Find(id);
                if (juego == null)
                    return HttpNotFound();

                db.Juegos.Remove(juego);
                db.SaveChanges();
                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", $"Error al eliminar el juego. { ex.Message }");
                return View("Eliminar");
            }
        }
    }
}