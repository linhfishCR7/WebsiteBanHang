use WebSiteBanHang
--tao bang nhà cung cấp
CREATE TABLE [dbo].[NhaCungCap] (
    [MaNCC]       INT            IDENTITY (1, 1) NOT NULL,
    [TenNCC]      NVARCHAR (100) NULL,
    [DiaChi]      NVARCHAR (255) NULL,
    [Email]       NVARCHAR (255) NULL,
    [SoDienThoai] VARCHAR (12)   NULL,
    [Fax]         VARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([MaNCC] ASC)
);

--tạo bảng nhà sản xuất
CREATE TABLE [dbo].[NhaSanXuat] (
    [MaNSX]    INT            IDENTITY (1, 1) NOT NULL,
    [TenNSX]   NVARCHAR (100) NULL,
    [ThongTin] NVARCHAR (255) NULL,
    [Logo]     NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([MaNSX] ASC)
);

--tạo bảng phiếu nhập
CREATE TABLE [dbo].[PhieuNhap] (
    [MaPN]     INT      IDENTITY (1, 1) NOT NULL,
    [MaNCC]    INT      NULL,
    [NgayNhap] DATETIME NULL,
    [DaXoa]    BIT      NULL,
    PRIMARY KEY CLUSTERED ([MaPN] ASC),
    CONSTRAINT [FK_PhieuNhap_ToTable] FOREIGN KEY ([MaNCC]) REFERENCES [dbo].[NhaCungCap] ([MaNCC]) ON UPDATE CASCADE
);

--tạo bảng loại thành viên
CREATE TABLE [dbo].[LoaiThanhVien] (
    [MaLoaiTV] INT           IDENTITY (1, 1) NOT NULL,
    [TenLoai]  NVARCHAR (50) NULL,
    [UuDai]    INT           NULL,
    PRIMARY KEY CLUSTERED ([MaLoaiTV] ASC)
);
--tạo bảng thành viên
CREATE TABLE [dbo].[ThanhVien] (
    [MaThanhVien] INT            IDENTITY (1, 1) NOT NULL,
    [TaiKhoan]    NVARCHAR (100) NULL,
    [MatKhau]     NVARCHAR (100) NULL,
    [HoTen]       NVARCHAR (100) NULL,
    [DiaChi]      NVARCHAR (255) NULL,
    [Email]       NVARCHAR (255) NULL,
    [SoDienThoai] VARCHAR (12)   NULL,
    [CauHoi]      NVARCHAR (MAX) NULL,
    [CauTraLoi]   NVARCHAR (MAX) NULL,
    [MaLoaiTV]    INT            NULL,
    PRIMARY KEY CLUSTERED ([MaThanhVien] ASC),
    CONSTRAINT [FK_ThanhVien_ToTable] FOREIGN KEY ([MaLoaiTV]) REFERENCES [dbo].[LoaiThanhVien] ([MaLoaiTV]) ON UPDATE CASCADE
);

--tạo bảng khách hàng
CREATE TABLE [dbo].[KhachHang] (
    [MaKH]        INT            IDENTITY (1, 1) NOT NULL,
    [TenKH]       NVARCHAR (100) NULL,
    [DiaChi]      NVARCHAR (100) NULL,
    [Email]       NVARCHAR (255) NULL,
    [SoDienThoai] NVARCHAR (255) NULL,
    [MaThanhVien] INT            NULL,
    PRIMARY KEY CLUSTERED ([MaKH] ASC),
    CONSTRAINT [FK_KhachHang_ToTable] FOREIGN KEY ([MaThanhVien]) REFERENCES [dbo].[ThanhVien] ([MaThanhVien]) ON UPDATE CASCADE
);

--tạo bảng loại sản phẩm
CREATE TABLE [dbo].[LoaiSanPham] (
    [MaLoaiSP] INT            IDENTITY (1, 1) NOT NULL,
    [TenLoai]  NVARCHAR (100) NULL,
    [Icon]     NVARCHAR (MAX) NULL,
    [BiDanh]   NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([MaLoaiSP] ASC)
);

