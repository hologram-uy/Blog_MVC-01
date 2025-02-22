using SitioMVC.Models;
using System;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using X.PagedList;

namespace SitioMVC.Controllers
{
    public class CRUDController : BaseController
    {
        // Para indicar la cantidad de elementos por página
        private const int PageSize = 8;

        // Listado de Juegos
        public ActionResult Index(string _nombreJuego, string _filtroActual, int? page)
        {
            try
            {
                // Si page tiene un valor (!= null), asigna su valor a pageNumber.
                // Si page es null, asigna 1 a pageNumber (para mostrar la primera página).
                int pageNumber = page ?? 1;

                // Si hay un filtro, obliga a que la búsqueda empiece en la primera página
                // cuando el usuario filtra por nombre.
                if (!string.IsNullOrEmpty(_nombreJuego))
                {
                    page = 1;
                }
                else
                {
                    _nombreJuego = _filtroActual;
                }

                // Salvamos el filtro actual para no perderlo al cambiar de pag.
                ViewBag.FiltroActual = _nombreJuego;

                // Definimos la consulta para luego filtrar la lista si es necesario
                IQueryable<Models.Juegos> juegos =
                    from j in db.Juegos
                    select j;

                // Si el usuario filtró por algún juego, filtramos
                if (!string.IsNullOrEmpty(_nombreJuego))
                {
                    string[] palabrasBuscadas = _nombreJuego.ToLower().Split(' ');

                    juegos = juegos.Where(j => palabrasBuscadas.All(palabra => j.Nombre.ToLower().Contains(palabra)));
                }

                // X.PagedList usa Skip() y Take() para la paginación, y en Entity Framework, Skip() solo se puede usar
                // en una consulta ordenada (OrderBy() debe estar presente antes de Skip()).
                juegos = juegos.OrderBy(j => j.Nombre);

                return View(juegos.ToPagedList(pageNumber, PageSize));
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