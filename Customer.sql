Drop database Shoppe;
create database Shoppe ;
Use Shoppe;
create table Customer 
(
ID int not null ,
Name Text not null,
PhoneNo varchar(45) not null,
primary key (ID)
);
Insert into Customer ( ID, Name, PhoneNo) Values ( 1,'Nguyen Thi A', '123456');
Insert into Customer ( ID, Name, PhoneNo) Values ( 2,'Nguyen Van B', '67456');
Insert into Customer ( ID, Name, PhoneNo) Values ( 3,'Tran Minh C', '12349');
Insert into Customer ( ID, Name, PhoneNo) Values ( 4,'Tran Lan D', '123776');
Insert into Customer ( ID, Name, PhoneNo) Values ( 5,'Pham Ba I', '189826');
Insert into Customer ( ID, Name, PhoneNo) Values ( 6,'Pham Nguyen G', '891818');
Insert into Customer ( ID, Name, PhoneNo) Values ( 7,'Bui Minh H', '86254');
create table Orderr 
(
ID int not null,
Customer_ID int not null,
primary key (ID),
constraint Customer_ID_FK foreign key (Customer_ID) references Customer (ID)
);
Insert into Orderr (ID, Customer_ID) Values (1,1);
Insert into Orderr (ID, Customer_ID) Values (2,1);
Insert into Orderr (ID, Customer_ID) Values (3,2);
Insert into Orderr (ID, Customer_ID) Values (4,4);
Insert into Orderr (ID, Customer_ID) Values (5,6);
Insert into Orderr (ID, Customer_ID) Values (6,3);
Insert into Orderr (ID, Customer_ID) Values (7,5);
Insert into Orderr (ID, Customer_ID) Values (8,4);
create table Product 
(
ID int not null,
Name varchar(45),
Description Text,
Cost NUMERIC(18,5) NOT NULL,
primary key (ID)
);
Insert into Product (ID, Name, Description,Cost) Values (1, 'Ban chai',' New ',10000);
Insert into Product (ID, Name, Description,Cost) Values (2, 'Tai nghe',' Hot ',100000);
Insert into Product (ID, Name, Description,Cost) Values (3, 'Dien thoai',' Sale ',2500000);
Insert into Product (ID, Name, Description,Cost) Values (4, 'Quan au ',' New ',125000);
Insert into Product (ID, Name, Description,Cost) Values (5, 'Ao somi',' Sale ',230000);
Insert into Product (ID, Name, Description,Cost) Values (6, 'Banh keo',' Combo',99000);
create table OrderItem
(
ID int not null,
Orderr_ID int not null,
Product_ID int not null,
Quantity int not null,
primary key (ID),
constraint Orderr_ID_FK foreign key (Orderr_ID) references Orderr (ID),
constraint Product_ID_FK foreign key (Product_ID) references Product (ID)
);
Insert into OrderItem ( ID, Orderr_ID, Product_ID,Quantity) Values (1, 1, 2, 3);
Insert into OrderItem ( ID, Orderr_ID, Product_ID,Quantity) Values (2, 1, 1, 5);
Insert into OrderItem ( ID, Orderr_ID, Product_ID,Quantity) Values (3, 2, 4, 1);
Insert into OrderItem ( ID, Orderr_ID, Product_ID,Quantity) Values (4, 3, 5, 2);
Insert into OrderItem ( ID, Orderr_ID, Product_ID,Quantity) Values (5, 4, 3, 4);
Insert into OrderItem ( ID, Orderr_ID, Product_ID,Quantity) Values (6, 5, 6, 2);
Insert into OrderItem ( ID, Orderr_ID, Product_ID,Quantity) Values (7, 5, 3, 4);
Insert into OrderItem ( ID, Orderr_ID, Product_ID,Quantity) Values (8, 6, 1, 4);
Insert into OrderItem ( ID, Orderr_ID, Product_ID,Quantity) Values (9, 7, 5, 3);
Insert into OrderItem ( ID, Orderr_ID, Product_ID,Quantity) Values (10, 8, 4, 5);
Drop table OrderItem;
Drop table Product;
Drop table Orderr;
Drop table Customer;
-- 1.
Select 
Cus.Name as 'Tên khách hàng',
Cus.PhoneNo as ' Số điện thoại',
sum( OrI.Orderr_ID) as 'Tổng số đơn hàng'
from  OrderItem Ori
join Orderr Ord On Ori.Orderr_ID = Ord.ID
join Customer Cus On Ord.Customer_ID = Cus.ID
group by Cus.Name, Cus.PhoneNo;
-- 2.
Select 
Ord.ID as ' Mã đơn hàng ',
Pro.Name as ' Tên sản phẩm ',
Ori.Quantity as ' Số lượng ',
Pro.Description as ' Mô tả sản phẩm '
from OrderItem Ori
join Orderr Ord On Ori.Orderr_ID = Ord.ID
join Product Pro On Ori.Product_ID = Pro.ID;
-- 4.
Select 
Pro.Name as 'Tên sản phẩm',
sum(Ori.Quantity) as ' Số lượng đã bán '
from Product Pro 
join OrderItem Ori On Pro.ID = Ori.Product_ID
group by Pro.Name;
-- 5. 
Select
Cus.Name as ' Tên khách hàng ',
sum(Ori.Quantity) as ' Số lượng đã mua ',
sum(Pro.Cost*Ori.Quantity) as 'Tổng tiền' 
from OrderItem Ori 
join Orderr Ord On Ori.Orderr_ID = Ord.ID
join Product Pro On Ori.Product_ID = Pro.ID
join Customer Cus On Ord.Customer_ID = Cus.ID
Group by Pro.Cost, Ori.Quantity;


