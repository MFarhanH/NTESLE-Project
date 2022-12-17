 /*Pertanyaan
 1.	Tampilkan SupplierName, IngredientName, Total Quantity (diperoleh dari jumlah kuantitas yang dibeli) 
	untuk setiap Ingredient yang namanya mengandung “sugar” dan dibeli pada bulan Mei.*/

	SELECT 
		SupplierName, IngredientsName, SUM(IngredientsQtty) AS TotalQty
	FROM
	Supplier sp JOIN PurchaseTransaction pt ON sp.SupplierId = pt.SupplierId
	JOIN DetailPurchaseTransaction dpt ON dpt.PurchaseId = pt.PurchaseId 
	JOIN Ingredients ig ON ig.IngredientsId = dpt.IngredientsId
	WHERE IngredientsName LIKE '%Sugar%'
	AND MONTH(DatePurchase) = 5
	GROUP BY SupplierName,IngredientsName
	go

/*
 2.	Tampilkan StaffName, StaffGender, StaffSalary, 
	dan Total Transaksi (didapat dari jumlah total penjualan) 
	untuk setiap staf yang gajinya antara 6 juta hingga 7 juta 
	dan total transaksi lebih dari 1. */

	SELECT
		StaffName,StaffGender, COUNT(SalesTransactionId) AS TotalPenjualan
	FROM
	Staff sf JOIN SalesTransaction st ON sf.StaffId = st.StaffId
	WHERE Salary BETWEEN 6000000 AND 7000000
	GROUP BY StaffName,StaffGender,Salary
	HAVING COUNT(SalesTransactionId) > 1
	GO

/*
  3.Tampilkan Nama Pelanggan, Nomor Telepon Pelanggan (diperoleh dengan mengganti "+62" dengan "0"), 
	Nama Produk, Total Transaksi (diperoleh dari jumlah total transaksi), dan Total Harga Produk 
	(diperoleh dari jumlah semua harga produk yang dibeli) untuk setiap produk yang namanya memiliki 
	setidaknya dua kata dan kedaluwarsa setahun setelah 2021*/
	
	SELECT
			CustomerName,
			STUFF(cs.CustomerPhone,1,1,'0') AS NoTelpPelanggan,
			ProductName, COUNT(st.SalesTransactionId) AS TotalPenjualan,
			SUM(Price*ProductQtty) AS TotalHargaProduk
	FROM
	Customer cs JOIN SalesTransaction st ON cs.CustomerId = st.CustomerId
	JOIN DetailSalesTransaction dt ON st.SalesTransactionId = dt.SalesTransactionId
	JOIN Product pd ON pd.ProductId = dt.ProductId
	WHERE ProductName  LIKE '% %'
	AND YEAR(ExpiredDate) > 2021
	GROUP BY CustomerName,CustomerPhone,ProductName

/*
  4.Menampilkan Total Price (didapat dari penjumlahan harga bahan), IngredientName, dan 
    Total Transaksi (didapat dari hitungan transaksi pembelian) untuk setiap transaksi pembelian yang 
	dilakukan oleh staf yang berusia lebih dari 19 tahun pada tahun 2020 dan masa berlaku bahan tersebut sudah habis 
	tahun setelah 2024. Kemudian urutkan data dalam format ascending berdasarkan total harga. */

	SELECT
		COUNT(IngredientsPrice) AS TotalPrice,
		ig.IngredientsName, 
		COUNT(pt.PurchaseId) AS TotalTransaksi
	FROM Staff st JOIN PurchaseTransaction pt ON
	st.StaffId = pt.StaffId JOIN DetailPurchaseTransaction dpt
	ON dpt.PurchaseId = pt.PurchaseId JOIN Ingredients ig
	ON ig.IngredientsId = dpt.IngredientsId
	WHERE StaffDOB <'2021' AND IngredientsExpiredDate <'2024'
	GROUP BY ig.IngredientsName,IngredientsPrice, pt.PurchaseId
	ORDER BY IngredientsPrice DESC

