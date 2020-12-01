--- consultas a la base de datos
select * from caja
select * from categoria
select * from cliente
select * from estado
select * from movimiento
select * from pedidos
select * from personal
select * from producto
select * from proveedor
select * from tipo_personal
select * from TipoMovimiento
select * from UsuarioExterno
select * from Venta
select * from venta_detalle

-- funciones de agregacion, consultas, subconsultas

select * from caja where MontoCaja between 2000 and 4000

select * from personal where ApePer like 'P%'

select * from personal where NomPer like '[A-D]%'

select * from personal where estado_personal = (select id_estado from estado where nombre_estado = 'Activo' )

select * from venta_detalle where CodVenta in (select CodVenta from Venta where CodPer = 4 )

select * from UsuarioExterno where nombre_compañia != ''

select * from movimiento where CodAdm in (select CodPer from personal where estado_personal = 1) and CodTipoMov = 1

select CodVenta, sum(Importe) as importe,sum(total_cobrado) as total_cobrado,sum(descuentoVD) as descuento from venta_detalle group by CodVenta

select top 3 * from UsuarioExterno order by id_usuario_externo desc

select * from producto where estado_producto = 2 and PrecioCompraUni >= 10

select * from pedidos where id_proveedor in ( select id_usuario_externo from UsuarioExterno where nombre_contacto like '[A-N]%')

select top 3 * from pedidos order by PrecioCompra desc

--joins

select c.id_cliente,ue.* from cliente c inner join UsuarioExterno ue on c.id_usuario_externo = ue.id_usuario_externo where nombre_compañia != ''

select p.CodPer,p.NomPer,p.ApePer,v.CodVenta,v.importetotal from Venta v right join personal p on v.CodPer = p.CodPer

select prov.id_proveedor,ue.nombre_compañia  ,pe.* from pedidos pe inner join proveedor prov on pe.id_proveedor = prov.id_proveedor inner join UsuarioExterno ue on prov.id_usuario_externo = ue.id_usuario_externo

select * from venta_detalle vd inner join venta v on vd.CodVenta = v.CodVenta inner join producto pro on vd.CodProducto = pro.CodProducto

select * from personal per inner join tipo_personal tp on per.tipo_personal = tp.id_tipo where NomPer like '[A-D]%' and edad between 20 and 30

select ue.nombre_contacto,v.* from venta v right join cliente c on v.id_cliente = c.id_cliente inner join UsuarioExterno ue on c.id_usuario_externo = ue.id_usuario_externo

select m.*,tm.NomTipo from movimiento m inner join TipoMovimiento tm on m.CodTipoMov = tm.CodTipoMov where tm.NomTipo = 'Ingresos'

select p.CodPer ,p.NomPer, c.* from personal p left join caja c on c.CodPer = p.CodPer where MontoCaja >= 2000

select v.CodVenta,sum(vd.Importe) as Importe_venta,v.Fecha_Registro as importe_Venta from venta_detalle vd inner join venta v on vd.CodVenta = v.CodVenta group by v.CodVenta,v.Fecha_Registro having sum(importe) >= 500 

select v.CodPer,p.NomPer,sum(v.subtotal) as subtotal,sum(v.importetotal) as importetotal,sum(v.descuentototal) as descuentototal from Venta v inner join personal p on v.CodPer = p.CodPer group by v.CodPer,p.NomPer

select * from personal p inner join estado e on p.estado_personal = e.id_estado where e.nombre_estado = 'Anulado'

select top 3 pro.NomProducto, pro.PrecioVentaUni,cat.nombre_categoria from producto pro inner join categoria cat on pro.id_categoria = cat.id_categoria where cat.nombre_categoria like '[A-L]%' order by PrecioVentaUni desc

--- vistas
--1
create view personal_anulado
as 
select * from personal p inner join estado e on p.estado_personal = e.id_estado where e.nombre_estado = 'Anulado'
go
select * from personal_anulado

--2
create view movimiento_ingresos
as
select m.*,tm.NomTipo from movimiento m inner join TipoMovimiento tm on m.CodTipoMov = tm.CodTipoMov where tm.NomTipo = 'Ingresos'
go
select * from movimiento_ingresos

