--lab6_1a
create trigger insert_NhanVien_1a on NHANVIEN
for insert
as
	if (select LUONG from inserted) < 15000
		begin
			print 'Luong phai lon hon 15000'
			rollback transaction
		end
select  * from NHANVIEN
insert into NHANVIEN
values ('Huynh','Cong','Hoang','99','2018-02-06','Phu Yen','Nam',17000,'006',1)

--lab6_1b
create trigger insert_NhanVien_1b on NHANVIEN
for insert
as
	declare @age int
	set @age = year(getdate()) - (select year(NgSinh) from inserted)
	if (@age < 18 or @age > 65)
		begin
			print 'Tuoi khong hop le'
			rollback transaction
		end
insert into NHANVIEN
values ('Huynh','Cong','Hoang','99','2012-02-06','Phu Yen','Nam',17000,'006',1)

--lab6_1c
create trigger update_NhanVien_1c on NHANVIEN
for update
as
	if(select DCHI from inserted) like '%HCM'
		begin
			print 'Dia chi khong hop le'
			rollback transaction
		end

select * from NHANVIEN
update NHANVIEN set TENNV = 'NamNV' where MANV = '006'

--lab6_2a
create trigger insert_NhanVien_2a on NHANVIEN
after insert
as
begin
	select count(case when upper(phai) = 'Nam' then 1 end) Nam,
		   count(case when upper(phai) = N'Nữ' then 1 end) Nữ
	from NHANVIEN
end

insert into NHANVIEN
values ('Huynh','Cong','Hoang','99','2012-02-06','Phu Yen','Nam',17000,'006',1)

--lab6_2b
create trigger update_NhanVien_2b on NHANVIEN
after update
as
begin
	if update(PHAI)
		begin
			select count(case when upper(PHAI) = 'Nam' then 1 end) Nam,
				   count(case when upper(PHAI) = N'Nữ' then 1 end) Nữ
			from NHANVIEN
		end
end

update NHANVIEN set PHAI = 'Nam' where MANV = '006'
select * from NHANVIEN

--lab6_2c
create trigger count_DeAn_2c on DEAN
after delete
as
	begin
		select MA_NVIEN, COUNT(MADA) as 'So Luong' from PHANCONG
		group by MA_NVIEN
	end

select * from DEAN
delete DEAN where MADA = '22'

--lab6_3a
create trigger delete_THANNHANNV_3a on NHANVIEN
instead of delete
as
begin
	delete from THANNHAN where MA_NVIEN in (select MANV from deleted)
	delete from NHANVIEN where MANV in (select MANV from deleted)
end

delete NHANVIEN where MANV = '001'
select * from NHANVIEN

--lab6_3b
create trigger insert_NhanVien_3b on NHANVIEN
for insert
as 
begin
	insert into PHANCONG values ((select MANV from inserted),1,1,100)
end

insert into NHANVIEN
values ('Huynh','Cong','Hoang','99','2012-02-06','Phu Yen','Nam',17000,'006',1)