
DECLARE @MAX INT, @NUM INT;
SELECT @MAX = MAX(CAST(MANV AS INT)) FROM NHANVIEN;

SET @NUM =1;

WHILE @NUM <= @MAX
BEGIN
	IF @NUM=4
	BEGIN
		SET @NUM=@NUM+1;
		CONTINUE;
	END

	IF @NUM %2 =0
	SELECT HONV,TENLOT, TENNV from NHANVIEN where cast (MANV as int) = @num;

	SET @NUM = @NUM +1;
END;