/*
  5. Menampilkan StaffName, Gender (diperoleh dari karakter pertama Staff Gender), 
     StaffDOB, StaffSalary, dan SalesTransactionID untuk setiap pembelian yang dilakukan oleh staf yang gajinya 
	 lebih dari rata-rata semua gaji yang digabungkan dan lahir setelah tahun 2000. Kemudian urutkan datanya 
	 secara menaik format berdasarkan tahun lahir staf.*/

	  SELECT
		StaffName, StaffGender,
		StaffDOB, Salary, stf.StaffId

	 FROM Staff stf JOIN SalesTransaction stc ON 
	 stf.StaffId = stc.StaffId,
	 (
			SELECT AVG(Salary) AS ratarata
			FROM Staff) AS x
	 WHERE  Salary > x.ratarata AND YEAR(StaffDOB)> '2000'
	 GROUP BY StaffName, StaffGender,
		StaffDOB, Salary, stf.StaffId
	 ORDER BY StaffDOB ASC
/*
	6.Menampilkan Nomor Pemasok (diperoleh dari 3 karakter ID Pemasok terakhir), Nama Pemasok, Nama Bahan, 
	  Harga Bahan (diperoleh dengan menambahkan 'Rp.' Di depan Harga Bahan), dan 
	  Tanggal EXPIRED Bahan untuk setiap Bahan yang harganya lebih dari atau sama dengan rata-rata dari 
	  semua harga gabungan dan tahun kedaluwarsa setelah 2022. (alias subkueri)*/

	  SELECT
			RIGHT (sp.SupplierId,3) AS NomorPemasok, SupplierName,ig.IngredientsName, 
			IngridientPrice = 'Rp. ' + CAST(IngredientsPrice AS VARCHAR),
			IngredientsExpiredDate
	  FROM Supplier sp JOIN PurchaseTransaction pt ON sp.SupplierId = pt.SupplierId
	  JOIN DetailPurchaseTransaction dpt ON dpt.PurchaseId = pt.PurchaseId JOIN
	  Ingredients ig ON ig.IngredientsId = dpt.IngredientsId,
		(SELECT 
			AVG(IngredientsPrice) AS RataRataHargaGabungan
	  FROM Ingredients) AS x
	  WHERE IngredientsPrice >= x.RataRataHargaGabungan
	  AND YEAR (IngredientsExpiredDate) > 2022


/*
	7.	Tampilan SupplierID, SupplierName, Supplier Local Phone Number (didapat dengan mengubah angka pertama menjadi '+62'), 
		SupplierAddress, dan Total Price (didapat dari penjumlahan Ingredient Price dikali Kuantitas) untuk setiap pembelian dari pemasok 
		yang nama belakangnya adalah makanan dan harga total lebih besar dari harga total rata-rata. Kemudian urutkan data dalam 
		format descending berdasarkan total harga.
		(alias subkueri)*/

		SELECT
				sp.SupplierId,SupplierName, STUFF(SupplierPhone,1,1,'+62') AS SupplierLocalNumb,
				SuppplierAddress, SUM(IngredientsPrice*IngredientsQtty) AS TotalHarga

		FROM Supplier sp JOIN PurchaseTransaction pt ON sp.SupplierId = pt.SupplierId
		JOIN DetailPurchaseTransaction dpt ON pt.PurchaseId = dpt.PurchaseId
		JOIN Ingredients ig ON ig.IngredientsId = dpt.IngredientsId,
			(SELECT AVG(IngredientsPrice*IngredientsQtty) AS RataRata
			 FROM Ingredients ig JOIN DetailPurchaseTransaction dpt ON ig.IngredientsId = dpt.IngredientsId) AS x
		WHERE SupplierName LIKE '%Food' 
		GROUP BY sp.SupplierId,SupplierName,SupplierPhone,SuppplierAddress,x.RataRata
		HAVING SUM(IngredientsPrice*IngredientsQtty) >= x.RataRata
		ORDER BY TotalHarga DESC
		go