--tạo bảng sản phẩm
CREATE TABLE [dbo].[SanPham] (
    [MaSP]         INT            IDENTITY (1, 1) NOT NULL,
    [TenSP]        NVARCHAR (255) NULL,
    [DonGia]       DECIMAL (18)   NULL,
    [NgayCapNhat]  DATETIME       NULL,
    [CauHinh]      NVARCHAR (MAX) NULL,
    [MoTa]         NVARCHAR (MAX) NULL,
    [HinhAnh]      NVARCHAR (MAX) NULL,
    [SoLuongTon]   INT            NULL,
    [LuotXem]      INT            NULL,
    [LuotBinhChon] INT            NULL,
    [LuotBinhLuan] INT            NULL,
    [SoLanMua]     INT            NULL,
    [Moi]          INT            NULL,
    [MaNCC]        INT            NULL,
    [MaNSX]        INT            NULL,
    [MaLoaiSP]     INT            NULL,
    [DaXoa]        BIT            NULL,
    [HinhAnh1]     NVARCHAR (MAX) NULL,
    [HinhAnh2]     NVARCHAR (MAX) NULL,
    [HinhAnh3]     NVARCHAR (MAX) NULL,
    [HinhAnh4]     NVARCHAR (MAX) NULL,
    [DonGiaCu]     DECIMAL (18)   NULL,
    PRIMARY KEY CLUSTERED ([MaSP] ASC),
    CONSTRAINT [FK_SanPham_LoaiSanPham] FOREIGN KEY ([MaLoaiSP]) REFERENCES [dbo].[LoaiSanPham] ([MaLoaiSP]),
    CONSTRAINT [FK_SanPham_NhaCungCap] FOREIGN KEY ([MaNCC]) REFERENCES [dbo].[NhaCungCap] ([MaNCC]),
    CONSTRAINT [FK_SanPham_NhaSanXuat] FOREIGN KEY ([MaNSX]) REFERENCES [dbo].[NhaSanXuat] ([MaNSX])
);

--tạo bảng chi tiết phiếu nhập
CREATE TABLE [dbo].[ChiTietPhieuNhap] (
    [MaChiTietPN] INT          IDENTITY (1, 1) NOT NULL,
    [MaPN]        INT          NULL,
    [MaSP]        INT          NULL,
    [DonGiaNhap]  DECIMAL (18) NULL,
    [SoLuongNhap] INT          NULL,
    PRIMARY KEY CLUSTERED ([MaChiTietPN] ASC),
    CONSTRAINT [FK_ChiTietPhieuNhap_PhieuNhap] FOREIGN KEY ([MaPN]) REFERENCES [dbo].[PhieuNhap] ([MaPN]),
    CONSTRAINT [FK_ChiTietPhieuNhap_SanPham] FOREIGN KEY ([MaSP]) REFERENCES [dbo].[SanPham] ([MaSP])
);

--tạo bảng đơn đặt hàng
CREATE TABLE [dbo].[DonDatHang] (
    [MaDDH]       INT      IDENTITY (1, 1) NOT NULL,
    [NgayDat]     DATETIME NULL,
    [TinhTrang]   BIT      NULL,
    [NgayGiao]    DATETIME NULL,
    [DaThanhToan] BIT      NULL,
    [MaKH]        INT      NULL,
    [UuDai]       INT      NULL,
    PRIMARY KEY CLUSTERED ([MaDDH] ASC),
    CONSTRAINT [FK_DonDatHang_KhachHang] FOREIGN KEY ([MaKH]) REFERENCES [dbo].[KhachHang] ([MaKH]) ON UPDATE CASCADE
);

--tạo bảng chi tiết đơn đặt hàng
CREATE TABLE [dbo].[ChiTietDonDatHang] (
    [MaChiTietDDH] INT            IDENTITY (1, 1) NOT NULL,
    [MaDDH]        INT            NULL,
    [MaSP]         INT            NULL,
    [TenSP]        NVARCHAR (255) NULL,
    [SoLuong]      INT            NULL,
    [DonGia]       DECIMAL (18)   NULL,
    PRIMARY KEY CLUSTERED ([MaChiTietDDH] ASC),
    CONSTRAINT [FK_ChiTietDonDatHang_SanPham] FOREIGN KEY ([MaSP]) REFERENCES [dbo].[SanPham] ([MaSP]),
    CONSTRAINT [FK_ChiTietDonDatHang_DonDatHang] FOREIGN KEY ([MaDDH]) REFERENCES [dbo].[DonDatHang] ([MaDDH])
);

--tạo bảng bình luận

