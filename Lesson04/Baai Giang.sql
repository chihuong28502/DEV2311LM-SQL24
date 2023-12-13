-- lesson04 truy vấn. SELECT với TSQL
--- truy vấn dữ liệu với 1 hay nhiều bảng với đkien
--- syntax
/*
FROM
ON
JOIN
WHERE
GROUP BY
WITH CUBE or WITH ROLLUP
HAVING
SELECT
DISTINCT
ORDER BY
TOP

*/
-- 1 Select đơn giản( ko có from)
	Select 'Devmaster Academy'
	go
-- 2 Đặt tên cột cho dữ liệu trong tập kết quả
	Select 'Devmaster Academy' as [Company]
	go
-- 3. Truy vấn dữ liệu từ một bảng sử dụng dấu *
	select * from Khoa
	go
	-- liệt kê tất cả dlieu trong bảng khoaa
-- 4. Lựa chọn các cột trong tập kết quả
	select MaKH,TenKH from Khoa
	-- liệt kê các thông tin masv, hosv,tensv
	select MaSV,TenSV,HoSV
	from SinhVien
-- 5. Sử dụng biểu thức trong select
	-- liệt kê các thông tin masv, hosv,ngaysinh trong đó cột họ tên đc gộp từ họ sv và tên sv
	select MaSV,HoSV+''+TenSV as [Họ và Tên],NgaySinh
	from SinhVien
	-- liệt kê điểm và + 10%
	select * ,[DIEM TANG] = Diem * 110/100
	from Ketqua
-- 6. Sử dụng mệnh đề where để giới hạn dữ liệu trong tập kết quả(lọc, tìm kiếm)
	-- Where (dkien) 
	/*
		-Đk sử dụng các phép toán so sánh
		(>,>=,<,<=,=,<>,!=) thường dùng với cột dữ liệu kiểu số
		-Đk sử dụng phép toán tương đối áp dụng với data kiểu string
			+ Like/ !Like: 
				+++ các ký tự đại diện 
					++: %  đại diện cho CHUỖI kí tự bất kì có thể rỗng
					++: dấu _ đại diện cho 1 kí tự bất kì
					++: dấu [a-m] khoảng kí tự từ a-m bao gồm cả chính nó
		-Sử dụng toán tử quan hệ(and , or , not ) trong biểu thức điều kiện
		- DDKien so sánh tập hợp: IN/NOT IN
	*/
	/*
		Select
		from
		where
	*/
	-- Liệt kê sinh viên có học bổng >= 100k
	Select HocBong
	from SinhVien
	where HocBong>=100000
	-- Liệt kê sinh viên có học bổng trong khoảng 10000-100000
	Select HocBong,TenSV
	from SinhVien
	--where HocBong<=100000 and HocBong>= 10000
	where HocBong between 10000 and 100000
	-- so sánh tương đối (Like,Not Like)
		--Liệt kê sinh viên có tên bắt ddaaafu bằng 'T'
		Select * from SinhVien
		where TenSV LIKE N't%'
		-- Liệt kê sinh viên có tên mà ký tự thứ 2 là u
		select *from SinhVien
		where TenSV like N'_u%' 
		go
		--
		select *from SinhVien
		where len(TenSV) = 3
		go
		-- Liệt kê sinh viên có tên có chứa kí tự đầu khoảng a-m
		select *from SinhVien
		where TenSV like N'[a-m]%'
		go
		-- Liệt kê sinh viên có tên ko có chứa kí tự đầu khoảng a-m
		select *from SinhVien
		where TenSV not like N'[a-m]%'
		go
		-- sử dụng tập hợp
			-- liệt kê sinh viên có tháng sinh là tháng 2 và tháng 8
			select *from SinhVien
			where month(NgaySinh) in (2,8)
			-- liệt kê sinh viên có tháng sinh ko  là tháng 2 và tháng 8
			select *from SinhVien
			where month(NgaySinh) not in (2,8)

--------------------============================================>
--7. sắp xếp dữ liệu trong tập kq .
	-- sắp tăng order by <column name> |<index> | <alise name> asc(mặc định)
	-- sắp giảm order by desc
	-- liệt kê sinh viên dữ liệu sắp theo tên sinh viên tăng dần
	Select MaSV, TenSV as[Tên sinh viên], HoSV as [Họ sinh viên] from SinhVien
	order by TenSV asc
	--
	Select MaSV, TenSV as[Tên sinh viên], HoSV as [Họ sinh viên] from SinhVien
	order by 3 asc
	-- tên bí danh
	Select MaSV, TenSV as[Tên sinh viên], HoSV as [Họ sinh viên] from SinhVien
	order by [Tên sinh viên] asc
	---DESC
	Select MaSV, TenSV as[Tên sinh viên], HoSV as [Họ sinh viên] from SinhVien
	order by TenSV desc

