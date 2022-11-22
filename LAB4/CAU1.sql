DECLARE @TBTHONGKE TABLE(MaPB INT,LuongTB FLOAT)

INSERT INTO @TBTHONGKE
	SELECT PHG, AVG(LUONG) FROM NHANVIEN 
	GROUP BY PHG
SELECT * FROM @TBTHONGKE

SELECT TENNV, PHG, LUONG, LuongTB,
IIF(LUONG>LuongTB,'KHONG TANG LUONG','TANG LUONG') AS TINHTRANG
FROM NHANVIEN
INNER JOIN @TBTHONGKE a
ON NHANVIEN.PHG = a.MaPB