CREATE TABLE [dbo].[BinhLuan] (
    [MaBL]        INT            IDENTITY (1, 1) NOT NULL,
    [NoiDungPN]   NVARCHAR (MAX) NULL,
    [MaThanhVien] INT            NULL,
    [MaSP]        INT            NULL,
    PRIMARY KEY CLUSTERED ([MaBL] ASC),
    CONSTRAINT [FK_BinhLuan_SanPham] FOREIGN KEY ([MaSP]) REFERENCES [dbo].[SanPham] ([MaSP]),
    CONSTRAINT [FK_BinhLuan_ThanhVien] FOREIGN KEY ([MaThanhVien]) REFERENCES [dbo].[ThanhVien] ([MaThanhVien])
);

SET IDENTITY_INSERT [dbo].[SanPham] ON
INSERT INTO [dbo].[SanPham] ([MaSP], [TenSP], [DonGia], [NgayCapNhat], [CauHinh], [MoTa], [HinhAnh], [SoLuongTon], [LuotXem], [LuotBinhChon], [LuotBinhLuan], [SoLanMua], [Moi], [MaNCC], [MaNSX], [MaLoaiSP], [DaXoa], [HinhAnh1], [HinhAnh2], [HinhAnh3], [HinhAnh4], [DonGiaCu]) VALUES (1, N'OPPO Reno3', CAST(7490000 AS Decimal(18, 0)), N'2020-02-02 00:00:00', N'Màn hình:	AMOLED, 6.4", Full HD+
Hệ điều hành:	Android 10
Camera sau:	Chính 48 MP & Phụ 13 MP, 8 MP, 2 MP
Camera trước:	44 MP
CPU:	MediaTek Helio P90 8 nhân
RAM:	8 GB
Bộ nhớ trong:	128 GB
Thẻ nhớ:	MicroSD, hỗ trợ tối đa 256 GB
Thẻ SIM:
2 Nano SIM, Hỗ trợ 4G
HOTSIM VNMB Siêu sim (5GB/ngày)
Dung lượng pin:	4025 mAh, có sạc nhanh', N'OPPO Reno3 là một sản phẩm ở phân khúc tầm trung nhưng vẫn sở hữu cho mình ngoại hình bắt mắt, cụm camera chất lượng và cùng nhiều đột phá về màn hình cũng như hiệu năng.
Nhiếp ảnh, quay phim đỉnh với cụm camera chất
Xu thế nhiều camera đang "nở rộ" và trên "đứa con cưng của mình" thì OPPO đã mang tới cho người dùng cụm 4 camera chất lượng ở mặt sau máy.', N'oppo-reno3-den-200x200-1-180x125.png', 100, 20, 1, 2, 2, 1, NULL, NULL, 1, 0, N'oppo-reno3-trang-200x200-1-180x125.png', N'oppo-reno3-xanh-200x200-2-180x125.png', NULL, NULL, CAST(8990000 AS Decimal(18, 0)))
INSERT INTO [dbo].[SanPham] ([MaSP], [TenSP], [DonGia], [NgayCapNhat], [CauHinh], [MoTa], [HinhAnh], [SoLuongTon], [LuotXem], [LuotBinhChon], [LuotBinhLuan], [SoLanMua], [Moi], [MaNCC], [MaNSX], [MaLoaiSP], [DaXoa], [HinhAnh1], [HinhAnh2], [HinhAnh3], [HinhAnh4], [DonGiaCu]) VALUES (2, N'iPhone 11 64GB', CAST(21990000 AS Decimal(18, 0)), N'2020-02-06 00:00:00', N'Màn hình:	IPS LCD, 6.1", Liquid Retina
Hệ điều hành:	iOS 13
Camera sau:	Chính 12 MP & Phụ 12 MP
Camera trước:	12 MP
CPU:	Apple A13 Bionic 6 nhân
RAM:	4 GB
Bộ nhớ trong:	64 GB
Thẻ SIM:
1 eSIM & 1 Nano SIM, Hỗ trợ 4G
HOTSIM VNMB Siêu sim (5GB/ngày)
Dung lượng pin:	3110 mAh', N'Sau bao nhiêu chờ đợi cũng như đồn đoán thì cuối cùng Apple đã chính thức giới thiệu bộ 3 siêu phẩm iPhone 11 mạnh mẽ nhất của mình vào tháng 9/2019. Có mức giá rẻ nhất nhưng vẫn được nâng cấp mạnh mẽ như chiếc iPhone Xr năm ngoái, đó chính là phiên bản iPhone 11 64GB.
Nâng cấp mạnh mẽ về camera
Nói về nâng cấp thì camera chính là điểm có nhiều cải tiến nhất trên thế hệ iPhone mới.', N'iphone-11-red-2-400x460-400x460.png', 120, 50, 20, 30, 6, 1, NULL, NULL, 1, 0, N'iphone-11-black-200-180x125.png', N'iphone-11-green-200-180x125.png', N'iphone-11-purple-200-180x125.png', N'iphone-11-white-200-180x125.png', NULL)
INSERT INTO [dbo].[SanPham] ([MaSP], [TenSP], [DonGia], [NgayCapNhat], [CauHinh], [MoTa], [HinhAnh], [SoLuongTon], [LuotXem], [LuotBinhChon], [LuotBinhLuan], [SoLanMua], [Moi], [MaNCC], [MaNSX], [MaLoaiSP], [DaXoa], [HinhAnh1], [HinhAnh2], [HinhAnh3], [HinhAnh4], [DonGiaCu]) VALUES (3, N'Điện thoại Samsung Galaxy A21s (6GB/64GB)', CAST(5690000 AS Decimal(18, 0)), N'2020-03-06 00:00:00', N'Màn hình:	TFT LCD, 6.5", HD+
Hệ điều hành:	Android 10
Camera sau:	Chính 48 MP & Phụ 8 MP, 2 MP, 2 MP
Camera trước:	13 MP
CPU:	Exynos 850 8 nhân
RAM:	6 GB
Bộ nhớ trong:	64 GB
Thẻ nhớ:	MicroSD, hỗ trợ tối đa 512 GB
Thẻ SIM:
2 Nano SIM, Hỗ trợ 4G
HOTSIM VNMB Siêu sim (5GB/ngày)
Dung lượng pin:	5000 mAh', N'Samsung Galaxy A21s là chiếc điện thoại tầm trung mới của Samsung, mang trong mình có thiết kế màn hình nốt ruồi thời thượng, cùng cụm 4 camera sau độ phân giải lên đến 48 MP hỗ trợ nhiều tính năng chụp ảnh hấp dẫn.
Thiết kế cao cấp, cảm biến vân tay ở mặt lưng
Samsung Galaxy A21s sở hữu thiết kế siêu tràn viền theo xu hướng 2020 với viền màn hình tràn ra các cạnh và camera trước dạng nốt ruồi giúp không gian sử dụng rộng hơn, ít gây cảm giác khó chịu cho người dùng.', N'samsung-galaxy-a21s-055620-045627-400x460.png', 40, 30, 25, 20, 5, 1, NULL, NULL, 1, 0, N'samsung-galaxy-a21s-den-200x200-180x125.png', NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[SanPham] ([MaSP], [TenSP], [DonGia], [NgayCapNhat], [CauHinh], [MoTa], [HinhAnh], [SoLuongTon], [LuotXem], [LuotBinhChon], [LuotBinhLuan], [SoLanMua], [Moi], [MaNCC], [MaNSX], [MaLoaiSP], [DaXoa], [HinhAnh1], [HinhAnh2], [HinhAnh3], [HinhAnh4], [DonGiaCu]) VALUES (4, N'Điện thoại Huawei P40 (Nền tảng Huawei Mobile Service)
', CAST(17990000 AS Decimal(18, 0)), N'2020-06-08 00:00:00', N'Màn hình:	OLED, 6.1", Full HD+
Hệ điều hành:	EMUI 10 (Android 10 không có Google)
Camera sau:	Chính 50 MP & Phụ 16 MP, 8 MP
Camera trước:	Chính 32 MP & Phụ IR TOF 3D
CPU:	Kirin 990 8 nhân
RAM:	8 GB
Bộ nhớ trong:	128 GB
Thẻ nhớ:	NM card, hỗ trợ tối đa 256 GB
Thẻ SIM:
2 SIM Nano (SIM 2 chung khe thẻ nhớ), Hỗ trợ 5G
HOTSIM VNMB Siêu sim (5GB/ngày)
Dung lượng pin:	3800 mAh', N'Chiếc điện thoại cao cấp Huawei P40 mới được Huawei giới thiệu vào tháng 3/2020. Với thiết kế tinh tế, hiệu năng khủng cùng hệ thống camera ấn tượng, chiếc smartphone hứa hẹn sẽ tạo nên làn sóng mới cho thị trường điện thoại di động 2020.', N'huawei-p40-re-up-200x200-1-180x125.png', 80, 20, 5, 30, 5, 1, NULL, NULL, 1, 0, N'samsung-galaxy-a21s-den-200x200-180x125.png', NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[SanPham] ([MaSP], [TenSP], [DonGia], [NgayCapNhat], [CauHinh], [MoTa], [HinhAnh], [SoLuongTon], [LuotXem], [LuotBinhChon], [LuotBinhLuan], [SoLanMua], [Moi], [MaNCC], [MaNSX], [MaLoaiSP], [DaXoa], [HinhAnh1], [HinhAnh2], [HinhAnh3], [HinhAnh4], [DonGiaCu]) VALUES (5, N'Laptop Apple MacBook Air 2017 i5 1.8GHz/8GB/128GB (MQD32SA/A)', CAST(19990000 AS Decimal(18, 0)), N'2020-07-08 00:00:00', N'CPU:	Intel Core i5 Broadwell, 1.80 GHz
RAM:	8 GB, DDR3L(On board), 1600 MHz
Ổ cứng:	SSD: 128 GB
Màn hình:	13.3 inch, WXGA+(1440 x 900)
Card màn hình:	Card đồ họa tích hợp, Intel HD Graphics 6000
Cổng kết nối:	MagSafe 2, 2 x USB 3.0, Thunderbolt 2
Hệ điều hành:	Mac OS
Thiết kế:	Vỏ kim loại nguyên khối, PIN liền
Kích thước:	Dày 17 mm, 1.35 Kg
Thời điểm ra mắt:	2017', N'MacBook Air 2017 i5 128GB là mẫu laptop văn phòng, có thiết kế siêu mỏng và nhẹ, vỏ nhôm nguyên khối sang trọng. Máy có hiệu năng ổn định, thời lượng pin cực lâu 12 giờ, phù hợp cho hầu hết các nhu cầu làm việc và giải trí. 
Thiết kế siêu mỏng và nhẹ 
Macbook Air 2017 mang những đặc trưng thiết kế của dòng MacBook Air với trọng lượng và độ dày của laptop lần lượt là 1.7 cm và 1.35 kg rất tiện lợi và dễ dàng giúp người dùng không cảm thấy bất tiện khi mang trên vai thường xuyên khi đi học hay đi làm. 

Đây cũng là chiếc MacBook chính hãng có giá rẻ nhất hiện tại, phù hợp với mọi người tiêu dùng. ', N'apple-macbook-air-mqd32sa-a-i5-5350u-600x600.jpg', 50, 150, 20, 30, 10, 1, NULL, NULL, 2, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[SanPham] ([MaSP], [TenSP], [DonGia], [NgayCapNhat], [CauHinh], [MoTa], [HinhAnh], [SoLuongTon], [LuotXem], [LuotBinhChon], [LuotBinhLuan], [SoLanMua], [Moi], [MaNCC], [MaNSX], [MaLoaiSP], [DaXoa], [HinhAnh1], [HinhAnh2], [HinhAnh3], [HinhAnh4], [DonGiaCu]) VALUES (6, N'Laptop Dell Inspiron 3493 i5 1035G1/8GB/256GB/Win10 (N4I5122WA)
', CAST(15590000 AS Decimal(18, 0)), N'2020-08-01 00:00:00', N'CPU:	Intel Core i5 Ice Lake, 1035G1, 1.00 GHz
RAM:	8 GB, DDR4 (2 khe), 2666 MHz
Ổ cứng:	SSD 256GB NVMe PCIe, Hỗ trợ khe cắm HDD SATA
Màn hình:	14 inch, Full HD (1920 x 1080)
Card màn hình:	Card đồ họa tích hợp, Intel UHD Graphics
Cổng kết nối:	2 x USB 3.1, HDMI, LAN (RJ45), USB 2.0
Hệ điều hành:	Windows 10 Home SL
Thiết kế:	Vỏ nhựa, PIN liền
Kích thước:	Dày 21 mm, 1.79kg
Thời điểm ra mắt:	2019', N'Laptop Dell Inspiron 3493 i5 (N4I5122W) là mẫu máy laptop văn phòng đến từ nhà Dell. Hướng tới khách hàng là học sinh sinh viên và nhân viên văn phòng, máy được trang bị cấu hình đủ dùng cho công việc lẫn giải trí thường ngày. 
Thân máy gọn nhẹ, linh động trong việc di chuyển
Dell Inspiron 3493 có thiết kế theo xu hướng tối giản, vỏ máy được hoàn thiện từ nhựa phủ sơn màu bạc cho vẻ ngoài sang trọng không thua kém các mẫu laptop vỏ kim loại. Máy có kích thước nhỏ gọn, độ dày 21 mm, nặng 1.79 kg khá dễ dàng để mang đến trường hay cơ quan mỗi ngày.', N'dell-inspiron-3493-i5-n4i5122w-222088-600x600.jpg', 20, 20, 30, 20, 5, 1, NULL, NULL, 2, 0, N'dell-inspiron-3493-i5-n4i5122w-1-1-180x125.jpg', NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[SanPham] ([MaSP], [TenSP], [DonGia], [NgayCapNhat], [CauHinh], [MoTa], [HinhAnh], [SoLuongTon], [LuotXem], [LuotBinhChon], [LuotBinhLuan], [SoLanMua], [Moi], [MaNCC], [MaNSX], [MaLoaiSP], [DaXoa], [HinhAnh1], [HinhAnh2], [HinhAnh3], [HinhAnh4], [DonGiaCu]) VALUES (7, N'Laptop Asus VivoBook X509MA N4020/4GB/256GB/Win10 (BR271T)', CAST(6990000 AS Decimal(18, 0)), N'2020-05-11 00:00:00', N'CPU:	Intel Celeron, N4020, 1.10 GHz
RAM:	4 GB, DDR4 (1 khe), 2666 MHz
Ổ cứng:	SSD 256GB NVMe PCIe, Hỗ trợ khe cắm HDD SATA
Màn hình:	15.6 inch, HD (1366 x 768)
Card màn hình:	Card đồ họa tích hợp, Intel® UHD Graphics 600
Cổng kết nối:	2 x USB 2.0, USB 3.1, HDMI, USB Type-C
Hệ điều hành:	Windows 10 Home SL
Thiết kế:	Vỏ nhựa, PIN liền
Kích thước:	Dày 22.9 mm, 1.66 kg
Thời điểm ra mắt:	2020', N'Laptop Asus VivoBook X509MA (BR271T) là phiên bản laptop giá rẻ hướng đến đối tượng người dùng là học sinh sinh viên. Máy có thiết kế gọn nhẹ, cấu hình đủ dùng học tập, lướt web mượt mà.
Thiết kế gọn nhẹ năng động
Laptop Asus có trọng lượng chỉ khoảng 1.66 kg và độ dày 22.9 mm, dễ dàng mang theo mỗi khi đi học, đi làm hay đi cà phê, phù hợp với giới trẻ năng động.

Vỏ máy được làm từ nhựa với tông màu bạc cuốn hút, được hoàn thiện tỉ mỉ tạo nên tổng thể máy đẹp, trang nhã.', N'asus-vivobook-x509ma-n4020-br271t-224411-600x600.jpg', 40, 1, 0, 20, 5, 1, NULL, NULL, 2, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[SanPham] ([MaSP], [TenSP], [DonGia], [NgayCapNhat], [CauHinh], [MoTa], [HinhAnh], [SoLuongTon], [LuotXem], [LuotBinhChon], [LuotBinhLuan], [SoLanMua], [Moi], [MaNCC], [MaNSX], [MaLoaiSP], [DaXoa], [HinhAnh1], [HinhAnh2], [HinhAnh3], [HinhAnh4], [DonGiaCu]) VALUES (8, N'Laptop HP 348 G7 i3 8130U/4GB/256GB/Win10 (9PG83PA)
', CAST(11390000 AS Decimal(18, 0)), N'2020-09-06 00:00:00', N'CPU:	Intel Core i3 Coffee Lake, 8130U, 2.20 GHz
RAM:	4 GB, DDR4 (2 khe), 2666 MHz
Ổ cứng:	SSD 256GB NVMe PCIe, Hỗ trợ khe cắm HDD SATA
Màn hình:	14 inch, Full HD (1920 x 1080)
Card màn hình:	Card đồ họa tích hợp, Intel® UHD Graphics 620
Cổng kết nối:	3 x USB 3.1, HDMI, LAN (RJ45), USB Type-C
Hệ điều hành:	Windows 10 Home SL
Thiết kế:	Vỏ nhựa, PIN liền
Kích thước:	Dày 1.99 mm, 1.5 kg
Thời điểm ra mắt:	2019', N'Được xướng tên trong phân khúc laptop học tập - văn phòng lần này là một chiếc laptop nhỏ gọn nữa đến từ thương hiệu HP - laptop HP 348 G7 i3 8130U (9PG83PA), hứa hẹn sẽ đáp ứng tốt mọi nhu cầu sử dụng laptop thường ngày của dân văn phòng và cả các bạn học sinh sinh viên.
Cấu hình ổn định trong tầm giá
Tuy chỉ sở hữu bộ vi xử lí Intel Core i3 thế hệ thứ 8, RAM 4 GB nhưng máy vẫn sẽ đáp ứng tốt đối với các tác vụ thường ngày như: soạn thảo, nhập liệu, làm báo cáo, học online trên Zoom, Microsoft teams, giải trí với các bộ phim trên Netflix,... 

Nếu bạn muốn làm việc đa nhiệm tốt hơn, nhanh hơn, bạn có thể nâng cấp RAM và HP 348 G7 hỗ trợ lên đến 32 GB.', N'hp-348-g7-i3-9pg83pa-221511-600x600.jpg', 60, 2, 0, 5, 2, 1, NULL, NULL, 2, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[SanPham] ([MaSP], [TenSP], [DonGia], [NgayCapNhat], [CauHinh], [MoTa], [HinhAnh], [SoLuongTon], [LuotXem], [LuotBinhChon], [LuotBinhLuan], [SoLanMua], [Moi], [MaNCC], [MaNSX], [MaLoaiSP], [DaXoa], [HinhAnh1], [HinhAnh2], [HinhAnh3], [HinhAnh4], [DonGiaCu]) VALUES (9, N'Máy tính bảng iPad 10.2 inch Wifi 32GB (2019)', CAST(9990000 AS Decimal(18, 0)), N'2020-12-12 00:00:00', N'Màn hình	LED backlit LCD, 10.2"
Hệ điều hành	iPadOS 13
CPU	Apple A10 Fusion 4 nhân, 2.34 GHz
RAM	3 GB
Bộ nhớ trong	32 GB
Camera sau	8 MP
Camera trước	1.2 MP
Kết nối mạng	WiFi, Không hỗ trợ 3G, Không hỗ trợ 4G
Đàm thoại	FaceTime
Trọng lượng	483 g', N'Thiết kế sang trọng, màn hình đẹp và một cấu hình đủ dùng cho hầu hết nhu cầu là những ưu điểm mà chiếc máy tính bảng iPad 10.2 inch Wifi 32GB (2019) này sở hữu.
Vẫn là iPad, không lẫn vào đâu được
Chỉ cần nhìn qua là người đối diện biết ngay bạn đang dùng iPad chứ không phải một chiếc máy tính bảng nào khác, đó là cái hay mà Apple mang lại cho người dùng.', N'ipad-10-2-inch-wifi-32gb-2019-gold-400x460.png', 20, 20, 2, 20, 3, 1, NULL, NULL, 3, 0, N'ipad-10-2-inch-wifi-32gb-2019-gray-200-180x125.png', N'ipad-10-2-inch-wifi-32gb-2019-silver-200-180x125.png', NULL, NULL, NULL)
INSERT INTO [dbo].[SanPham] ([MaSP], [TenSP], [DonGia], [NgayCapNhat], [CauHinh], [MoTa], [HinhAnh], [SoLuongTon], [LuotXem], [LuotBinhChon], [LuotBinhLuan], [SoLanMua], [Moi], [MaNCC], [MaNSX], [MaLoaiSP], [DaXoa], [HinhAnh1], [HinhAnh2], [HinhAnh3], [HinhAnh4], [DonGiaCu]) VALUES (10, N'Máy tính bảng Samsung Galaxy Tab S6 Lite', CAST(9990000 AS Decimal(18, 0)), N'2020-05-23 00:00:00', N'Màn hình	PLS LCD, 10.4"
Hệ điều hành	Android 10
CPU	Exynos 9611 8 nhân, 4 nhân 2.3 GHz & 4 nhân 1.7 GHz
RAM	4 GB
Bộ nhớ trong	64 GB
Camera sau	8 MP
Camera trước	5 MP
Kết nối mạng	WiFi, 3G, 4G LTE
Hỗ trợ SIM
Nano Sim
HOTSIM VNMB Siêu sim (5GB/ngày)
Đàm thoại	Có', N'Sau thành công của Galaxy Tab S6, Samsung tiếp tục ra mắt Galaxy Tab S6 Lite để chinh chiến ở phân khúc máy tính bảng giá rẻ hơn. Thiết bị vẫn hỗ trợ bút S Pen thần thánh, thiết kế kim loại cao cấp và màn hình, âm thanh giải trí đỉnh cao.
Thiết kế thời thượng và cao cấp
Máy tính bảng Galaxy Tab S6 Lite sở hữu thiết ấn tượng với độ dày chỉ 7mm và trọng lượng siêu nhẹ 467g, giúp người dùng dễ dàng bỏ vào túi xách hay mang theo bất kì đâu', N'samsung-galaxy-tab-s6-lite-xanh-400x460-400x460.png', 20, 44, 54, 7, 54, 1, NULL, NULL, 3, 0, N'samsung-galaxy-tab-s6-lite-xam-200x200-180x125.png', NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[SanPham] ([MaSP], [TenSP], [DonGia], [NgayCapNhat], [CauHinh], [MoTa], [HinhAnh], [SoLuongTon], [LuotXem], [LuotBinhChon], [LuotBinhLuan], [SoLanMua], [Moi], [MaNCC], [MaNSX], [MaLoaiSP], [DaXoa], [HinhAnh1], [HinhAnh2], [HinhAnh3], [HinhAnh4], [DonGiaCu]) VALUES (11, N'Máy tính bảng Huawei Mediapad T5 10.1 inch (3GB/32GB)', CAST(4990000 AS Decimal(18, 0)), N'2020-02-08 00:00:00', N'Màn hình	IPS LCD Full HD, 10.1"
Hệ điều hành	Android 8.0
CPU	Kirin 659, 4 nhân 2.36 GHz & 4 nhân 1.7 GHz
RAM	3 GB
Bộ nhớ trong	32 GB
Camera sau	5 MP
Camera trước	2 MP
Kết nối mạng	WiFi, 3G, 4G LTE
Hỗ trợ SIM
Micro sim
HOTSIM VNMB Siêu sim (5GB/ngày)
Đàm thoại	Có', N'Máy tính bảng Huawei Mediapad T5 vừa được ra mắt cuối năm 2018, mang trong mình thiết kế trẻ trung, màn hình sắc nét và một cấu hình đủ khoẻ để chơi tốt các tựa game cơ bản hiện nay sẽ là sự lựa chọn đáng cân nhắc trong phân khúc tablet phổ thông.
Thiết kế hiện đại, đẹp mắt
Chất liệu kim loại bao bọc thân máy tạo sự cứng cáp, mặt trước máy là lớp kính gần ra đến viền tạo sự hiện đại và sang trọng cho sản phẩm. Các cạnh được bo cong nhẹ, trọng lượng máy chỉ 470 gam giúp bạn cầm nắm bằng 1 tay chắc chắn.', N'huawei-mediapad-t5-33397-hinhchitiet-400x460.png', 30, 67, 54, 436, 56, 1, NULL, NULL, 3, 0, N'', NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[SanPham] ([MaSP], [TenSP], [DonGia], [NgayCapNhat], [CauHinh], [MoTa], [HinhAnh], [SoLuongTon], [LuotXem], [LuotBinhChon], [LuotBinhLuan], [SoLanMua], [Moi], [MaNCC], [MaNSX], [MaLoaiSP], [DaXoa], [HinhAnh1], [HinhAnh2], [HinhAnh3], [HinhAnh4], [DonGiaCu]) VALUES (12, N'Máy tính bảng Lenovo Tab E10 TB-X104L Đen', CAST(3490000 AS Decimal(18, 0)), N'2020-09-01 00:00:00', N'Màn hình	IPS LCD, 10.1"
Hệ điều hành	Android 8.0
CPU	Snapdragon 210 4 nhân, 1.33 GHz
RAM	2 GB
Bộ nhớ trong	16 GB
Camera sau	5 MP
Camera trước	2 MP
Kết nối mạng	WiFi, 3G, 4G LTE
Hỗ trợ SIM
Nano Sim
HOTSIM VNMB Siêu sim (5GB/ngày)
Trọng lượng	522 g', N'Lenovo Tab E10 TB-X104L là chiếc máy tính bảng cơ bản với màn hình lớn cho người dùng giải trí thoải mái và còn hỗ trợ cả kết nối 4G.
Màn hình kích thước lớn, thoải mái cho giải trí
Lenovo Tab E10 TB-X104L sở hữu màn hình với kích thước lên tới 10.1 inch phù hợp cho người dùng thường xuyên xem phim hay chơi game.', N'lenovo-tab-e10-tb-x104l-den-400x460.png', 60, 20, 63, 555, 6, 1, NULL, NULL, 3, 0, NULL, NULL, NULL, NULL, CAST(3590000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[SanPham] OFF
