--11
	select  K.TenKH, S.TenSV,S.NgaySinh,S.MaKH
	from Khoa as K join SinhVien as S on  S.MaKH = K.MaKH
	where K.TenKH = N'Anh Văn'
--12 ko có khoa vật lí nên thay Bằng Anh Văn
	select  K.TenKH, S.TenSV,S.NgaySinh,S.MaKH
	from Khoa as K join SinhVien as S on  S.MaKH = K.MaKH
	where K.TenKH = N'Anh Văn'
	order by S.NgaySinh asc
--13
		select HoSV+' '+TenSV as [Họ và Tên],MaKH,HocBong,NgaySinh
	from SinhVien
	where HocBong > 100000
	order by MaKH desc
---14
	select HoSV+' '+TenSV as [Họ và Tên],MaKH,HocBong,NgaySinh
	from SinhVien
	where NgaySinh = '12/20/1987'
-- 15 
	select HoSV+' '+TenSV as [Họ và Tên],MaKH,HocBong,NgaySinh
	from SinhVien
	where NgaySinh > '12/20/1977'
	order by NgaySinh asc
-- 16.
	select HoSV+' '+TenSV as [Họ và Tên],MaKH,HocBong,NoiSinh
	from SinhVien
	where HocBong > 10000 and NoiSinh = 'Tp. HCM'
	order by MaKH desc
--17 
	select  S.MaSV,S.MaKH,S.Phai
	from Khoa as K join SinhVien as S on  S.MaKH = K.MaKH
	where K.TenKH = N'Anh Văn' or K.TenKH = N'Triết'
--18
	select HoSV+' '+TenSV as [Họ và Tên],MaSV,HocBong,NoiSinh,NgaySinh
	from SinhVien
	where NgaySinh > '1/1/1986' and  NgaySinh < '5/6/1992'
--19
	select HoSV+' '+TenSV as [Họ và Tên],MaSV,HocBong,NoiSinh,NgaySinh
	from SinhVien
	where HocBong < 800000 and  HocBong > 100000
--20 
	select MaMH,TenMH,Sotiet
	from MonHoc
	where Sotiet>40 and Sotiet<60
--21
	select  S.MaSV,S.HoSV + ' ' + S.TenSV as [Họ và Tên],S.Phai, K.TenKH
	from Khoa as K join SinhVien as S on  S.MaKH = K.MaKH
	where K.TenKH = N'Anh Văn' and S.Phai = 0
--22
	select  MaSV,HoSV + ' ' + TenSV as [Họ và Tên],NgaySinh,NoiSinh
	from SinhVien
	where NgaySinh > '1/1/1990' and NoiSinh = N'Hà Nội'
--23
	select  MaSV,HoSV + ' ' + TenSV as [Họ và Tên],NgaySinh,NoiSinh
	from SinhVien
	where TenSV like '%N%'

	select * from SinhVien
	where NoiSinh = 'Hà Nội'
--24

	select * from SinhVien
	where Phai = 0 and NgaySinh > '05/30/1986'
--25
	select HoSV +' ' + TenSV as [Họ và Tên],iif(Phai = 0,N'Nam',N'Nữ'),NgaySinh
	from SinhVien
--26
	select HoSV +' ' + TenSV as [Họ và Tên],NgaySinh,year(getdate())- year(NgaySinh) as [Tuổi]
	from SinhVien
--27
	select HoSV +' ' + TenSV as [Họ và Tên],year(getdate())- year(NgaySinh) as [Tuổi] , HocBong
	from SinhVien
	where year(getdate())- year(NgaySinh) > 20
--28
	select HoSV +' ' + TenSV as [Họ và Tên],year(getdate())- year(NgaySinh) as [Tuổi],K.TenKH,S.MaKH
	from Khoa as K join SinhVien as S on  S.MaKH = K.MaKH
	where year(getdate())- year(NgaySinh) > 20 and year(getdate())- year(NgaySinh) < 30 
	