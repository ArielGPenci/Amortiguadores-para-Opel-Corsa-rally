# Amortiguadores para Opel Corsa rally
## Análisis de datos obtenidos por medio de sensores, para conocer el estado de los cuatro amortiguadores de un vehículo de competición.


### Sobre el análisis
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
    
**Si es positivo, está en la fase de compresión, si es negativo de rebote.*

A modo de convención, se asume que los lados derecho e izquierdo son los siguientes:

<p align="right">    
<img width="1536" height="1024" alt="Vista superior del auto de rally" src="https://github.com/user-attachments/assets/a00f1a98-f436-4f0d-a11e-1f8000214f09" />

El análisis, hecho totalmente en R (Rstudio), consta de cuatro momentos:
1) Lectura del dataset.
2) Exploración de datos.
3) Análisis de tres puntos:
A) Velocidades de compresión y rebote de cada amortiguador.
B) Visualización de valores maximos y mínimos tanto de compresión como de rebote.
C) Transferencia de cargas: balanceo longitudinal y balancelo lateral.
D) Conclusiones.

------------------------------------------------------------------------------------------------------------------------------------------

### 1) LECTURA DEL DATASET
   
El mismo combina valores numéricos y de texto. Los datos fueron examinados previamente, para asegurar su integridad. No se encontron datos faltantes ni erróneos. Los datos se obtuvieron por medio de sensores especiales conectados en cada rueda:

 <p align="center">
      <img width="1024" height="1536" alt="Sensor de viaje de suspensión en detalle" src="https://github.com/user-attachments/assets/3ae5fb50-2cc8-43fb-9eed-ea9e75fc81ed" />
<p align="center">
    <img width="1024" height="1365" alt="Detalle del Opel Corsa rally" src="https://github.com/user-attachments/assets/7ce246ab-9884-4d23-ba34-5ef7547cf99f" />

-----------------------------------------------------------------------------------------------------------------------------

### 2) EXPLORACIÓN DE DATOS
   
Para tener una primera aproxomación a los datos, se ejecutaron algunos comandos de R:

. glimpse

. str

. summary (info estadística del dataset)

. is.na

------------------------------------------------------------------------------------------

### 3) ANÁLISIS

**A) Velocidades de compresión y rebote de cada amortiguador**

Aunque la suspensión se mueve apenas unos milímetros, lo hace con mucha energía y rapidez. Se mide en metros por segundo (m/s). Los siguentes histogramas muestran el desempeño de los cuatro amortiguadores del vehículo, en la fase de compresión (velocidad positiva, ya que el amortiguador "sube"):

<p align="center">
<img width="723" height="439" alt="image" src="https://github.com/user-attachments/assets/664788f1-4344-48f4-9cea-62fccd7b135e" />
<p align="center">
<img width="723" height="439" alt="image" src="https://github.com/user-attachments/assets/81838ccf-1724-4d35-9445-34f79c696b35" />
<p align="center">
<img width="723" height="439" alt="image" src="https://github.com/user-attachments/assets/735e2799-d65f-4b45-9c52-24bcdf17a229" />
<p align="center">
<img width="723" height="439" alt="image" src="https://github.com/user-attachments/assets/a5b39d86-f622-4023-a953-ac248760d9b0" />


A continuación, las velocidades de rebote (velocidad negativa, el amortiguador "baja):

<p align="center">
<img width="723" height="439" alt="image" src="https://github.com/user-attachments/assets/bb45e255-64c7-4b39-9632-37975f53d23f" />
<p align="center">
<img width="723" height="439" alt="image" src="https://github.com/user-attachments/assets/c9417693-66d7-47d2-9183-6f3986136670" />
<p align="center">
<img width="723" height="439" alt="image" src="https://github.com/user-attachments/assets/2a89d265-d883-4079-a8cd-afad4da725fc" />
<p align="center">
<img width="723" height="439" alt="image" src="https://github.com/user-attachments/assets/988028eb-1bb5-410a-9207-c2ef5fdba815" />

Los cuatro amortiguadores tienen una velocidad de compresión y rebote relativamente bajsa. Esto quiere decir que los vástagos de los amortiguadores se mueven poco, por lo que los cuatro muelles de suspensión están bastante rígidos.

-------------------------------------------------------------------------------------------------------------------------------------

**B) Visualización de valores maximos y mínimos de compresión. Rebote.**

