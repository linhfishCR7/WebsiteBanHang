using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebsiteBanHang.Models;
using WebsiteBanHang.Controllers;
using CaptchaMvc.HtmlHelpers;
using CaptchaMvc;

namespace WebsiteBanHang.Controllers
{
    public class HomeController : Controller
    {

        WebSiteBanHangEntities db = new WebSiteBanHangEntities();
        // GET: Home

        public ActionResult Index()
        {
            var lstDTM = db.SanPhams.Where(n => n.MaLoaiSP == 1 && n.Moi == 1 && n.DaXoa == false);
            ViewBag.ListDTM = lstDTM;

            var lstLTM = db.SanPhams.Where(n => n.MaLoaiSP == 2 && n.Moi == 1 && n.DaXoa == false);
            ViewBag.ListLTM = lstLTM;

            var lstMTBM = db.SanPhams.Where(n => n.MaLoaiSP == 3 && n.Moi == 1 && n.DaXoa == false);
            ViewBag.ListMTBM = lstMTBM;
            return View();
        }
        public ActionResult Demo()
        {
            return View();
        }
        public ActionResult DangNhap(FormCollection f)
        {
            //xử lý đăng nhập
            String sTaiKhoan = f["txtTenDangNhap"].ToString();
            String sMatKhau = f["txtMatKhau"].ToString();

            ThanhVien tv = db.ThanhViens.SingleOrDefault(n => n.TaiKhoan == sTaiKhoan && n.MatKhau == sMatKhau);
            if(tv !=null) {
                Session["TaiKhoan"] = tv;

                return Content("<script>window.location.reload();</script>");
            }
            return Content("Tài Khoản hoặc mật khẩu không đúng!");

        }
        public ActionResult DangXuat()
        {
            Session["TaiKhoan"] = null;
            return RedirectToAction("Index");
        }

        //menu đa câp động
        [ChildActionOnly]

        public ActionResult MenuPartial()
        {
            //truy vấn lấy về 1 list sản phẩm
            var lstSP = db.SanPhams;
            return PartialView(lstSP);
        }

        [HttpGet]
        public ActionResult DangKy()
        {
            //truy vấn lấy về 1 list sản phẩm
            ViewBag.CauHoi = new SelectList(LoadCauHoi());
            return View();
        }
        [HttpPost]
        public ActionResult DangKy(ThanhVien tv)
        {
            //kiểm tra captcha hợp lệ
            ViewBag.CauHoi = new SelectList(LoadCauHoi());
            if (this.IsCaptchaValid("Captcha is not valid"))
            {
                ViewBag.ThongBao = "thêm thành công";
                //thêm khach hàng vào cơ sở dữ liệu
                db.ThanhViens.Add(tv);
                db.SaveChanges();
                return View();
            }
            
            ViewBag.ThongBao = "sai mã captcha";
            return View();
           
        }
        [HttpGet]
        public ActionResult DangKy1()
        {
            //truy vấn lấy về 1 list sản phẩm

            return View();
        }

        public List<String> LoadCauHoi()
        {
            List<String> lstCauHoi = new List<string>();
            lstCauHoi.Add("Con vật yêu thích của bạn?");
            lstCauHoi.Add("Ca sĩ yêu thích của bạn?");
            lstCauHoi.Add("Công việc hiện tại là gì?");
            return lstCauHoi;
        }



    }
}