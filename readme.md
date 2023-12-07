<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio</title>
    <style>
        *
        {
            background: #756c6c;
            font-family: 'Courier New', Courier, monospace;
        }
        .box_consulta
        {
            background: #7c7c7c;
            border-radius: 50px;
            box-shadow:  20px 20px 46px #414141,
                        -20px -20px 46px #595959;
            width: 50%;
            margin: 0 auto;
            padding: 1%;
            border: black 2px solid;
            margin-bottom: 10vh;
        }
        .box_consulta > p
        {
            background: #7c7c7c;
        }
    </style>
</head>
<body>
    <img src="img/1.png" alt="">
    <h1>Consultas</h1>
    <p>1 Cantidad de Paradas por Ruta</p>
    <div class="box_consulta">
        <p>
            SELECT DISTINCT <br>
            r.nombre_ruta,COUNT(re.id_estacion)<br>
            from rutas_estaciones re<br>
            inner join rutas r on r.id_ruta=re.id_ruta<br>
            GROUP BY(r.nombre_ruta);<br>
        </p>
    </div>
    <p>2.Nombre de las Paradas de la Ruta Universidades</p>
    <div class="box_consulta">
        SELECT DISTINCT<br>
        estaciones.nombre_estacion<br>
        from rutas_estaciones<br>
        inner join rutas on rutas.id_ruta=rutas_estaciones.id_ruta<br>
        INNER join estaciones on estaciones.id_estacion=rutas_estaciones.id_estacion<br>
        WHERE rutas.nombre_ruta='Universidades';
    </div>
    <p>3.Nombres de las Rutas No Programadas</p>
    <div class="box_consulta">
        SELECT DISTINCT<br>
        r.nombre_ruta as 'rutas no programadas'<br>
        from rutas r<br>
        WHERE r.id_zona is NULL;
    </div>
    <p>4.Rutas Programadas sin Conductor Asignado</p>
    <div class="box_consulta">
        SELECT DISTINCT<br>
        r.nombre_ruta as 'rutas sin conductor'<br>
        from conductores_rutas cr<br>
        join rutas r on r.id_ruta=cr.id_ruta<br>
        join conductores c on c.id_conductor=cr.id_conductor<br>
        WHERE r.id_zona is null;
    </div>
    <p>5 Conductores No Asignados a la Programación</p>
    <div class="box_consulta">
        SELECT DISTINCT<br>
        c.nombre_conductor as 'nombres conductores no programados'<br>
        from conductores_rutas cr<br>
        RIGHT join rutas r on r.id_ruta=cr.id_ruta<br>
        RIGHT join conductores c on c.id_conductor=cr.id_conductor<br>
        WHERE r.id_zona is NULL;
    </div>
    <p>6 Buses No asignados a la Programación</p>
    <div class="box_consulta">
        SELECT DISTINCT<br>
        b.placa as 'bus no programado'<br>
        from conductores_buses cb<br>
        RIGHT join buses b on b.id_bus=cb.id_bus<br>
        LEFT join conductores c on c.id_conductor=cb.id_conductor<br>
        LEFT join conductores_rutas cr on c.id_conductor=cr.id_conductor<br>
        LEFT join rutas r on r.id_ruta=cr.id_ruta<br>
        WHERE r.id_zona is NULL;
    </div>
    <p>7 Zonas NO Programadas</p>
    <div class="box_consulta">
        SELECT DISTINCT<br>
        z.nombre_zona<br>
        from zonas z<br>
        left join rutas r on z.id_zona=r.id_zona<br>
        WHERE r.id_zona is NULL;<br>
    </div>
    <p>8 Programación asignada a cada conductor (Conductor, Ruta y Día).</p>
    <div class="box_consulta">
        SELECT DISTINCT<br>
        c.nombre_conductor as conductor,<br>
        r.nombre_ruta as ruta,<br>
        d.nombre_dia as dia<br>
        from conductores_rutas cr<br>
        join conductores c on c.id_conductor=cr.id_conductor<br>
        JOIN rutas r ON r.id_ruta=cr.id_ruta<br>
        JOIN rutas_dias rd ON r.id_ruta=rd.id_ruta<br>
        join dias d on d.id_dia=rd.id_dia ;
    </div>
    <p>9 Programación asignada a conductores que hacen rutas de más de dos horas</p>
    <div class="box_consulta">
        SELECT DISTINCT<br>
        c.nombre_conductor as nombre<br>
        from conductores_rutas cr<br>
        join rutas r on r.id_ruta=cr.id_ruta<br>
        join conductores c on c.id_conductor=cr.id_conductor<br>
        WHERE r.tiempo_ruta > '2:00';
    </div>
    <p>10 Nombres de Zonas y cantidad de rutas que tienen programadas (Contar)</p>
    <div class="box_consulta">
        SELECT DISTINCT<br>
        z.nombre_zona as 'nombre zona',<br>
        COUNT(r.id_ruta)<br>
        from zonas z<br>
        join rutas r on z.id_zona=r.id_zona<br>
        GROUP BY (z.nombre_zona);
    </div>
</body>
</html>