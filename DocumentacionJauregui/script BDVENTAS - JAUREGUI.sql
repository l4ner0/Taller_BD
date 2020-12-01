create database BDventas

use BDventas
create table tipo_personal(
	id_tipo int not null  primary key,
	nombre_tipo varchar(20) CHECK (nombre_tipo in ('Administrador','Empleado')),
);

insert into tipo_personal values (1,'Administrador')
insert into tipo_personal values(2,'Empleado')

go

select * from tipo_personal


create table estado(
	id_estado int not null primary key,
	nombre_estado varchar(20) CHECK (nombre_estado in ('Activo','Suspendido','Anulado')),
);

insert into estado values (1,'Activo'),(2,'Suspendido'),(3,'Anulado')
 go

 select * from estado

create table personal(
    CodPer int not null PRIMARY KEY,
    NomPer varchar(50),
    ApePer varchar(100),
	fecha_nacimiento date,
	edad int,
	dni int not null check (len(dni) = 8),
    UsuPer varchar(50),
    ConPer varchar(50),
	tipo_personal int foreign key references tipo_personal(id_tipo),
	estado_personal int foreign key references estado(id_estado)
);

insert into personal values (1,'Juan','Perez','10/08/98','21','78924568','Juancin','1234','1','1')
insert into personal values (2,'Pedro','Ramirez','02/02/96','23','75845692','Parel','5124','2','2')
insert into personal values	(3,'Lorena','Herrera','09/07/90','30','75846231','Larinel','0054','2','1')
insert into personal values	(4,'Dayana','Martinez','12/11/94','25','71258964','Dayani','7489','2','1')
insert into personal values	(5,'Raul','Fernandez','05/02/92','28','79425134','Ralaso','1456','2','1')
insert into personal values	(6,'Victor','Cuevas','03/08/94','26','78451236','Vickd','8956','2','1')
insert into personal values	(7,'Lalo','Padilla','06/03/89','31','74259761','Lalin','0345','2','2')
insert into personal values	(8,'Renato','Canevaro','04/12/98','21','71845963','Retillo','7354','2','2')
insert into personal values	(9,'Angelica','Araoz','03/10/91','29','77584613','Angell','7112','2','3')
insert into personal values	(10,'Lindsay','Mara','07/06/95','27','71455698','Lindss','7145','2','3')
go

select * from personal


create table caja(
	CodCaja int not null  PRIMARY KEY,
    MontoCaja decimal(7,2) not null,
    CodPer int not null REFERENCES personal(CodPer)
);

insert into caja values (1,'1000.35','1')
insert into caja values (2,'1548.27','2')	
insert into caja values (3,'1925.14','10'),(4,'2145.87','4'),(5,'4256.65','5'),(6,'1725.39','6'),
                        (7,'3628.20','7'),(8,'2618.89','8'),(9,'1627.27','9')

select * from caja

create table TipoMovimiento(
	CodTipoMov int not null  PRIMARY KEY,
    NomTipo varchar(20) CHECK (NomTipo in ('Ingresos','Egresos'))
);

insert into TipoMovimiento values (1,'Ingresos'),(2,'Egresos')

select * from TipoMovimiento


create table movimiento(
    CodMovimiento int not null  PRIMARY KEY,
    Fecha_Movimiento date not null,
    Descripcion varchar(50) not null,
    Monto decimal(7,2) not null,
    Caja decimal(7,2) not null,
    CodAdm int not null references personal(CodPer),
    CodTipoMov int not null references tipomovimiento(CodTipoMov)
    
);

insert into movimiento values (1,'04/02/19','Traslado de caja','500.14','1345.71','2','1')
insert into movimiento values (2,'01/03/19','Retiro de dinero','600.23','1456.87','2','2'),
                              (3,'05/04/19','Traslado de caja','800.94','1556.22','2','1'),
							  (4,'03/05/19','Retiro de dinero','707.24','1789.65','4','2'),
							  (5,'07/06/19','Traslado de caja','714.36','1444.31','4','1'),
							  (6,'08/07/19','Traslado de caja','815.88','1896.21','4','1'),
							  (7,'02/08/19','Traslado de caja','945.23','1778.23','2','1'),
							  (8,'03/09/19','Retiro de dinero','651.31','1784.15','5','2'),
							  (9,'09/11/19','Traslado de caja','785.36','1799.22','5','2'),
							  (10,'01/12/19','Traslado de caja','410.33','1895.65','5','1')
go

select * from movimiento

create table categoria(
	id_categoria int not null  PRIMARY KEY,
    nombre_categoria varchar(20)
);

insert into categoria values (1,'Bebidas'),(2,'Alimentos'),(3,'Accesorios'),(4,'Deporte'),(5,'Ropa'),
                             (6,'Lacteos'),(7,'Electrodomestios'),(8,'Tecnologia'),(9,'Muebles'),(10,'Licores')
go 

select * from categoria							

create table producto(
    CodProducto int not null PRIMARY KEY,
    NomProducto varchar(100) not null,
	PrecioCompraUni decimal(7,2) not null,
    PrecioVentaUni decimal(7,2) not null,
    Stock int,
	id_categoria int foreign key references categoria(id_categoria),
	estado_producto int foreign key references estado(id_estado)
);

