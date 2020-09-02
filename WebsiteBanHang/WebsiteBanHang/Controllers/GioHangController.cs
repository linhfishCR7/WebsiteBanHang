using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebsiteBanHang.Models;

namespace WebsiteBanHang.Controllers
{
    public class GioHangController : Controller
    {
        WebSiteBanHangEntities db = new WebSiteBanHangEntities();
        //lay gio hang
        public List<ItemGioHang> LayGioHang()
        {
            //Gio hang da ton tai
            List<ItemGioHang> lstGioHang = Session["GioHang"] as List<ItemGioHang>;
            if (lstGioHang == null)
            {
                //neu gio hang cua ton tai khoi tao gio hang
                lstGioHang  = new List<ItemGioHang>();
                Session["GioHang"] = lstGioHang;           
             }
            return lstGioHang;
         }
        //them gio hang thong thuong (load lai trang)
        public ActionResult ThemGioHang(int MaSP, string strURL)
        {
            //kiem tra sản phẩm còn tại trong CSDL hay không
            SanPham sp = db.SanPhams.SingleOrDefault(n => n.MaSP == MaSP);
            if (sp == null)
            {
                //trang đường dẫn không hợp lệ
                Response.StatusCode =404;
                return null;
            }
            //lấy giỏ hàng
            List<ItemGioHang> lstGioHang = LayGioHang();
            //trường hợp nếu 1 sản phẩm tồn tại trong giỏ hàng
            ItemGioHang spCheck = lstGioHang.SingleOrDefault(n => n.MaSP == MaSP);
            if (spCheck != null)
            {
                if(sp.SoLuongTon < spCheck.SoLuong)
                {
                    return View("ThongBao");
                }
                spCheck.SoLuong++;
                spCheck.ThanhTien = spCheck.DonGia * spCheck.SoLuong;
                return Redirect(strURL);
            }
           
            ItemGioHang itemGH = new ItemGioHang(MaSP);
            lstGioHang.Add(itemGH);
            return Redirect(strURL);

        }


        //tính tổng số lượng
        public double TinhTongSoLuong()
        {
            List<ItemGioHang> lstGioHang = Session["GioHang"] as List<ItemGioHang>;
            if(lstGioHang == null)
            {
                return 0;
            }
            return lstGioHang.Sum(n=>n.SoLuong);
        }
        //tính tổng tiền

            public decimal TinhTongTien()
        {
            List<ItemGioHang> lstGioHang = Session["GioHang"] as List<ItemGioHang>;
            if (lstGioHang == null)
            {
                return 0;
            }
            return lstGioHang.Sum(n => n.ThanhTien);
        }
        // GET: GioHang
        public ActionResult XemGioHang()
        {
            
            List<ItemGioHang> lstGioHang = LayGioHang();
            return View(lstGioHang);
        }
        public ActionResult GioHangPartial()
        {
            if (TinhTongSoLuong() == 0)
            {
                ViewBag.TongSoLuong = 0;
                ViewBag.ThanhTien = 0;
                return PartialView();
            }
            ViewBag.TongSoLuong = TinhTongSoLuong();
            ViewBag.ThanhTien = TinhTongTien();
            return PartialView();

        }
    }
}