﻿SELECT TENPHG, COUNT(MANV) AS 'SONV', AVG(LUONG) AS 'LUONGTB'
FROM NHANVIEN INNER JOIN PHONGBAN
ON NHANVIEN.PHG = PHONGBAN.MAPHG
GROUP BY TENPHG
HAVING AVG(LUONG) > 30000