--3
create view personal_activo
as
select * from personal where estado_personal = (select id_estado from estado where nombre_estado = 'Activo' )
go
select * from personal_activo order by NomPer asc

--4
create view ventas_personal
as
select p.CodPer,p.NomPer,p.ApePer,v.CodVenta,v.importetotal from Venta v right join personal p on v.CodPer = p.CodPer
go
select * from ventas_personal 

--5
alter view ventas_personal
as
select p.CodPer,p.NomPer,p.ApePer,v.CodVenta,v.importetotal,v.Fecha_Registro from Venta v right join personal p on v.CodPer = p.CodPer
go
select * from ventas_personal 

--6
drop view ventas_personal

--funciones

--1
create function Ver_Caja(@nomPersona varchar(30))
returns table
as 
return (select p.CodPer as codigo ,p.NomPer, c.* from personal p left join caja c on c.CodPer = p.CodPer where p.NomPer = @nomPersona)
go

select * from Ver_Caja('Lorena')

--2
create function ImporteVenta(@codventa int)
returns decimal(7,2) 
as
begin
declare @monto decimal(7,2)
select @monto = v.importetotal from Venta v where v.CodVenta = @codventa
return @monto
end

declare @monto decimal(7,2)
exec @monto=ImporteVenta '2'
select @monto as importe_de_venta

--3
create function venta_producto_filtrada(@letraInicial char(1),@letraFinal char(1))
returns table
as
return (select pro.NomProducto, pro.PrecioVentaUni,cat.nombre_categoria from producto pro inner join categoria cat on pro.id_categoria = cat.id_categoria where cat.nombre_categoria like '['+@letraInicial+'-'+@letraFinal+']%' )

select * from venta_producto_filtrada('A','B') ORDER BY PrecioVentaUni desc

--4
create function filtrar_personal_estado(@estado varchar(20))
returns table
as
return (select * from personal p inner join estado e on p.estado_personal = e.id_estado where e.nombre_estado = @estado)

select * from filtrar_personal_estado('Anulado')

--5
create function filtrar_personal(@estado varchar(20),@tipo varchar(20))
returns table
as
return (select * from personal p inner join estado e on p.estado_personal = e.id_estado inner join tipo_personal tp on p.tipo_personal = tp.id_tipo where e.nombre_estado = @estado and tp.nombre_tipo = @tipo)

select * from filtrar_personal('Activo','Administrador')

--6

create function filtrar_personal_Edad(@edad1 int,@edad2 int)
returns table
as	
return (select * from personal per inner join tipo_personal tp on per.tipo_personal = tp.id_tipo where edad between @edad1 and @edad2)

select * from filtrar_personal_Edad(20,25)

--procedimientos almacenados
--1
CREATE PROCEDURE agregarPersona
(	@id int,
	@Nombre NVARCHAR(50),
	@apellidos NVARCHAR(50),
	@fecNac date,
	@edad int,
	@dni int,
	@usuario NVARCHAR(50),
	@contraseña NVARCHAR(50),
	@tipo int,
	@estado int)
AS
IF NOT EXISTS (SELECT * FROM personal WHERE CodPer = @Id)
BEGIN
       if LEN(@dni) !=8
		begin
			print 'el dni debe tener 8 digitos'
			return
		end
	   INSERT INTO personal
       VALUES (@id,@Nombre,@apellidos,@fecNac,@edad,@dni,@usuario,@contraseña,@tipo,@estado)
	    print 'personal registrado correctamente'
end
else 
begin
 print 'ya hay un personal registrado con ese codigo'
end

exec agregarPersona 11,'bryan','fernandez','1999-09-09',20,75283977,'bfernandez','123',1,1

--2
create procedure RegistrarUsuarioExterno
(
	@id int,
	@idusuario int,
	@compañia varchar(40),
	@contacto varchar(40),
	@direccion varchar(100),
	@telefono int,
	@tipoUsu varchar(30)
)
as
IF NOT EXISTS (SELECT * FROM UsuarioExterno WHERE id_usuario_externo = @idusuario )

