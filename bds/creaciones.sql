
CREATE TABLE `buses`(
    `id_bus` INT NOT NULL,
    `placa` VARCHAR(20) NOT NULL
);

CREATE TABLE `zonas`(
    `id_zona` INT NOT NULL,
    `nombre_zona` VARCHAR(30) NOT NULL
);

CREATE TABLE `dias`(
    `id_dia` INT NOT NULL,
    `nombre_dia` VARCHAR(20) NOT NULL
);

CREATE TABLE `estaciones`(
    `id_estacion` INT NOT NULL,
    `nombre_estacion` VARCHAR(80) NOT NULL
);


CREATE TABLE `conductores`(
    `id_conductor` INT NOT NULL,
    `nombre_conductor` VARCHAR(80) NOT NULL
);


CREATE TABLE `rutas`(
    `id_ruta` INT NOT NULL,
    `nombre_ruta` VARCHAR(30) NOT NULL,
    `tiempo_ruta` TIME NOT NULL,
    `id_zona` INT NOT NULL
);

CREATE TABLE `rutas_estaciones`(
    `id_ruta` INT NOT NULL,
    `id_estacion` INT NOT NULL
);
CREATE TABLE `conductores_rutas`(
    `id_conductor` INT NOT NULL,
    `id_ruta` INT NOT NULL
);

CREATE TABLE `conductores_buses`(
    `id_conductor` INT NOT NULL,
    `id_bus` INT NOT NULL
);

CREATE TABLE `rutas_dias`(
    `id_ruta` INT NOT NULL,
    `id_dia` INT NOT NULL
);

ALTER TABLE
    `buses` ADD PRIMARY KEY `buses_id_bus_primary`(`id_bus`);

ALTER TABLE
    `zonas` ADD PRIMARY KEY `zonas_id_zona_primary`(`id_zona`);

ALTER TABLE
    `dias` ADD PRIMARY KEY `dias_id_dia_primary`(`id_dia`);

ALTER TABLE
    `estaciones` ADD PRIMARY KEY `estaciones_id_estacion_primary`(`id_estacion`);

ALTER TABLE
    `conductores` ADD PRIMARY KEY `conductores_id_conductor_primary`(`id_conductor`);

ALTER TABLE
    `rutas` ADD PRIMARY KEY `rutas_id_ruta_primary`(`id_ruta`);


ALTER TABLE
    `rutas` ADD CONSTRAINT `rutas_id_zona_foreign` FOREIGN KEY(`id_zona`) REFERENCES `zonas`(`id_zona`);
ALTER TABLE
    `rutas_dias` ADD CONSTRAINT `rutas_dias_id_ruta_foreign` FOREIGN KEY(`id_ruta`) REFERENCES `rutas`(`id_ruta`);
ALTER TABLE
    `conductores_rutas` ADD CONSTRAINT `conductores_rutas_id_conductor_foreign` FOREIGN KEY(`id_conductor`) REFERENCES `conductores`(`id_conductor`);
ALTER TABLE
    `rutas_estaciones` ADD CONSTRAINT `estaciones_rutas_id_ruta_foreign` FOREIGN KEY(`id_ruta`) REFERENCES `rutas`(`id_ruta`);
ALTER TABLE
    `rutas_dias` ADD CONSTRAINT `rutas_dias_id_dia_foreign` FOREIGN KEY(`id_dia`) REFERENCES `dias`(`id_dia`);
ALTER TABLE
    `conductores_buses` ADD CONSTRAINT `conductores_buses_id_conductor_foreign` FOREIGN KEY(`id_conductor`) REFERENCES `conductores`(`id_conductor`);
ALTER TABLE
    `conductores_buses` ADD CONSTRAINT `conductores_buses_id_bus_foreign` FOREIGN KEY(`id_bus`) REFERENCES `buses`(`id_bus`);
ALTER TABLE
    `conductores_rutas` ADD CONSTRAINT `conductores_rutas_id_ruta_foreign` FOREIGN KEY(`id_ruta`) REFERENCES `rutas`(`id_ruta`);
ALTER TABLE
    `rutas_estaciones` ADD CONSTRAINT `estaciones_rutas_id_estacion_foreign` FOREIGN KEY(`id_estacion`) REFERENCES `estaciones`(`id_estacion`);