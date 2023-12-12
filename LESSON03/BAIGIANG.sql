﻿-- 1 Tạo csdl bằng lệnh t-SQL
use master
go 
create database DEV2311LM_SQL24_03
go

	-- tạo csdl với các thuộc tính cơ bản
	create database DEV2311LM_SQL24_03
	on
	(NAME = DEV2311LM_SQL24_03_DATA,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DEV2311LM_SQL24_03.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
(NAME = DEV2311LM_SQL24_03_log,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DEV2311LM_SQL24_03_log.ldf',
    SIZE = 5 MB,
    MAXSIZE = unlimited,
    FILEGROWTH = 5 MB);
GO
-- 2. Tạo bảng và các ràng buộc
	-- các kiểu dữ liệu
	/*
		kiểu số: số nguyên, số thực
			++ số nguyên: tinyint/ smallInt/ Int/ bigInt
			++ số thực: float/ double/ decimal/ numberic
		 chuỗi: non unicode/unicode
			++ non unicode: char/varchar/text
			++ unicode: nvarchar/nchar/ntext
			++fixed length: char/nchar
			++ dynamic length: varchar/nvarchar
		date: smallDateTime/ Datetime/date/time....
		logic: bit
		kiểu nhị phân: binary/ 

	*/

	/*
	Các ràng buộc dữ liệu
		null/not null
		Duy nhất: Primary key/ Unique / identity/ kiểu dữ liệu uniqueIdentifier
		Ràng buộc tham chiếu: foreign key
		Ràng buộc miền giá trị: (Domain): DataType/ check constraint
		Thuộc tính default: 

		++ ràng buộc phức tạp: Trigger

		--Tạo cấu trúc bảng dữ liệu
		2.1 tạo bảng đơn giản

	*/
	USE DEV2311LM_SQL24_03
	create table TABLE1(
	COL1 INT,
	COL2 VARCHAR(100)
	)
	--2.2 TẠO BẢNG VỚI RÀNG BUỘC PRIMARY KEY

	CREATE TABLE VATTU(
	MAVT CHAR(4) PRIMARY KEY,
	TENVT NVARCHAR(50) NOT NULL,
	DVTINH NVARCHAR(20) ,
	PHANTRAM REAL

	)
	DROP TABLE VATTU

	
	CREATE TABLE VATTU(
	MAVT CHAR(4) CONSTRAINT PK_VATTU PRIMARY KEY,
	TENVT NVARCHAR(50) NOT NULL,
	DVTINH NVARCHAR(20) ,
	PHANTRAM REAL

	)

	--- TẠO BẢNG DỮ LIỆU VỚI KHÓA CHÍNH 2 TRÊN NHIỀU CỘT
	CREATE TABLE TABLE2(
	COL1 INT,
	COL2 INT,
	COL3 NVARCHAR(100),
	CONSTRAINT PK_TABLE2 PRIMARY KEY(COL1,COL2)
	)

	-- TẠO BẢNG VỚI RÀNG BUỘC KHÓA CHÍNH VÀ DỮ LIỆU TỰ ĐỘNG TĂNG IDENTITY
	CREATE TABLE TABLE3(
	COL1 INT IDENTITY(1,1) CONSTRAINT PK_TABLE3 PRIMARY KEY,
	COL2 NVARCHAR(100),
	COL3 TINYINT
	)

	-- 2.4 TẠO BẢNG VỚI RÀNG BUỘC UNIQUE
	CREATE TABLE NHACC(
	MANHACC CHAR(3) CONSTRAINT PK_NHACC PRIMARY KEY,
	TENNCC NVARCHAR(200) CONSTRAINT UQ_NHACC_TENNCC UNIQUE,
	DIACHI NVARCHAR(250),
	DIENTHOAI VARCHAR(50),
	)
	--2.5: TẠO BẢNG VỚI THUỘC TÍNH DEFAULT
	DROP TABLE NHACC
	CREATE TABLE NHACC(
	MANHACC CHAR(3) CONSTRAINT PK_NHACC PRIMARY KEY,
	TENNCC NVARCHAR(200) CONSTRAINT UQ_NHACC_TENNCC UNIQUE,
	DIACHI NVARCHAR(250) CONSTRAINT DF_NHACC_DIACHI DEFAULT '25 VŨ NGỌC PHAN',
	DIENTHOAI VARCHAR(50),
	)
	--2.6 RÀNG BUỘC MIỀN GIÁ TRỊ CHECK CONSTRAINT
	DROP TABLE DONDH;
	CREATE TABLE CHITIETDONDATHANG(
	SODH CHAR(4),
	MAVT CHAR(4),
	SLDAT TINYINT CONSTRAINT CK_CHITIETDONDATHANG_SLDAT CHECK (SLDAT>0 AND SLDAT<150),
	CONSTRAINT PK_CHITIETDONDATHANG PRIMARY KEY(SODH,MAVT)
	)

	CREATE TABLE DONDH(
	SODH CHAR(4) NOT NULL CONSTRAINT PK_DONDH PRIMARY KEY,
	NGAYDH DATE DEFAULT GETDATE(),
	MANHACC CHAR(3) NOT NULL
	)

	-- 2.7 TẠO BẢNG VỚI RÀNG BUỘC KHÓA NGOẠI
	DROP TABLE CHITIETDONDATHANG
	CREATE TABLE CTDONDH(
	SODH CHAR(4) CONSTRAINT PK_CTDONDH_DONDH_SOHD FOREIGN KEY REFERENCES DONDH , -- ( DONDH(SODH))
	MAVT CHAR(4),
	SLDAT TINYINT CONSTRAINT CK_CHITIETDONDATHANG_SLDAT CHECK (SLDAT>0 AND SLDAT<150),
	CONSTRAINT PK_CHITIETDONDATHANG PRIMARY KEY(SODH,MAVT),
	CONSTRAINT FK_CTDONDH_VATTU_MAVT FOREIGN KEY (MAVT) REFERENCES VATTU
	ON UPDATE CASCADE
	ON DELETE NO ACTION
	)
	--2.8 SỬA ĐỔI BẢNG ĐƠN ĐẶT HÀNG 
		-- BỔ XUNG KHÓA NGOẠI (MANHACC) THAM CHIẾU TỚI BẢNG NCC
		ALTER TABLE DONDH
		ADD CONSTRAINT FK_DONDH_NHACC FOREIGN KEY (MANHACC) REFERENCES NHACC(MANHACC)
			ON UPDATE CASCADE
			ON DELETE NO ACTION
	-- THÊM CỘT
		ALTER TABLE DONDH 
		ADD TONGTRIGIA NUMERIC(18,2)
	-- XÓA CỘT
	ALTER TABLE DONDH
	DROP COLUMN TONGTRIGIA

	sp_rename 'dbo.DONDH.TONGTRIGIA','SSS','COLUMN';

-- 3. Các câu lệnh DML 
	--3.1 ĐỌC DỮ LIỆU TỪ NGUỒN
	SELECT *FROM VATTU
	--3.2 INSERT: THÊM 1 HAY NHIỀU BẢN GHI VÀO BẢNG
	INSERT  VATTU(MAVT,TENVT,DVTINH,PHANTRAM)
	VALUES('VT01',N'TỦ LẠNH LG 204',N'CHIẾC','40')
	-- KHÔNG THÊM GIÁ TRỊ CHO CỘT IDENTITY
	-- CỘT CÓ GIÁ TRỊ DEFAULT HOẶC NULL CÓ THỂ KHÔNG CẦN THÊM GIÁ TRỊ
	-- MẶC ĐỊNH KHI THÊM GIÁ TRỊ TÊN CỘT KHÓA NGOẠI THÌ GIÁ TRỊ ĐÓ PHẢI TỒN TẠI TRÊN CỘT THAM CHIẾU TRÊN BẢNG 1 TƯƠNG ỨNG
	-- THÊM NHIỀU BẢNG GHI CÙNG LÚC CÁCH NHAU BỞI DẤU ,
		INSERT VATTU (MAVT,TENVT,DVTINH,PHANTRAM)
	VALUES
	('VT06',N'TỦ LẠNH LG 204',N'CHIẾC','12'),
	('VT02',N'TỦ LẠNH LG 205',N'CHIẾC','25'),
	('VT03',N'TỦ LẠNH LG 206',N'CHIẾC','78'),
	('VT04',N'TỦ LẠNH LG 207',N'CHIẾC','40')


	-- INSERT SELECT
	INSERT VATTU
	SELECT 'VT07',N'TỦ LẠNH LG 207',N'CHIẾC','40'

	--------------------------------------->
	-- GHI CHÚ:
		-- DỮ LIỆU CHUỖI NON UNICODE: ĐẶT TRONG ''
		-- DỮ LIỆU CHUỖI UNICODE: ĐẶT TRONG '' VÀ PHÍA TRC CÓ N
		-- DỮ LIỆU KIỂU DATE: DEFAULT GETDATE(). MẶC ĐỊNH ĐẶT TRONG DẤU NHÁY ĐƠN '' THEO ĐỊNH DẠNG: MM/DD/YYYY
	--3.3 UPDATE --> SỬA ĐỔI DỮ LIỆU TRÊN CỘT TRONG BẢNG
		-- XÓA CŨ, ĐỔI MỚI
		/*
		UPDATE <TABLE_NAME> [SOURCE]
		SET <COLUMN_NAME> = <GIÁ TRỊ>/ <[COLUMN_SOURCE]>[,.........]
		WHERE <DKIEN>
		*/
		-- CẬP NHẠT CỘT % TRONG BẢNG VẬT TỬ UP 10
		SELECT *FROM VATTU
		UPDATE VATTU SET PHANTRAM = PHANTRAM+10

		UPDATE VATTU SET PHANTRAM = PHANTRAM/10 WHERE PHANTRAM>=50

	-- 3.4 XÓA DELETE
		DELETE FROM VATTU WHERE MAVT='VT07'

		-- KHI XÓA DỮ LIỆU TRÊN BẢNG MÀ CÓ LIÊN KẾT BÊN NHIỀU THÌ CHÚ Ý TỚI DDKIEN THAM CHIẾU (ON DELETE NO ACTION)
		--NEXT: SELECT