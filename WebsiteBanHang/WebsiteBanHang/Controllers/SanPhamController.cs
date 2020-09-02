using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
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

        public ActionResult SanPham(int iMaNSX, int iMaLoaiSP)
        {
            if (Session["TaiKhoan"] == null || Session["TaiKhoan"].ToString() == "")
            {
                return RedirectToAction("Index", "Home");
            }
            var MaNSX = from p in db.SanPhams.Where(n => n.MaNSX == iMaNSX && n.MaLoaiSP== iMaLoaiSP) select p;
            //var lstMTBM = db.SanPhams.Where(n => n.MaLoaiSP == 3 && n.Moi == 1 && n.DaXoa == false);
            //ViewBag.ListMTBM = lstMTBM;

            return View(MaNSX.ToList());
        }

        //xây dựng trang chi tiết sản phẩm
        public ActionResult XemChiTiet(int? id, string tensp)
        {
            //if(Session["TaiKhoan"]==null || Session["TaiKhoan"].ToString() == "")
            //{
            //    return RedirectToAction("Index","Home");
            //}
            //kiểm tra đường truyền có rỗng hay không
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            //nếu không truy xuất csdl lấy ra sản phẩm tương ứng
            SanPham sp = db.SanPhams.SingleOrDefault(n => n.MaSP == id && n.DaXoa == false);
             
            if(sp == null)
            {
                //thông báo lỗi nếu không lấy được sản phẩm
                return HttpNotFound();
            }

            return View(sp);
        }
    }
}