--- liệt kê sinh viên, dữ liệu sắp theo tên giảm dần , nếu trùng thì sắp theo hosv giảm dần
	Select MaSV, TenSV as[Tên sinh viên], HoSV as [Họ sinh viên] from SinhVien
	order by TenSV asc, HoSV desc


	--====================================>
	--1
	select MaMH,TenMH,Sotiet
	from MonHoc
	--2
	select MaSV,TenSV,Phai,NgaySinh
	from SinhVien
	order by MaSV desc
	--3
	select MaSV,TenSV,Phai,NgaySinh
	from SinhVien
	order by TenSV asc
	--4
	select MaSV +''+TenSV as [Họ và Tên],NgaySinh,HocBong
	from SinhVien
	order by NgaySinh desc, HocBong asc
	--5
	select MaMH,TenMH,Sotiet
	from MonHoc
	where TenMH like N'T%'
	--6
	select HoSV+' '+TenSV as [Họ và tên], NgaySinh,Phai
	from SinhVien
	where  RIGHT(TenSV,1) like 'i%'
	--7
	select MaKH,TenKH
	from Khoa
	where TenKH like '_N%'
	--8 
	select HoSV+' '+ TenSV as[Họ và Tên]
	from SinhVien
	where HoSV like N'%Thị%'
	--9 
	select MaSV,TenSV,Phai,HocBong
	from SinhVien
	where TenSV like N'[a-m]%'
	--10
	select MaSV,TenSV,Phai,HocBong
	from SinhVien
	where TenSV like N'%[a-m]%'
	--15
	SELECT [MaSV], [HoSV], [TenSV], [Phai], CONVERT(VARCHAR(10),NgaySinh,103) as 'NGAYSINH',[NOISINH],[HocBong]
	FROM SinhVien
	where NgaySinh > '1988/12/20'
	order by NgaySinh desc

--=>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--7 từ khóa top
	-- top trích ra bản ghi đầu tiên trong số tập kết quả
	select top 1 *
	from SinhVien
	-- lấy học bổng cao nhất
	select top 1  with TIES *
	from SinhVien
	order by HocBong desc
-- 8 sử dụng distinct trong select
	-- loại bỏ dòng trùng lặp giữ lại 1
	select distinct MaKH
	from SinhVien
--9 sử dụng case ... when... then trong select
	--:lk sinh viên, trong phái hiển thị ra: 1 => Nam, 0=> Nữ; null => Khác
	select TenSV ,Phai = case  when Phai=1 then N'Nam' when Phai = 0 then N'Nữ' else N'Khác'
					end
	from SinhVien
--10 sử dụng iif
select  TenSV, [Phái] = iif(Phai = 1 , N'Nam',iif(Phai = 0,N'Nữ',N'Khác'))
from SinhVien
--11 truy vấn kết hợp 2 hay nhiều bảng (JOIN)
	/*
		Inner join
		left join/ left outer join
		right join/ right outer join
		full join/ full outer join
	*/
	select * from Khoa order by MaKH	
	select * from SinhVien order by MaKH

	-- inner join:
		select * from Khoa as K
		join SinhVien S on K.MaKH = S.MaKH
		--where
		select * from SinhVien as S,Khoa as K
		where K.MaKH= S.MaKH
		-- left join
		select * from Khoa as K
			left join SinhVien S on K.MaKH = S.MaKH
		-- right join
		select * from Khoa as K
			right join SinhVien S on K.MaKH = S.MaKH
			-- full join
		select * from Khoa as K
			full join SinhVien S on K.MaKH = S.MaKH

		-- liệt kê thoong tin
		select K.MaKH,TenKH
		from Khoa as K
		join SinhVien as S on K.MaKH = S.MaKH

	-- liệt kê các thông tin mã khoa tên khoa, hosv,ten,phhai,diem
	
		select K.MaKH,K.TenKH,S.MaSV,HoSV,TenSV,Phai,DiemTrungBinh
		from Khoa as K
		join SinhVien as S on K.MaKH = S.MaKH
		join Ketqua as Q on S.MaSV = Q.MaSV
		-- designer
SELECT        Khoa.MaKH, Khoa.TenKH, SinhVien.MaSV, SinhVien.HoSV, SinhVien.TenSV, SinhVien.Phai, Ketqua.Diem
FROM              Khoa INNER JOIN
                               SinhVien ON Khoa.MaKH = SinhVien.MaKH INNER JOIN
                               Ketqua ON SinhVien.MaSV = Ketqua.MaSV

							   go
SELECT        Ketqua.MaSV AS Expr1, Ketqua.MaMH AS Expr2, Ketqua.*, SinhVien.*, Khoa.*
FROM              Khoa INNER JOIN
                               SinhVien ON Khoa.MaKH = SinhVien.MaKH LEFT OUTER JOIN
                               Ketqua ON SinhVien.MaSV = Ketqua.MaSVSELECT        Ketqua.MaSV, Khoa.MaKH, Khoa.TenKH, MonHoc.MaMH, SinhVien.MaSV AS Expr1, Ketqua.Diem, SinhVien.HoSV, SinhVien.TenSV, SinhVien.Phai, MonHoc.TenMH
FROM              Ketqua INNER JOIN
                               MonHoc ON Ketqua.MaMH = MonHoc.MaMH INNER JOIN
                               SinhVien ON Ketqua.MaSV = SinhVien.MaSV INNER JOIN
                               Khoa ON SinhVien.MaKH = Khoa.MaKH


							   ---lab4