insert into producto values (1,'IncaKola 3l.','8.00','10.50','48','1','1') 
insert into producto values (2,'Pulsera Dama','1.00','2.30','32','3','1'),
							(3,'PantalonJean','23.80','45.78','8','5','1'),
							(4,'YogurGloria','5.10','8.40','56','6','1'),
							(5,'SmartTvSamsung','1555.20','2199.99','2','8','1'),
							(6,'ZapatillasPuma','52.84','101.20','3','4','1'),
							(7,'PolloEntero','10.50','21.80','64','2','2'),
							(8,'RefrigeradoraLG','325.60','599.60','18','7','2'),
							(9,'SillonSala','70.26','150.30','31','9','1'),
							(10,'RedLabel','45.33','75.99','105','10','3')

select * from producto


create table UsuarioExterno(
	id_usuario_externo int not null  PRIMARY KEY,
	nombre_compañia varchar(100),
	nombre_contacto varchar(100) not null,
	direccion_proveedor varchar(200) not null,
	telefono int check ( LEN(telefono)=9)
);

insert into UsuarioExterno values	(1,'FINDSA.SA','Susana','Callao.LaPunta','987256314')
insert into UsuarioExterno values	(2,'','Beatriz','CercadoDeLima.Independencia','956321478')
insert into UsuarioExterno values	(3,'LARENZ.SA','Roberto','S.J.L.LasFlores','998745565')
insert into UsuarioExterno values	(4,'RORIL.SA','Enrique','Comas.Bayobar','963654789')
insert into UsuarioExterno values	(5,'LARALEL.SA','Luis','SanIsidro.Mariscal','956321223')
insert into UsuarioExterno values	(6,'','Maricarmen','Miraflores.Wiese','944785654')
insert into UsuarioExterno values	(7,'WASOLE.SA','Christian','Breña.CantoGrande','996358965')
insert into UsuarioExterno values	(8,'TALELO.SA','Yesenia','LaVictoria.Proceres','993556123')
insert into UsuarioExterno values	(9,'DLOEAS.SA','Angelo','Lince.CajaDeAgua','966338745')
insert into UsuarioExterno values	(10,'','Mauricio','Ate.Chimu','966331523')

go
select * from UsuarioExterno

create table proveedor(
	id_proveedor int not null  PRIMARY KEY,
	id_usuario_externo int foreign key references UsuarioExterno(id_usuario_externo)
);

insert into proveedor values (1,'1'),(2,'3'),(3,'8'),(4,'9')

go 

select * from proveedor

create table cliente(
	id_cliente int not null  PRIMARY KEY,
	id_usuario_externo int foreign key references UsuarioExterno(id_usuario_externo)
);

insert into cliente values (1,'2'),(2,'4'),(3,'5'),(4,'6'),(5,'7'),
                           (6,'10')
go

select * from cliente


create table pedidos(
	CodPedido int not null  PRIMARY KEY,
    CodProducto int not null REFERENCES producto(CodProducto),
	id_proveedor int not null references proveedor(id_proveedor),
	CodAdm int not null REFERENCES personal(CodPer),
    Cantidad int not null,
    PrecioCompra decimal(7,2) not null,
	PrecioCompraUnidad decimal(7,2) not null,
	Fecha_RegistroP datetime
       
);

insert into pedidos values (1,'1','1','1','80','640.00','8.00','05/02/2019')
 insert into pedidos values(2,'2','1','1','100','100.00','1.00','04/03/2019'),
						   (3,'3','1','1','10','238.00','23.80','08/04/2019'),
						   (4,'4','2','1','95','484.50','5.10','09/05/2019'),
						   (5,'5','2','1','2','3110.40','1555.20','01/06/2019'),
						   (6,'6','2','1','4','211.36','52.84','03/07/2019'),
						   (7,'7','4','1','20','210.00','10.50','07/09/2019'),
						   (8,'8','4','1','20','6512.00','325.60','09/010/2019'),
						   (9,'9','4','1','12','843.12','70.26','02/11/2019'),
						   (10,'10','3','1','24','1087.92','45.33','04/12/2019')
go

select * from pedidos 
                    

create table Venta(
    CodVenta int not null  PRIMARY KEY,
    id_cliente int references cliente(id_cliente),
	CodPer int references personal(CodPer),
	subtotal decimal(7,2) not null,
	descuentototal decimal(7,2) not null,
	importetotal decimal(7,2) not null,
    Fecha_Registro datetime
);
insert into Venta values (1,'1','4','50.20','2.30','47.90','01/01/19'),
						 (2,'2','4','42.66','6.20','36.46','07/03/19'),
						 (3,'3','6','78.60','4.21','74.39','02/05/19'),
						 (4,'4','6','36.12','9.35','27.89','09/07/19')

go

select * from Venta

create table venta_detalle(
    CodVenta int not null references Venta(CodVenta),
    CodProducto int not null references producto(CodProducto),
    Cantidad int not null,
    Importe decimal(7,2) not null,
	total_cobrado decimal(7,2) not null,
	descuentoVD decimal(7,2) not null,  
);

insert into venta_detalle values (1,1,10,'185.30','117.65','21.36'),
                                 (1,2,12,'175.99','135.96','20.31'),
								 (1,3,2,'144.21','126.34','14.23'),
								 (2,4,15,'133.87','177.89','11.52'),
								 (2,5,1,'2199.99','2199.99','0.00'),
								 (2,6,2,'198.56','133.58','17.88'),
								 (3,7,9,'111.25','198.36','22.36'),
								 (3,8,8,'106.32','185.25','21.05'),
								 (4,9,6,'187.95','215.94','12.11'),
								 (4,10,5,'288.45','122.33','10.06')

go
select * from venta_detalle