/* CREACIÓN DE TABLAS */

CREATE TABLE producto
(
    CodProducto NUMERIC primary key,
    NomProducto VARCHAR(100) NOT NULL,
    PrecioCompraUni NUMERIC(7,2) NOT NULL,
    PrecioVentaUni NUMERIC(7,2) NOT NULL,
    Stock NUMERIC
);
CREATE TABLE personal
(
    CodPer NUMERIC PRIMARY KEY,
    NomPer VARCHAR(50),
    ApePer VARCHAR(100),
    fecha_nacimiento date,
    edad NUMERIC,
    dni NUMERIC NOT NULL,
    UsuPer VARCHAR(50),
    ConPer VARCHAR(50)
);
CREATE TABLE estado
(
    Id_estado NUMERIC PRIMARY KEY,
    Nombre_estado VARCHAR(20)
);

CREATE TABLE caja
(
    CodCaja NUMERIC PRIMARY KEY,
    MontoCaja NUMERIC(7,2) NOT NULL
);

CREATE TABLE Venta
(
    CodVenta NUMERIC PRIMARY KEY,
    subtotal NUMERIC(7,2) NOT NULL,
    descuentototal NUMERIC(7,2) NOT NULL,
    importetotal NUMERIC(7,2) NOT NULL,
    Fecha_Registro DATE
);

CREATE TABLE cliente
(
    Id_cliente NUMERIC PRIMARY KEY
);

CREATE TABLE categoria
(
    Id_categoria NUMERIC primary key,
    nombre_categoria varchar(20) not null
);

CREATE TABLE TipoMovimiento
(
    CodTipMov NUMERIC primary key NOT NULL,
    NomTipo varchar(20)
);

CREATE TABLE movimiento
(
    CodMovimiento NUMERIC primary key,
    Fecha_Movimiento DATE NOT NULL,
    Descripcion varchar(50) NOT NULL,
    Monto NUMERIC(7,2) NOT NULL,
    Caja NUMERIC(7,2) NOT NULL
);

CREATE TABLE UsuarioExterno
(
    id_usuario_externo NUMERIC PRIMARY KEY,
    Nombre_compañia varchar(100),
    nombre_contacto varchar(100) not null,
    Direccion_proveedor varchar(200) not null,
    Telefono NUMERIC
);

CREATE TABLE proveedor
(
    Id_proveedor NUMERIC PRIMARY KEY
);

CREATE TABLE pedidos
(
    CodPedido NUMERIC PRIMARY KEY,
    Cantidad NUMERIC NOT NULL,
    PrecioCompra NUMERIC(7,2) NOT NULL,
    PrecioCompraUnidad NUMERIC(7,2) NOT NULL,
    Fecha_RegistroP DATE
);

CREATE TABLE venta_detalle
(
    Cantidad NUMERIC NOT NULL,
    Importe NUMERIC(7,2) NOT NULL,
    Total_cobrado NUMERIC(7,2) NOT NULL,
    DescuentoVD NUMERIC(7,2) NOT NULL
);

CREATE TABLE tipo_personal
(
    Id_tipo NUMERIC PRIMARY KEY,
    Nombre_tipo VARCHAR(20)
);

/* CREACIÓN DE TABLAS */

/* CREACIÓN DE COLUMNAS FORANEAS */
alter table producto add Id_categoria numeric not null;
alter table producto add estado_producto numeric;

alter table personal add tipo_personal numeric;
alter table personal add estado_personal numeric;

alter table caja add CodPer numeric;

alter table venta add Id_cliente numeric;
alter table venta add CodPer numeric;

alter table cliente add id_usuario_externo numeric;

alter table movimiento add CodPer numeric;
alter table movimiento add CodTipMov numeric;

alter table proveedor add id_usuario_externo numeric;

alter table pedidos add CodProducto numeric;
alter table pedidos add Id_proveedor numeric;
alter table pedidos add CodPer numeric;

alter table venta_detalle add CodVenta numeric;
alter table venta_detalle add CodProducto numeric;
/* CREACIÓN DE COLUMNAS FORANEAS */

/* CREACIÓN DE RESTRICCIONES */

/* CREACIÓN DE RESTRICCIONES */


/* CREACIÓN DE LLAVES FORANEAS */
alter table producto add constraint fk_Id_categoria foreign key(Id_categoria) references categoria(Id_categoria);
alter table producto add constraint fk_estado_producto foreign key(estado_producto) references estado(Id_estado);

alter table personal add constraint fk_tipo_personal foreign key(tipo_personal) references tipo_personal(Id_tipo);
alter table personal add constraint fk_estado_personal foreign key(estado_personal) references estado(Id_estado);

alter table caja add constraint fk_codperc foreign key(CodPer) references personal(CodPer);

alter table venta add constraint fk_Id_cliente foreign key(Id_cliente) references cliente(Id_cliente);
alter table venta add constraint fk_CodPerv foreign key(CodPer) references personal(CodPer);

alter table cliente add constraint fk_id_usuario_externo foreign key(id_usuario_externo) references UsuarioExterno(id_usuario_externo);

alter table movimiento add constraint fk_CodPer foreign key(CodPer) references personal(CodPer);
alter table movimiento add constraint fk_CodTipMov foreign key(CodTipMov) references TipoMovimiento(CodTipMov);

alter table proveedor add constraint fk_id_usuario_externop foreign key(id_usuario_externo) references UsuarioExterno(id_usuario_externo);

alter table pedidos add constraint fk_CodProducto foreign key(CodProducto) references producto(CodProducto);
alter table pedidos add constraint fk_Id_proveedor foreign key(Id_proveedor) references proveedor(Id_proveedor);
alter table pedidos add constraint fk_CodPerpedidos foreign key(CodPer) references personal(CodPer);

alter table venta_detalle add constraint fk_CodVenta foreign key(CodVenta) references Venta(CodVenta);
alter table venta_detalle add constraint fk_CodProductovd foreign key(CodProducto) references producto(CodProducto);   
/* CREACIÓN DE LLAVES FORANEAS */    


/* CREACIÓN DE SP */

/* CREACIÓN DE SP */

/* CREACIÓN DE VISTAS */

/* CREACIÓN DE VISTAS */


/* INSERTAR DATOS */

/* INSERTAR DATOS */