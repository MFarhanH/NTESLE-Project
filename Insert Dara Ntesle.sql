--INSERT DATA

BEGIN TRAN
INSERT INTO Customer VALUES
		('CS001', 'Nando', '+628102918341', 'Jl Kiasmawi no 135'),
		('CS002', 'Enrico', '+628918238121', 'Jl Kasuari no 56'),
		('CS003', 'Riko', '+628212304342', 'Jl Sabang no 34'),
		('CS004', 'Fino', '+628912342214', 'Jl Kancil no 21'),
		('CS005', 'Doni Alamsyah', '+628718221892', 'Jl Munawarman no 24'),
		('CS006', 'Sakti Arif', '+628799917645', 'Jl Cabang no 45'),
		('CS007', 'Dimas', '+628281817498', 'Jl Nahkoda no 999'),
		('CS008', 'Fina Alistia', '+628227788877', 'Jl Cendrawasih no 18'),
		('CS009', 'Gina', '+628212304342', 'Jl Sabang no 98'),
		('CS010', 'Cyntia', '+628978383444', 'Jl Manila no 283'),
		('CS011', 'Dino', '+628819129992', 'Jl Greenvile no 255')
COMMIT

INSERT INTO ProductType VALUES
		('PT001', 'Biscuits'),
		('PT002', 'Milk'),
		('PT003', 'Vitamin'),
		('PT004', 'Pet Food'),
		('PT005', 'Coffee'),
		('PT006', 'Mineral Water'),
		('PT007', 'Noodle'),
		('PT008', 'Cereals'),
		('PT009', 'Frozen Food'),
		('PT010', 'Candy')

INSERT INTO Product VALUES
		('PD001', 'Ntesle Kelapa', 5000, '2021-06-21', 'PT001'),
		('PD002', 'Ntesle Milk', 6000, '2021-05-22', 'PT002'),
		('PD003', 'Inbost', 10000, '2024-09-21', 'PT003'),
		('PD004', 'Wishkas', 12000, '2022-02-09', 'PT004'),
		('PD005', 'Coffies latte', 8000, '2022-01-21', 'PT005'),
		('PD006', 'Saqua', 5000, '2025-06-11', 'PT006'),
		('PD007', 'nteslemie', 5500, '2024-06-21', 'PT007'),
		('PD008', 'Creakers', 25000, '2023-05-11', 'PT008'),
		('PD009', 'Chicken wings', 20000, '2025-06-08', 'PT009'),
		('PD010', 'Pagoda', 5000, '2025-01-11', 'PT010')

BEGIN TRAN
INSERT INTO Staff VALUES
		('ST001', 'Dzaky', 'Male', '08792323428', '1990-05-21', 2000000), 
		('ST002', 'Chika', 'Female', '08911122299', '2002-01-22', 6000000),
		('ST003', 'Hilmi', 'Male', '08221002933', '1999-04-21', 2000000),
		('ST004', 'Riki', 'Male', '08123955563', '2002-01-09', 7200000),
		('ST005', 'Sadam', 'Male', '0891829919', '1988-04-21', 2000000),
		('ST006', 'Mufti', 'Male', '0891829919', '1988-04-21', 4000000),
		('ST007', 'Heru Jackson', 'Male', '08720339322', '1987-11-01', 4000000),
		('ST008', 'Werni Haresh', 'Female', '08898812222', '1988-09-22', 4000000),
		('ST009', 'Wicaksono', 'Male', '08993945922', '1985-11-09', 3000000),
		('ST010', 'Gbastian', 'Male', '08394854455', '2002-04-07', 3000000)
COMMIT

BEGIN TRAN
INSERT INTO SalesTransaction VALUES
		('SL001', 'ST001', 'CS001','2020-08-28'),
		('SL002', 'ST001', 'CS002','2020-08-28'),
		('SL003', 'ST003', 'CS003','2020-08-28'),
		('SL004', 'ST008', 'CS005','2020-08-29'),
		('SL005', 'ST010', 'CS007','2020-08-29'),
		('SL006', 'ST005', 'CS002','2020-08-30'),
		('SL007', 'ST006', 'CS009','2020-09-01'),
		('SL008', 'ST009', 'CS006','2020-09-01'),
		('SL009', 'ST004', 'CS008','2020-09-01'),
		('SL010', 'ST004', 'CS002','2020-09-02'),
		('SL011', 'ST002', 'CS010','2020-09-02'),
		('SL012', 'ST009', 'CS007','2020-09-02'),
		('SL013', 'ST007', 'CS009','2020-09-03'),
		('SL014', 'ST002', 'CS004','2020-09-03'),
		('SL015', 'ST009', 'CS005','2020-09-03')
ROLLBACK

