/* CREACIÓN DE TABLAS */

CREATE TABLE producto
(
    codProducto NUMERIC primary key,
    nomProducto VARCHAR(100),
    precioCompraUni NUMERIC(7,2),
    precioVentaUni NUMERIC(7,2),
    stock NUMERIC
);
CREATE TABLE personal
(
    codPer NUMERIC PRIMARY KEY,
    nomPer VARCHAR(50),
    apePer VARCHAR(100),
    fecha_nacimiento date,
    edad NUMERIC,
    dni NUMERIC,
    usuPer VARCHAR(50),
    conPer VARCHAR(50)
);
CREATE TABLE estado
(
    idEstado NUMERIC PRIMARY KEY,
    nombreEstado VARCHAR(20)
);

CREATE TABLE caja
(
    codCaja NUMERIC PRIMARY KEY,
    montoCaja NUMERIC(7,2)
);

CREATE TABLE venta
(
    codVenta NUMERIC PRIMARY KEY,
    subtotal NUMERIC(7,2),
    descuentoTotal NUMERIC(7,2),
    importeTotal NUMERIC(7,2),
    fechaRegistro DATE
);

CREATE TABLE cliente
(
    idCliente NUMERIC PRIMARY KEY
);

CREATE TABLE categoria
(
    idCategoria NUMERIC primary key,
    nombreCategoria varchar(20)
);

CREATE TABLE tipo_movimiento
(
    codTipMov NUMERIC primary key,
    nomTipo varchar(20)
);

CREATE TABLE movimiento
(
    codMovimiento NUMERIC primary key,
    fechaMovimiento DATE,
    descripcion varchar(50),
    monto NUMERIC(7,2),
    caja NUMERIC(7,2)
);

CREATE TABLE usuario_externo
(
    idUsuarioExterno NUMERIC PRIMARY KEY,
    nombreCompania varchar(100),
    nombreContacto varchar(100),
    direccionProveedor varchar(200),
    telefono NUMERIC
);

CREATE TABLE proveedor
(
    idProveedor NUMERIC PRIMARY KEY
);

CREATE TABLE pedidos
(
    codPedido NUMERIC PRIMARY KEY,
    cantidad NUMERIC,
    precioCompra NUMERIC(7,2),
    precioCompraUnidad NUMERIC(7,2),
    fechaRegistroP DATE
);

CREATE TABLE venta_detalle
(
    cantidad NUMERIC,
    importe NUMERIC(7,2),
    totalCobrado NUMERIC(7,2),
    descuentoVD NUMERIC(7,2)
);

CREATE TABLE tipo_personal
(
    idTipo NUMERIC PRIMARY KEY,
    nombreTipo VARCHAR(20)
);

/* CREACIÓN DE TABLAS */




/* CREACIÓN DE COLUMNAS FORANEAS */
alter table producto add idCategoria numeric;
alter table producto add estadoProducto numeric;

alter table personal add tipoPersonal numeric;
alter table personal add estadoPersonal numeric;

alter table caja add codPer numeric;

alter table venta add idCliente numeric;
alter table venta add codPer numeric;

alter table cliente add idUsuarioExterno numeric;

alter table movimiento add codPer numeric;
alter table movimiento add codTipMov numeric;

alter table proveedor add idUsuarioExterno numeric;

alter table pedidos add CodProducto numeric;
alter table pedidos add idProveedor numeric;
alter table pedidos add codPer numeric;

alter table venta_detalle add codVenta numeric;
alter table venta_detalle add codProducto numeric;
/* CREACIÓN DE COLUMNAS FORANEAS */



/* CREACIÓN DE RESTRICCIONES */
alter table producto modify nomProducto not null;
alter table producto modify precioCompraUni not null;
alter table producto modify precioVentaUni not null;

alter table personal modify dni not null;

alter table caja modify montoCaja not null;

alter table venta modify subTotal not null;
alter table venta modify descuentoTotal not null;
alter table venta modify importeTotal not null;

alter table movimiento modify fechaMovimiento not null;
alter table movimiento modify descripcion not null;
alter table movimiento modify monto not null;
alter table movimiento modify caja not null;

alter table usuario_externo modify nombreContacto not null;
alter table usuario_externo modify direccionProveedor not null;

alter table pedidos modify cantidad not null;
alter table pedidos modify precioCompra not null;
alter table pedidos modify precioCompraUnidad not null;

alter table venta_detalle modify cantidad not null;
alter table venta_detalle modify importe not null;
alter table venta_detalle modify totalCobrado not null;
alter table venta_detalle modify descuentoVD not null;
/* CREACIÓN DE RESTRICCIONES */



/* CREACIÓN DE LLAVES FORANEAS */
alter table producto add constraint fk_Id_categoria foreign key(idCategoria) references categoria(idCategoria);
alter table producto add constraint fk_estado_producto foreign key(estadoProducto) references estado(idEstado);

alter table personal add constraint fk_tipo_personal foreign key(tipoPersonal) references tipo_personal(idTipo);
alter table personal add constraint fk_estado_personal foreign key(estadoPersonal) references estado(idEstado);

alter table caja add constraint fk_codperc foreign key(codPer) references personal(codPer);

alter table venta add constraint fk_Id_cliente foreign key(idCliente) references cliente(idCliente);
alter table venta add constraint fk_CodPerv foreign key(codPer) references personal(codPer);

alter table cliente add constraint fk_id_usuario_externo foreign key(idUsuarioExterno) references usuario_externo(idUsuarioExterno);

alter table movimiento add constraint fk_CodPer foreign key(codPer) references personal(codPer);
alter table movimiento add constraint fk_CodTipMov foreign key(codTipMov) references tipo_movimiento(codTipMov);

alter table proveedor add constraint fk_id_usuario_externop foreign key(idUsuarioExterno) references usuario_externo(idUsuarioExterno);

alter table pedidos add constraint fk_CodProducto foreign key(codProducto) references producto(codProducto);
alter table pedidos add constraint fk_Id_proveedor foreign key(idProveedor) references proveedor(idProveedor);
alter table pedidos add constraint fk_CodPerpedidos foreign key(codPer) references personal(codPer);

alter table venta_detalle add constraint fk_CodVenta foreign key(codVenta) references Venta(codVenta);
alter table venta_detalle add constraint fk_CodProductovd foreign key(codProducto) references producto(codProducto);   
/* CREACIÓN DE LLAVES FORANEAS */    


/* CREACIÓN DE SP */

/* CREACIÓN DE SP */

/* CREACIÓN DE VISTAS */

/* CREACIÓN DE VISTAS */


/* INSERTAR DATOS */

/* INSERTAR DATOS */