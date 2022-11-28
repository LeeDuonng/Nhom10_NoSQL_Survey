--lab5_1a
create procedure  lab5_1a  @ten nvarchar(50)
as
	begin
		print 'Xin chào'+ @ten
	end
exec lab5_1a N'Dương'

--lab5_1b
create procedure  lab5_1b  @s1 int , @s2 int
as
	begin 
		declare @tg int
		set @tg= @s1+ @s2
		print N'Tổng là:' + cast(@tg as varchar(10))
	end
exec lab5_1b 9,5

--lab5_1c
create procedure lab5_1c @n int
as
declare @i int, @tong int
set @i = 0
set @tong = 0
if @n % 2 !=0 set @n=@n-1
while @i <= @n
	begin
		set @tong = @tong + @i
		set @i = @i + 2
	end
print 'Tong cac so chan tu 1 -> '+ @n +'la: '+ @tong
exec lab5_1c 10

--lab5_1d
create procedure lab5_1d @a int, @b int
as
    begin
	while (@a != @b)
		begin
		 if (@a > @b)
		   set @a = @a -@b
	     else
		   set @b = @b - @a 
		end
		return @a
	end
declare @c int
exec @c= lab5_1d 10,60
print @c