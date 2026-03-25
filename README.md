# Amortiguadores para Opel Corsa rally
Análisis de datos obtenidos por medio de sensores, para conocer el estado de los cuatro amortiguadores de un vehículo de competición.

Sobre el análisis
El vehículo en cuestión es un Opel Corsa super 1600, del año 2005. El dataset se obtuvo luego de que los sensores en el auto registraran un tramo corto, de ripio con leves saltos y lomas.
El dataset es un archivo .xlsx que consta de 10.000 registros y 10 variables. Estas son:
1) Duración de la medición (timestamp_ms)
2) Posición del vástago del amortiguador delantero izquierdo (pos_amo_del_izq)
3) Posición del vástago del amortiguador delantero derecho (pos_amo_del_der)
4) Posición del vástago del amortiguador trasero izquierdo (pos_amo_tras_izq)
5) Posición del vástago del amortiguador trasero derecho (pos_amo_tras_der)
6) Velocidad del vástago del amortiguador delantero izquierdo (vel_amo_del_izq)
7) Velocidad del vástago del amortiguador delantero derecho(vel_amo_del_der)
8) Velocidad del vástago del amortiguador trasero izquierdo (vel_amo_tras_izq)
9) Velocidad del vástago del amortiguador trasero derecho(vel_amo_tras_der)
10) Momento del amortiguador (accion_amortiguador)*
    
*Si es positivo, está en la fase de compresión, si es negativo de rebote.

A modo de convención, se asume que los lados derecho e izquierdo son los siguientes:

    
<img width="1536" height="1024" alt="Vista superior del auto de rally" src="https://github.com/user-attachments/assets/a00f1a98-f436-4f0d-a11e-1f8000214f09" />

El análisis, hecho totalmente en R (Rstudio), consta de cuatro momentos:
1) Lectura del dataset.
2) Exploración de datos.
3) Análisis de tres puntos:
A) Velocidades de compresión y rebote de cada amortiguador.
B) Visualización de valores maximos y mínimos tanto de compresión como de rebote.
C) Transferencia de cargas: balanceo longitudinal y balancelo lateral.

-------------------------------------------------------------------------------------------------------------------------------------------

1) LECTURA DEL DATASET
   
El mismo combina valores numéricos y de texto. Los datos fueron examinados previamente, para asegurar su integridad. No se encontron datos faltantes ni erróneos. Los datos se obtuvieron por medio de sensores especiales conectados en cada rueda:

   <img width="1024" height="1536" alt="Sensor de viaje de suspensión en detalle" src="https://github.com/user-attachments/assets/3ae5fb50-2cc8-43fb-9eed-ea9e75fc81ed" />
   <img width="1024" height="1365" alt="Detalle del Opel Corsa rally" src="https://github.com/user-attachments/assets/7ce246ab-9884-4d23-ba34-5ef7547cf99f" />

3) EXPLORACIÓN DE DATOS
   
Para tener una primera aproxomación a los datos, se ejecutaron algunos comandos de R:

. glimpse

. str

. summary (info estadística del dataset)

. is.na

5) ANÁLISIS

       
