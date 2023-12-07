describe zonas;

insert into zonas(id_zona,nombre_zona)
VALUES
(1,'Norte'),
(2,'Sur'),
(3,'Oriente'),
(4,'Occidente'),
(5,'Floridablanca'),
(6,'Girón'),
(7,'Piedecuesta');

describe buses;

INSERT INTO buses(id_bus,placa)
VALUES
(1,'XVH345'),
(2,'XDL965'),
(3,'XFG847'),
(4,'XRJ452'),
(5,'XDF459'),
(6,'XET554'),
(7,'XKL688'),
(8,'XXL757')
;

describe dias;

INSERT INTO dias(id_dia,nombre_dia)
VALUES
(1,'Lunes'),
(2,'Martes'),
(3,'Miércoles'),
(4,'Jueves'),
(5,'Viernes'),
(6,'Sábado'),
(7,'Domingo');


describe estaciones;

select * from estaciones;

INSERT INTO estaciones(id_estacion,nombre_estacion)
VALUES
(1,'Colseguros'),
(2,'Clínica Chicamocha'),
(3,'Plaza Guarín'),
(4,'Mega Mall'),
(5,'UIS'),
(6,'UDI'),
(7,'Santo Tomás'),
(8,'Boulevard Santander'),
(9,'Búcaros'),
(10,'Rosita'),
(11,'Puerta del Sol'),
(12,'Cacique'),
(13,'Plaza Satélite'),
(14,'La Sirena'),
(15,'Provenza '),
(16,'Fontana'),
(17,'Gibraltar '),
(18,'Terminal'),
(19,'Mutis'),
(20,'Plaza Real');

describe conductores;

INSERT INTO conductores(id_conductor,nombre_conductor)
VALUES
(1,'Andrés Manuel López Obrador'),
(2,'Nicolás Maduro Moros'),
(3,'Alberto Fernández'),
(4,'Luiz Inácio Lula da Silva'),
(5,'Gabriel Boric'),
(6,'Miguel Díaz-Canel'),
(7,'Daniel Ortega'),
(8,'Gustavo Petro Urrego'),
(9,'Luis Arce'),
(10,'Xiomara Castro');

describe rutas;

--quitar el not null
ALTER TABLE rutas MODIFY id_zona INT;

INSERT INTO rutas(id_ruta,nombre_ruta,tiempo_ruta,id_zona)
VALUES
(1,"Universidades",'2:00',1), 
(2,"Café Madrid",'2:15',1), 
(4,"Diamantes",'1:50',4), 
(5,"Terminal",'2:00',4), 
(10,"Niza",'2:45',5), 
(11,"Autopista",'2:15',5), 
(12,"Lagos",'2:15',5);

INSERT INTO rutas(id_ruta,nombre_ruta,tiempo_ruta)
VALUES
(3,"Cacique",'1:45'), 
(6,"Prado",'1:30'), 
(7,"Cabecera",'2:00'), 
(8,"Ciudadela",'2:00'), 
(9,"Punta Estrella",'2:30'),
(13,"Centro Florida",'2:30');


describe conductores_rutas;

INSERT INTO conductores_rutas(id_conductor,id_ruta)
VALUES
(5,1),
(5,2),
(3,4),
(3,5),
(10,10),
(10,11),
(7,11),
(6,12);

describe conductores_buses;

INSERT INTO conductores_buses(id_conductor,id_bus)
VALUES
(5,1),
(5,3),
(5,5),
(3,5),
(3,6),
(3,1),
(3,3),
(10,3),
(10,5),
(10,4),
(10,7),
(7,7),
(6,7),
(6,7),
(6,6);

describe rutas_dias;
INSERT INTO rutas_dias(id_ruta,id_dia)
VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(2,5),
(2,6),
(2,7),
(4,1),
(4,2),
(4,3),
(5,4),
(5,5),
(5,6),
(5,7),
(10,1),
(10,2),
(10,3),
(10,4),
(10,5),
(11,6),
(11,7),
(11,1),
(11,2),
(12,3),
(12,4),
(12,5),
(12,6),
(12,7);


DESCRIBE rutas_estaciones;

INSERT INTO rutas_estaciones(id_ruta,id_estacion)
VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(3,8),
(3,9),
(3,10),
(3,11),
(3,12),
(4,13),
(4,14),
(4,15),
(5,16),
(5,17),
(8,18),
(8,19),
(8,20);

show tables;

--1 Cantidad de Paradas por Ruta

SELECT DISTINCT
r.nombre_ruta,COUNT(re.id_estacion)
from rutas_estaciones re
inner join rutas r on r.id_ruta=re.id_ruta
GROUP BY(r.nombre_ruta);

--2.Nombre de las Paradas de la Ruta Universidades

SELECT DISTINCT
estaciones.nombre_estacion
from rutas_estaciones
inner join rutas on rutas.id_ruta=rutas_estaciones.id_ruta
INNER join estaciones on estaciones.id_estacion=rutas_estaciones.id_estacion
WHERE rutas.nombre_ruta='Universidades';

--3.Nombres de las Rutas No Programadas

SELECT DISTINCT
r.nombre_ruta as 'rutas no programadas'
from rutas r
WHERE r.id_zona is NULL;


--4.Rutas Programadas sin Conductor Asignado
SELECT DISTINCT
r.nombre_ruta as 'rutas sin conductor'
from conductores_rutas cr
join rutas r on r.id_ruta=cr.id_ruta
join conductores c on c.id_conductor=cr.id_conductor
WHERE r.id_zona is null;


--5 Conductores No Asignados a la Programación
SELECT DISTINCT
c.nombre_conductor as 'nombres conductores no programados'
from conductores_rutas cr
RIGHT join rutas r on r.id_ruta=cr.id_ruta
RIGHT join conductores c on c.id_conductor=cr.id_conductor
WHERE r.id_zona is NULL;

--6 Buses No asignados a la Programación

SELECT * FROM conductores;

SELECT DISTINCT
b.placa as 'bus no programado'
from conductores_buses cb
RIGHT join buses b on b.id_bus=cb.id_bus
LEFT join conductores c on c.id_conductor=cb.id_conductor
LEFT join conductores_rutas cr on c.id_conductor=cr.id_conductor
LEFT join rutas r on r.id_ruta=cr.id_ruta
WHERE r.id_zona is NULL;

--7 Zonas NO Programadas
SELECT DISTINCT
z.nombre_zona
from zonas z
left join rutas r on z.id_zona=r.id_zona
WHERE r.id_zona is NULL;

--8 Programación asignada a cada conductor (Conductor, Ruta y Día).
SELECT DISTINCT
c.nombre_conductor as conductor,
r.nombre_ruta as ruta,
d.nombre_dia as dia
from conductores_rutas cr
join conductores c on c.id_conductor=cr.id_conductor
JOIN rutas r ON r.id_ruta=cr.id_ruta
JOIN rutas_dias rd ON r.id_ruta=rd.id_ruta
join dias d on d.id_dia=rd.id_dia ;

--9 Programación asignada a conductores que hacen rutas de más de dos horas
SELECT DISTINCT
c.nombre_conductor as nombre
from conductores_rutas cr
join rutas r on r.id_ruta=cr.id_ruta
join conductores c on c.id_conductor=cr.id_conductor
WHERE r.tiempo_ruta > '2:00';

--10 Nombres de Zonas y cantidad de rutas que tienen programadas (Contar)
SELECT DISTINCT
z.nombre_zona as 'nombre zona',
COUNT(r.id_ruta)
from zonas z
join rutas r on z.id_zona=r.id_zona
GROUP BY (z.nombre_zona);

