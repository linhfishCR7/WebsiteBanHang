using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebsiteBanHang.Models;

namespace WebsiteBanHang.Controllers
{
    public class KhachHangController : Controller
    {
        // GET: KhachHang
        WebSiteBanHangEntities db = new WebSiteBanHangEntities();

        public ActionResult Index()
        {
            // var lstKH = from KH in db.KhachHangs select KH;
            var lstKH = db.KhachHangs.ToList();
            return View(lstKH);
        }
        public ActionResult Index1()
        {
            var lstKH = from KH in db.KhachHangs select KH;
            return View(lstKH);
        }
    }
}