/*	
	8.  Tampilan CustomerName, SalesTransactionID, SalesDate (diperoleh dari SalesDate dalam format 'dd Mon yyyy'), 
		DateName (diperoleh dari Name of the m Day di SalesDate), Quantity (diperoleh dengan menambahkan 'Piece (s)' di akhir 
		Kuantitas), ProductName, SalesPrice (diperoleh dengan m enambahkan 'Rp.' Di depan Harga Produk) dan Harga Total 
		(diperoleh dengan menambahkan 'Rp.' Di depan jumlah Harga Produk dikali Kuantitas) untuk setiap transaksi penjualan yang 
		kuantitasnya lebih dari kuantitas terendah dan kurang dari kuantitas tertinggi. Kemudian urutkan data dalam format ascending 
		berdasarkan kuantitasnya. (alias subkueri)*/

		SELECT 
			CustomerName,
			st.SalesTransactionID,
			SalesDate = CONVERT(VARCHAR, SalesDate, 106),
			[DateName] =DATENAME (WEEKDAY, SalesDate),
			[Quantity] = CAST(ProductQtty as VARCHAR) + ' piece(s)', 
			ProductName,
			[SalesPrice]='RP. ' + CAST(Price AS VARCHAR),
			[Total Price] = 'Rp. ' + CAST(SUM(Price*ProductQtty)AS VARCHAR)
		FROM Customer cs
		JOIN SalesTransaction st ON cs.CustomerID= st.CustomerID
		JOIN DetailSalesTransaction ds ON ds.SalesTransactionID = st.SalesTransactionID
		JOIN Product pd ON pd.ProductID = ds.ProductID,
			(
				SELECT 
					HighestQuantity = MAX(ProductQtty),
					LowestQuantity = MIN(ProductQtty)
				FROM DetailSalesTransaction
			) as x
		WHERE ProductQtty < x.HighestQuantity 
		AND ProductQtty > x.LowestQuantity
		GROUP BY CustomerName, st.SalesTransactionID,  salesDate, ProductName, Price, ProductQtty
		ORDER  BY ProductQtty ASC

/*  9.  Buat tampilan bernama “SalesTransactionView” untuk menampilkan StaffName, StaffPhoneNumber, Total Transaksi 
		(diperoleh dari hitungan ID Transaksi Penjualan), dan Kuantitas Tertinggi (diperoleh dari jumlah maksimal) 
		untuk setiap transaksi penjualan yang terjadi setelah Agustus dan Total Transaksi adalah lebih dari 2.*/
	
		CREATE VIEW SalesTransactionView 
		AS
		SELECT
			StaffName,
			StaffPhone,
			[Total Transaction]= COUNT(st.SalesTransactionID),
			[Highest Quantity] = Max(ProductQtty) 
		FROM Staff sf
		JOIN SalesTransaction st ON sf.StaffID = st.StaffID
		JOIN DetailSalesTransaction dt ON dt.SalesTransactionID = st.SalesTransactionID
		WHERE DATENAME(MONTH, SalesDate) > 'August'
		GROUP BY StaffName, StaffPhone
		HAVING COUNT(st.SalesTransactionID)>2
		GO

		SELECT * FROM SalesTransactionView		
/* 10.  Buat tampilan bernama “PurchaseTransactionView” untuk menampilkan SupplierName, SupplierPhoneNumber, 
		Total Transaksi (diperoleh dari hitungan ID Transaksi Pembelian), IngredientExpiredDate, IngredientName, 
		IngredientPrice, dan Harga Bahan Total (diperoleh dari jumlah Harga Bahan) untuk setiap Ingredient yang kedaluwarsa 
		pada tahun 2023 dan Harga Bahan Total lebih dari 60.000.*/
		CREATE VIEW PurchaseTransactionView
		AS
		SELECT
			SupplierName,SupplierPhone,
			[TotalTransaksi] = COUNT(pt.PurchaseId),
			IngredientsExpiredDate,IngredientsName,
			IngredientsPrice,
			[HargaBahanTotal] = SUM(IngredientsPrice)
		FROM Supplier sp JOIN PurchaseTransaction pt ON sp.SupplierId = pt.SupplierId
		JOIN DetailPurchaseTransaction dpt ON pt.PurchaseId = dpt.PurchaseId
		JOIN Ingredients ig ON ig.IngredientsId = dpt.IngredientsId
		WHERE YEAR(IngredientsExpiredDate) LIKE '2023'
		GROUP BY SupplierName,SupplierPhone,IngredientsExpiredDate,IngredientsPrice, IngredientsName
		HAVING SUM(IngredientsPrice) > 60000
		GO
		
		SELECT*
		FROM PurchaseTransactionView