Los vástagos de los 4 amortiguadores poseen un recorrido de 200 milímetros. Así, se considera una comoresión como máxima cuando el valor oscila entre los 115 y 200 mm. Al margen de saber cuantas veces llega a valores máximos de compresión, es interesante saber qué porcentaje del tiempo los amortiguadores estuvieron "sufriendo" en compresiones elevadas. La siguiente tabla muestra la proporción del tiempo en que los amortiguadores llegan (o casi) al máximo:

<p align="center">
<img width="498" height="298" alt="image" src="https://github.com/user-attachments/assets/1b787056-b5a5-4d47-8945-168c589496e3" />


Los amortiguadores del eje trasero comprimieron casi al máximo durante un 44% del tiempo que duró el muestreo, lo que indica que el eje trasero es mas blando que el delantero.
Por otro lado, se considera valores maximos de de rebote los comprendidos entre 10 mm y 0 mm. En este muestreo, los amortiguadores traseros no llegaron a ese rango de valores.

----------------------------------------

**C) Transferencia de cargas: alancelo lateral y balanceo longitudinal.**

El balanceo lateral ocurre principalmente en las curvas. La fuerza centrífuga hace que el peso se desplace hacia las ruedas exteriores. Es decir, qué tanto se "acuesta" el chasis sobre las suspensiones exteriores al doblar.
A continuación se muestran los valores máximos para los amortiguadores drechos e izquierdos:

<p align="center">
<img width="498" height="133" alt="image" src="https://github.com/user-attachments/assets/4cf2707f-aa84-4463-a021-4ea8f210eb54" />

La diferencia es de 1,3 mm, lo que indica que no existe un balanceo mayor de un lado que del otro (amortiguadores en buen estado y/o bien regulados).

Por otro lado, el balanceo longitudinal sucede al acelerar o al frenar. En aceleración, el eje delantero tiende a subir y el trasero a bajar. En frenadas, al revés.
En la siguente tabla se muestran las pociciones máximas de los amortiguadores del eje delantero y trasero:

<p align="center">
<img width="318" height="135" alt="image" src="https://github.com/user-attachments/assets/ceb40c04-e1fb-4d59-8530-2ab1a519d144" />

En este caso, la diferencia es de 8mm: el eje delantero tiende a mantenerse mas bajo que el trasero. Esto quiere decir que al frenar, el eje delantero demandará mas potencia de frenado. Pero como el centtro de gravedad está volcado hacia adelante las ruedas motrices del tendrán  mejor contacto con el suelo al arrancar o salir de curvas lentas (reduciendo el patinamiento).

--------------------------------------------------

**D) Conclusiones.**

A partir del análisis realizado, se desprenden las siguientes observaciones:

1) Balanceo longitudinal positivo: Existe una diferencia constante de 8 mm (eje delantero más bajo). Esto define un setup de "ataque". En un auto de tracción delantera como el Corsa, esto favorece la entrada en curvas cerradas al cargar más peso estático en el tren direccional. Sin embargo, los datos sugieren que esto deja al eje delantero con menos recorrido de compresión disponible para absorber impactos.

2) Balanceo lateral: La diferencia de apenas 1 mm entre el lado izquierdo y derecho indica un balanceo estático excelente. El peso del vehículo está correctamente balanceado, lo que garantiza que el auto reaccione de forma predecible tanto en curvas a la izquierda como a la derecha.

3) Capacidad de absorción de los amoritiguadores - valores de tope:
El hecho de que los amortiguadores traseros pasen un 44% del tiempo en valores cercanos a la compresión máxima (comparado con el ~33% de los delanteros) indica que el eje trasero está sufriendo el impacto de las irregularidades de manera mucho más directa.
Pasar casi la mitad del tiempo en el límite de compresión sugiere que los resortes traseros podrían ser demasiado blandos o que la altura trasera no es suficiente para la magnitud de los saltos del tramo analizado.

4) Eficiencia hidráulica de los amortiguadores (velocidades de los vástagos): 
El auto tiene un control de carrocería estable, ya que destacan las velocidad bajas de los vástagos durante el tramo de prueba.
Los histogramas amarillos (delanteros) muestran colas más largas que los grises (traseros), significa que el eje delantero está gestionando impactos mucho más violentos, probablemente por ser el primero en recibir el contacto tras un salto.

5) Recomendaciones: Ajuste de muelles de suspensón traseros. Evaluar el incremento de la constante elástica (K) en el eje trasero para reducir ese 44% de tiempo en compresión máxima, protegiendo la integridad del chasis.










       
