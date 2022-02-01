use master 
GO
ALTER DATABASE [TestAM] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
IF EXISTS ( SELECT [name] FROM sys.databases WHERE [name] = 'TestAM')
drop database TestAM 
go
Create database TestAM
go
use TestAM
go
IF EXISTS ( SELECT [name] FROM sys.tables WHERE [name] = 'FirstName')
drop table FirstName
go
create table FirstName
( 
nameid int identity Primary Key,
firstname varchar (10)
)
go
IF EXISTS ( SELECT [name] FROM sys.tables WHERE [name] = 'Surname')
drop table Surname
go
create table Surname
(
lastnameid  int identity Primary Key,
lastname varchar (15)
)
go 
ALTER TABLE FirstName
ALTER COLUMN firstname varchar(10) NOT NULL;
go
ALTER TABLE Surname
ALTER COLUMN lastname varchar(15) NOT NULL;
go 
insert FirstName (firstname) values ('Sergiy')
insert Surname (lastname) values ('Pshenichny')
insert FirstName (firstname) values ('Anton')
insert Surname (lastname) values ('Mosiakin')
insert FirstName (firstname) values ('Andriy')
insert Surname (lastname) values ('Suprun')
insert FirstName (firstname) values ('Aleksandr')
insert Surname (lastname) values ('K')
insert FirstName (firstname) values ('Aleksandr')
insert Surname (lastname) values ('Suprun')
insert FirstName (firstname) values ('Viktor')
insert Surname (lastname) values ('Zaiets')
go
update Surname set lastname = 'Kachala' where lastname = 'K'
GO
select fn.firstname + ln.lastname as [Full Name]
from FirstName as fn
join Surname as ln
on fn.nameid=ln.lastnameid
go
create table userdata
(
hobby nvarchar(30)
)
go
alter table userdata
add email nvarchar(40) not null,
id_data int primary key
go
alter table userdata
add constraint UQ_userdata_email unique(email)
go
ALTER TABLE userdata
   ADD CONSTRAINT FK_FirstName FOREIGN KEY (id_data)
      REFERENCES dbo.FirstName (nameid)
      ON DELETE CASCADE
      ON UPDATE CASCADE
go 
insert userdata (id_data, email, hobby) values (1, 'doctorserka@gmail.com', 'keyboards')
insert userdata (id_data, email, hobby) values (2, 'tonynow23a@gmail.com', 'anime')
insert userdata (id_data, email, hobby) values (3, 'suprun@gmail.com', 'box')
insert userdata (id_data, email, hobby) values (4, 'sura_kpi@gmail.com', 'coffee')
insert userdata (id_data, email, hobby) values (5, 'suprunalex@gmail.com', 'cars')
insert userdata (id_data, email, hobby) values (6, 'viktor@gmail.com', 'tanks')
GO
/*
select fn.firstname as Name, ln.lastname as Surname, cast(ud.email as nvarchar(20))
from FirstName as fn
join Surname as ln on fn.nameid=ln.lastnameid
join userdata as ud on fn.nameid=ud.email
*/
GO