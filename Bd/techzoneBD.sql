

create table rol(
rol_id int identity(1,1) primary key not null,
nombre_rol varchar(25) not null

)


Create table Perfil(
perfil_id int identity(1,1) PRIMARY KEY ,
usuario varchar(30) NOT NULL UNIQUE,
nombre varchar(30) NOT NULL,
apellido varchar(30) NOT NULL,
rut varchar(12) NOT NULL,
password_hash varchar(255) NOT NULL,
activo bit NOT NULL,
correo varchar(100) NOT NULL UNIQUE,
rol_id int,
telefono varchar(15) NOT NULL,
constraint perfil_rol foreign key (rol_id) references rol (rol_id)
)



create table direccion(
direccion_id int identity(1,1) primary key,
perfil_id int not null,
direccion varchar(100) not null,
comuna varchar(50),
es_principal bit,
alias varchar(40)
,
constraint direccion_perfil foreign key (perfil_id) references perfil(perfil_id)

)





create table accion(
accion_id int identity(1,1) primary key,
nombre_accion varchar(25)
)
create table rol_accion(
rol_id int,
accion_id int,
PRIMARY KEY(rol_id, accion_id),
constraint fk_rol_accion_rol FOREIGN KEY (rol_id) references rol(rol_id),
constraint fk_rol_accion_accion FOREIGN KEY (accion_id) references accion(accion_id)
)




create table estado (
estado_id int identity(1,1) primary key,
nombre varchar(15) not null,
descripcion varchar(40) not null
)

create table orden_compra(
orden_compra_id int identity(1,1) primary key ,
perfil_id int,
direccion varchar(100) NOT NULL,
estado_id int,
monto_total decimal(10,2),
fecha_orden DATETIME2 default SYSDATETIME(),
constraint fk_orden_compra_perfil FOREIGN KEY (perfil_id) references perfil (perfil_id),
constraint fk_orden_compra_estado foreign key (estado_id) references estado (estado_id)
)



create table carro (
carro_id int identity(1,1) primary key,
perfil_id int,
fecha_creacion datetime2 default sysdatetime(),
estado varchar(25) default 'ABIERTO',
token varchar(100),
constraint fk_carro_perfil foreign key (perfil_id) references Perfil(perfil_id)

)



create table metodo_pago(
metodo_pago_id int identity(1,1) primary key,
nombre varchar(30) not null,
descripcion varchar(50) not null



)
create table pago(
pago_id int identity(1,1) primary key,
orden_compra_id int,
metodo_pago_id int not null,
monto decimal(10,2),
estado varchar(30) DEFAULT 'PENDIENTE',
codigo_trans varchar(1000),

constraint fk_pago_metodo_pago foreign key(metodo_pago_id) references metodo_pago(metodo_pago_id),
constraint fk_pago_orden_compra foreign key(orden_compra_id) references orden_compra(orden_compra_id)
)



create table proveedor(
proveedor_id int identity(1,1) primary key,
nombre varchar(40) not null,
rut varchar(12) not null unique,
telefono varchar(12) not null,
nombre_contacto varchar(40),
direccion varchar(100),
email varchar(50) not null


)

create table marca (
marca_id int identity(1,1) PRIMARY KEY,
nombre_marca varchar(50) unique not null
)


create table producto (
producto_id int identity(1,1) primary key,
proveedor_id int,
nombre_producto varchar(150) NOT NULL,
descripcion_producto varchar(2000) NOT NULL,
garantia varchar(255) NOT NULL,
marca_id int,
precio_producto decimal(10,2) not null,
sku varchar(50) unique not null,
imagen_url varchar(500),
constraint producto_proveedor foreign key (proveedor_id) references proveedor (proveedor_id),
constraint producto_marca foreign key (marca_id) references marca (marca_id)

)





create table categoria(
categoria_id int identity(1,1) primary key,
nombre_categoria varchar(30)
)
create table producto_categoria(
producto_id int,
categoria_id int,
primary key(producto_id,categoria_id),
constraint fk_producto_categoria_producto FOREIGN KEY (producto_id) REFERENCES producto (producto_id),
constraint fk_producto_categoria_categoria FOREIGN KEY (categoria_id) REFERENCES categoria (categoria_id)
)

create table detalle_compra(
detalle_compra_id int identity(1,1) primary key,
producto_id int,
cantidad int,
precio_unitario decimal(10,2) not null,
orden_compra_id int,
constraint fk_detalle_compra_orden_compra FOREIGN KEY (orden_compra_id) references orden_compra (orden_compra_id),
constraint fk_detalle_compra_producto foreign key (producto_id) references producto (producto_id)
)


create table carro_detalle(
carro_detalle_id int identity(1,1) primary key,
carro_id int,
producto_id int,
cantidad int,
fecha_agregado datetime2 default SYSDATETIME(),
constraint fk_carro_detalle_carro foreign key (carro_id) references carro(carro_id),
constraint fk_carro_detalle_producto foreign key (producto_id) references producto(producto_id)



)



create table inventario(
inventario_id int identity(1,1) primary key,
ubicacion varchar(40) default 'BODEGA CENTRAL',
producto_id int not null,
cantidad int default 0 check (cantidad >= 0),
unique(ubicacion, producto_id),
constraint fk_inventario_producto foreign key (producto_id) references producto(producto_id)



)
