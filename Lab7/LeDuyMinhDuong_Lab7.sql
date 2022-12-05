--Lab7_1a
create function FN_Age(@MaNV nvarchar(9))
	returns int
as
begin 
	return(
		select DATEDIFF(year, NGSINH , GETDATE())+ 1 from NHANVIEN where MANV =@MaNV);
end;

--Lab7_1b
create function FN_TongSoDeAn(
		@MaNV nvarchar(9)
	return int
as
begin
	return (select count(mada) from PHANCONG where MA_NVIEN=@MaNV);
end;

--Lab7_1c
create function FN_ThongKePhai(
	@Phai nvarchar(3)
	)
	returns int
as
begin
	return(select count(manv) from NHANVIEN where PHAI =@Phai;
end

--Lab7_1d
create function FN_ThongTinPhongDeAn
	(@MaPhg int)
	return @List table (TenPhong nvarchar(15),TenTruongPhong nvarchar(30),SoLuongDeAn int)
as 
begin
	insert into @List 
		select a.TENPHG,b.HONV+' '+b.TENLOT+' '+b.TENNV,
			(select count(c.MADA) from DEAN c where c.PHONG =a.MAPHG)
			from PHONGBAN a inner join NHANVIEN b on a.TRPHG = b.MANV
	return;
end;

--Lab7_1e
create function fn_SoLuongDeAnTheoPB (@MaPB int)
returns @tbListPB table (TenPB nvarchar(20),MaTP nvarchar (10), TenTP nvarchar(50), soLuong int)

as
begin
	insert into @tbListPB
	select TENPHG, TRPHG, HONV+' '+TENLOT+' '+TENNV as 'Ten Truong Phong',COUNT(MADA)as 'SoLuongDeAn'
		from PHONGBAN
		inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
		inner join NHANVIEN on NHANVIEN.MANV = PHONGBAN.TRPHG
		where PHONGBAN.MAPHG = @MaPB
		group by TENPHG, TRPHG, TENNV, HONV, TENLOT
	return
end


--Lab7_2a
SELECT TOP (1000) [HONV]
		,[TENNV]
		,[TENPHG]
		,[DIADIEM]
	FROM [QLDA].[dbo].[ThongTinNVPhong]

--Lab7_2a
SELECT TOP (1000) [TENNV]
		,[LUONG]
		,[Tuoi]
	FROM [QLDA].[dbo].[NhanVienLuongTuoi]

--Lab7_2c
CREATE VIEW PhongBanDongNhat
as
	select a.TENPHG,
	b.HONV+' '+b.TENLOT+' '+b.TENNV as 'TenTruongPhong'
	from PHONGBAN a inner join NHANVIEN b on a.TRPHG = b.MANV
	where a.MAPHG in (
		select PHG from NHANVIEN
		group by phg
		having count (manv)=
			(select top 1 count (manv) as NVCount from NHANVIEN
				group by phg
				order by NVCount desc)
				)