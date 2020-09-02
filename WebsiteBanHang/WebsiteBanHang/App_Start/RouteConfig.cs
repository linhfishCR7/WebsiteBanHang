using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace WebsiteBanHang
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            //cấu himhf đường dẫn trang index controller khách hàng 
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.MapRoute(
                name: "khachhang",
                url: "khach-hang",
                defaults: new { controller = "KhachHang", action = "Index", id = UrlParameter.Optional }
            );
            //đường dẫn xem trang chi tiết
          //  routes.MapRoute(
          //    name: "XemChitiet",
          //    url: "{tensp}-{id}",
          //    defaults: new { controller = "SanPham", action = "XemChitiet", id = UrlParameter.Optional }
          //);
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
