Create table Perfil(
perfil_id int identity(1,1) PRIMARY KEY ,
usuario varchar(30) NOT NULL UNIQUE,
nombre varchar(30) NOT NULL,
apellido varchar(30) NOT NULL,
rut varchar(12) NOT NULL,
contrasena varchar(255) NOT NULL,
activo bit NOT NULL,
direccion varchar(100),
correo varchar(100) NOT NULL UNIQUE,
telefono varchar(15) NOT NULL 
)



create table rol(
rol_id int identity(1,1) primary key,
nombre_rol varchar(25)
)
create table rol_perfil(
rol_id int ,
perfil_id int,
PRIMARY KEY(rol_id, perfil_id),
constraint FK_rol_perfil_rol FOREIGN KEY (rol_id) REFERENCES rol(rol_id),
constraint FK_rol_perfil_perfil FOREIGN KEY (perfil_id) REFERENCES perfil(perfil_id)
)

create table accion(
accion_id int identity(1,1) primary key,
accion_name varchar(25)
)
create table rol_accion(
rol_id int,
accion_id int,
PRIMARY KEY(rol_id, accion_id),
constraint fk_rol_accion_rol FOREIGN KEY (rol_id) references rol(rol_id),
constraint fk_rol_accion_accion FOREIGN KEY (accion_id) references accion(accion_id)
)

create table producto (
producto_id int identity(1,1) primary key,
nombre_producto varchar(150) NOT NULL,
descripcion_producto varchar(255) NOT NULL,
precio_producto decimal(10,2) not null,
sku varchar(50) unique not null,
imagen_url varchar(max)
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

create table orden_compra(
orden_compra_id int identity(1,1) primary key ,
perfil_id int,
direccion varchar(100) NOT NULL,
fecha_orden DATETIME2 default SYSDATETIME(),
constraint fk_orden_compra_perfil FOREIGN KEY (perfil_id) references perfil (perfil_id)
)
create table detalle_compra(
detalle_compra_id int identity(1,1) primary key,
producto_id int,
cantidad int,
costo decimal(10,2) not null,
orden_compra_id int,
constraint fk_detalle_compra_orden_compra FOREIGN KEY (orden_compra_id) references orden_compra (orden_compra_id),
constraint fk_detalle_compra_producto foreign key (producto_id) references producto (producto_id)
)

create table carro (
carro_id int identity(1,1) primary key,
perfil_id int,
fecha_creacion datetime2 default sysdatetime(),
estado varchar(25) default 'ABIERTO',
token varchar(100),
constraint fk_carro_perfil foreign key (perfil_id) references Perfil(perfil_id)

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
unique(ubicacion, producto_id)
constraint fk_inventario_producto foreign key (producto_id) references producto(producto_id)



)