using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebsiteBanHang.Models;

namespace WebsiteBanHang.Controllers
{
    public class SanPhamController : Controller
    {
        // GET: SanPham
        WebSiteBanHangEntities db = new WebSiteBanHangEntities();


        public ActionResult Index()
        {
            return View();
        }
        [ChildActionOnly]
        public ActionResult SanPhamStyle1Partial()
        {
            return PartialView();
        }
        [ChildActionOnly]
        public ActionResult SanPhamStyle2Partial()
        {
            return PartialView();
        }
    }
}