using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebsiteBanHang.Models
{
    [MetadataTypeAttribute(typeof(ThanhVienMetadata))]
    public partial class ThanhVien
    {
        internal sealed class ThanhVienMetadata
        {
            //[DisplayName("Mã Thành Viên")]
            public int MaThanhVien { get; set; }
            [Required(ErrorMessage ="{0} không được trống")]
           // [DisplayName("Tài Khoản")]
            public string TaiKhoan { get; set; }
            //[DisplayName("Mật Khẩu")]
            public string MatKhau { get; set; }
            //[DisplayName("Họ Tên")]
            public string HoTen { get; set; }
            //[DisplayName("Địa Chỉ")]
            public string DiaChi { get; set; }
            //[DisplayName("Địa Chỉ Email")]
            public string Email { get; set; }
            //[DisplayName("Số Điện Thoại")]
            public string SoDienThoai { get; set; }
            //[DisplayName("Câu Hỏi Bí Mật")]
            public string CauHoi { get; set; }
            //[DisplayName("Câu Trả Lời")]
            public string CauTraLoi { get; set; }
            //[DisplayName("Mã Loại Thành Viên")]
            public Nullable<int> MaLoaiTV { get; set; }
        }
    }
}