BEGIN TRAN
INSERT INTO DetailSalesTransaction VALUES 
		('SL001', 'PD001', 9),
		('SL001', 'PD002', 2),
		('SL002', 'PD008', 10),
		('SL002', 'PD003', 20),
		('SL002', 'PD009', 22),
		('SL003', 'PD001', 5),
		('SL003', 'PD004', 10),
		('SL004', 'PD002', 6),
		('SL004', 'PD003', 15),
		('SL005', 'PD005', 8),
		('SL005', 'PD007', 23),
		('SL006', 'PD010', 20),
		('SL007', 'PD006', 30),
		('SL007', 'PD009', 9),
		('SL008', 'PD007', 15),
		('SL008', 'PD010', 25),
		('SL009', 'PD001', 20),
		('SL009', 'PD004', 20),
		('SL010', 'PD001', 5),
		('SL010', 'PD002', 25),
		('SL011', 'PD002', 10),
		('SL012', 'PD007', 15),
		('SL012', 'PD004', 11),
		('SL013', 'PD009', 30),
		('SL014', 'PD004', 23),
		('SL015', 'PD008', 28)
COMMIT

BEGIN TRAN
INSERT INTO Supplier VALUES
		('SU001', 'PT.Gulu-gulu' ,'02134448555', 'Jl Industrial no 1'),
		('SU002', 'PT.Sarirasa' ,'02189988811', 'Jl Murven no 25'),
		('SU003', 'PT.Salinas Group' ,'02133322222', 'Jl Kasuari no 12'),
		('SU004', 'PT.Garimis Food' ,'02177766333', 'Jl Galaksi no 50'),
		('SU005', 'PT.Indofuk' ,'0214455882', 'Jl Charles no 35'),
		('SU006', 'PT.Natakata Food' ,'02177788888', 'Jl kancil no 19'),
		('SU007', 'PT.Indorasa' ,'02145556666', 'Jl Industrial no 20'),
		('SU008', 'PT.Garakosta' ,'02198887777', 'Jl Kiasmawi no 225'),
		('SU009', 'PT.Safatara Food' ,'02133555667', 'Jl Nusadua no 35'),
		('SU010', 'PT.Wiratama' ,'0212225555', 'Jl Satuhati no 22')

BEGIN TRAN
INSERT INTO Ingredients VALUES
		('IG001', 'Sugar', 1000, '2023-04-05'),
		('IG002', 'Salt', 50000, '2024-05-05'),
		('IG003', 'Ragi', 20000, '2025-04-05'),
		('IG004', 'Wheat', 50000, '2023-05-06'),
		('IG005', 'Seasonings', 30000, '2026-05-10'),
		('IG006', 'Milk Powder', 400000, '2026-05-10'),
		('IG007', 'Chocolate', 600000, '2025-11-09'),
		('IG008', 'Vit A,b,c', 2000, '2025-01-01'),
		('IG009', 'Margarine', 20000, '2024-09-11'),
		('IG010', 'Coffee Powder', 1000, '2026-01-01'),
		('IG011', 'Water', 10000, '2026-01-01'),
		('IG012', 'Oil', 25500, '2026-01-01'),
		('IG013', 'Food flavoring', 7000, '2026-01-01'),
		('IG014', 'Soy sauce', 35000, '2026-01-01'),
		('IG015', 'Chilli sauce', 35000, '2026-01-01')

BEGIN TRAN
INSERT INTO PurchaseTransaction VALUES
		('PU001','ST001','SU002','2020-05-02'),
		('PU002','ST003','SU001','2020-05-11'),
		('PU003','ST002','SU001','2020-06-02'),
		('PU004','ST004','SU005','2020-05-02'),
		('PU005','ST005','SU004','2020-07-12'),
		('PU006','ST007','SU003','2020-07-18'),
		('PU007','ST006','SU007','2020-08-21'),
		('PU008','ST001','SU006 ','2020-09-01'),
		('PU009','ST009','SU010','2020-09-08'),
		('PU010','ST001','SU004','2020-09-15'),
		('PU011','ST001','SU009 ','2020-09-18'),
		('PU012','ST004','SU008','2020-10-12'),
		('PU013','ST002','SU005','2020-10-14'),
		('PU014','ST003','SU002','2020-10-20'),
		('PU015','ST005','SU004','2020-11-22')

BEGIN TRAN
INSERT INTO DetailPurchaseTransaction VALUES
		('PU001','IG002','15'),
		('PU001','IG012','10'),
		('PU002','IG001','8'),
		('PU002','IG011','20'),
		('PU003','IG001','10'),
		('PU003','IG011','10'),
		('PU004','IG005','40'),
		('PU004','IG015','10'),
		('PU005','IG004','20'),
		('PU005','IG013','30'),
		('PU006','IG003','20'),
		('PU006','IG014','22'),
		('PU007','IG007','20'),
		('PU008','IG006','50'),
		('PU009','IG010','15'),
		('PU010','IG004','30'),
		('PU010','IG013','25'),
		('PU011','IG009','39'),
		('PU012','IG008','15'),
		('PU013','IG005','15'),
		('PU013','IG015','15'),
		('PU014','IG002','80'),
		('PU014','IG012','80'),
		('PU015','IG004','20'),
		('PU015','IG013','20')
------------------------------------------------------------------------------