BEGIN
	if LEN(@telefono) !=9
		begin
			print 'el telefono debe tener 9 digitos'
			return
		end	
	if @tipoUsu = 'Cliente'
	begin
		if not exists (SELECT * FROM cliente WHERE id_cliente = @id) 
		begin
		 INSERT INTO UsuarioExterno
		 VALUES (@idusuario,@compañia,@contacto,@direccion,@telefono)
		 INSERT INTO cliente
		 VALUES (@id,@idusuario)
		 print 'cliente registrado correctamente'
		 return
		end
	end
	if @tipoUsu = 'Proveedor'
	begin
		if not exists (SELECT * FROM proveedor WHERE id_proveedor = @id)
		begin
		 INSERT INTO UsuarioExterno
		 VALUES (@idusuario,@compañia,@contacto,@direccion,@telefono)
		 INSERT INTO proveedor
		 VALUES (@id,@idusuario)
		 print 'proveedor registrado correctamente'
		 return
		end
	end
END
else 
begin
 print 'ya hay un usuario externo registrado con ese codigo'
end

exec RegistrarUsuarioExterno 7,12,'','Joel','Los Olivos',987256321,'Cliente'

--3
create procedure RegistrarVenta
(
	@codventa int,
	@idcliente int,
	@idpersonal int,
	@idproducto int,
	@cantidad int,
	@importe decimal(7,2),
	@total_cobrado decimal(7,2),
	@descuento decimal(7,2)
)
as

IF NOT EXISTS (SELECT * FROM venta WHERE CodVenta = @codventa )
begin
	
	insert into Venta values(@codventa,@idcliente,@idpersonal,@importe,@descuento,@total_cobrado,getdate())
	insert into venta_detalle values(@codventa,@idproducto,@cantidad,@importe,@total_cobrado,@descuento)
	update producto set Stock = Stock - @cantidad where CodProducto = @idproducto
end
else
begin 
	if @idcliente = (select id_cliente from Venta where CodVenta = @codventa )
	begin
		insert into venta_detalle values(@codventa,@idproducto,@cantidad,@importe,@total_cobrado,@descuento)
		update venta set CodPer=@idpersonal, subtotal += @importe, descuentototal += @descuento, importetotal += @total_cobrado where CodVenta = @codventa 
		update producto set Stock = Stock - @cantidad where CodProducto = @idproducto
	end
	else
	begin
		print 'el cliente no corresponde con la venta'
	end
end

exec RegistrarVenta 5,5,8,7,2,43.60,43.00,0.60


--4
create procedure MantenimientoCaja
(
	@codcaja int,
	@codmovimiento int,
	@codper int,
	@descripcion varchar(100),
	@monto decimal(7,2),
	@codadm int,
	@tipomov varchar(30)
)
as
declare @nuevoMonto decimal(7,2)
if not exists (select * from movimiento where CodMovimiento = @codmovimiento)
begin
	if not exists (select * from caja where CodCaja = @codcaja)
	begin
		insert into movimiento values (@codmovimiento,getdate(),@descripcion,@monto,@monto,@codadm,1)
		insert into caja values(@codcaja,@monto,@codper)
	end
	else
	begin
		if @codper = (select CodPer from caja where CodCaja = @codcaja)
		begin
			if @tipomov = 'Ingreso'
			begin 
				update caja set MontoCaja = MontoCaja + @monto where CodCaja = @codcaja
				select @nuevoMonto = MontoCaja from caja where CodCaja = @codcaja
				insert into movimiento values (@codmovimiento,getdate(),@descripcion,@monto,@nuevoMonto,@codadm,1)
				return
			end
			if @tipomov = 'Egreso'
			begin 
				update caja set MontoCaja = MontoCaja - @monto where CodCaja = @codcaja
				select @nuevoMonto = MontoCaja from caja where CodCaja = @codcaja
				insert into movimiento values (@codmovimiento,getdate(),@descripcion,@monto,@nuevoMonto,@codadm,2)
				return
			end
		end
		else
		begin
			print 'El personal no corresponde a la caja seleccionada'
		end
	end
end
else
begin
	print 'ya hay un movimiento registrado con ese codigo'
end

exec MantenimientoCaja 10,13,11,'egreso descripcion 2',1.00,1,'Egreso'


--5

create procedure NuevoPedido
(
	@codpedido int,
	@codproducto int,
	@id_proveedor int,
	@codadm int,
	@cantidad int,
	@preciocompra decimal(7,2)
)
as
if not exists (select * from pedidos where CodPedido = @codpedido)
