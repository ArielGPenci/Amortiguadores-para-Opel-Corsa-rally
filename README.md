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
