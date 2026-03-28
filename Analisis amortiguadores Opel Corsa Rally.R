# 1) CARGAR LIBRERÍAS

library(readxl)
library(tidyverse)
library(ggplot2)
library(esquisse)
library(gt)

#------------------------------------------------------------------------------#

# 2) LEER DATASET
Dataset_rally_corsa <- read_excel("C:/Users/Usuario/Desktop/Amortigudor rally proyecto analisis/Dataset_rally_corsa.xlsx",
                                  col_types = c("numeric", "numeric", "numeric",
                                                "numeric", "numeric", "numeric",
                                                "numeric", "numeric", "numeric",
                                                "numeric", "text", "text", "text"))
View(Dataset_rally_corsa)

#------------------------------------------------------------------------------#

# 3) EXPLORAR DATOS

as_tibble(Dataset_rally_corsa)
glimpse(Dataset_rally_corsa)
str(Dataset_rally_corsa)
summary(Dataset_rally_corsa)
sum(is.na(Dataset_rally_corsa))


#------------------------------------------------------------------------------#

# 4) ANÁLISIS


 # A) Histogramas de Velocidad


ggplot(Dataset_rally_corsa %>% filter(vel_amo_del_der < 0)) +
  aes(x = vel_amo_del_der) +
  geom_histogram(binwidth = 0.01, fill = "yellow", color = "black") +
  labs(
    title = "Rebote (velocidad negativa) - Amortiguador delantero derecho ",
    x = "Velocidad del vástago (m/s)",
    y = "Frecuencia",
    caption = "Gráfico 5"
  )

ggplot(Dataset_rally_corsa %>% filter(vel_amo_del_izq < 0)) +
  aes(x = vel_amo_del_izq) +
  geom_histogram(binwidth = 0.01, fill = "yellow", color = "black") +
  labs(
    title = "Rebote (velocidad negativa) - Amortiguador delantero izquierdo",
    x = "Velocidad del vástago (m/s)",
    y = "Frecuencia",
    caption = "Gráfico 6"
  )

ggplot(Dataset_rally_corsa %>% filter(vel_amo_tras_izq < 0)) +
  aes(x = vel_amo_tras_izq) +
  geom_histogram(binwidth = 0.01, fill = "grey", color = "black") +
  labs(
    title = "Rebote (velocidad negativa) - Amortiguador trasero izquierdo",
    x = "Velocidad del vástago (m/s)",
    y = "Frecuencia",
    caption = "Gráfico 7"
  )

ggplot(Dataset_rally_corsa %>% filter(vel_amo_tras_der < 0)) +
  aes(x = vel_amo_tras_der) +
  geom_histogram(binwidth = 0.01, fill = "grey", color = "black") +
  labs(
    title = "Rebote (velocidad negativa) - Amortiguador trasero derecho",
    x = "Velocidad del vástago (m/s)",
    y = "Frecuencia",
    caption = "Gráfico 8"
  )

###########################

ggplot(Dataset_rally_corsa %>% filter(vel_amo_del_der > 0)) +
  aes(x = vel_amo_del_der) +
  geom_histogram(binwidth = 0.01, fill = "yellow", color = "black") +
  labs(
    title = "Compresión (velocidad positiva) - Amortiguador delantero derecho ",
    x = "Velocidad del vástago (m/s)",
    y = "Frecuencia",
    caption = "Gráfico 1"
  )

ggplot(Dataset_rally_corsa %>% filter(vel_amo_del_izq > 0)) +
  aes(x = vel_amo_del_izq) +
  geom_histogram(binwidth = 0.01, fill = "yellow", color = "black") +
  labs(
    title = "Compresión (velocidad positiva) - Amortiguador delantero izquierdo",
    x = "Velocidad del vástago (m/s)",
    y = "Frecuencia",
    caption = "Gráfico 2"
  )

ggplot(Dataset_rally_corsa %>% filter(vel_amo_tras_izq > 0)) +
  aes(x = vel_amo_tras_izq) +
  geom_histogram(binwidth = 0.01, fill = "grey", color = "black") +
  labs(
    title = "Compresión (velocidad positiva) - Amortiguador trasero izquierdo",
    x = "Velocidad del vástago (m/s)",
    y = "Frecuencia",
    caption = "Gráfico 3"
  )

ggplot(Dataset_rally_corsa %>% filter(vel_amo_tras_der > 0)) +
  aes(x = vel_amo_tras_der) +
  geom_histogram(binwidth = 0.01, fill = "grey", color = "black") +
  labs(
    title = "Compresión (velocidad positiva) - Amortiguador trasero derecho",
    x = "Velocidad del vástago (m/s)",
    y = "Frecuencia",
    caption = "Gráfico 4"
  )

########### Velocidades de vástagos ########################################

crear_tabla <- function(data, variable, nombre) {
  data %>%
    mutate(
      rango = case_when(
        abs(.data[[variable]]) < 0.05 ~ "Baja",
        abs(.data[[variable]]) < 0.15 ~ "Media",
        TRUE ~ "Alta"
      ),
      amortiguador = nombre
    ) %>%
    count(amortiguador, rango) %>%
    mutate(porcentaje = n / sum(n) * 100)
}

tabla_unificada <- bind_rows(
  crear_tabla(Dataset_rally_corsa, "vel_amo_del_der", "Delantero Derecho"),
  crear_tabla(Dataset_rally_corsa, "vel_amo_del_izq", "Delantero Izquierdo"),
  crear_tabla(Dataset_rally_corsa, "vel_amo_tras_der", "Trasero Derecho"),
  crear_tabla(Dataset_rally_corsa, "vel_amo_tras_izq", "Trasero Izquierdo")
)

tabla_unificada %>%
  select(-n) %>%
  pivot_wider(
    names_from = rango,
    values_from = porcentaje
  ) %>%
  gt() %>%
  cols_label(
    amortiguador = "Amortiguador",
    Baja = "Baja (%)",
    Media = "Media (%)",
    Alta = "Alta (%)"
  ) %>%
  tab_style(
    style = list(
      cell_fill(color = "#FFD600"),
      cell_text(weight = "bold", color = "black")
    ),
    locations = cells_column_labels(everything())
  ) %>%
  cols_align("left", amortiguador) %>%
  cols_align("right", c(Baja, Media, Alta)) %>%
  fmt_number(
    columns = c(Baja, Media, Alta),
    decimals = 1
  ) %>%
  tab_options(
    table.align = "center",
    heading.align = "center",
    table.border.top.style = "none",
    table.border.bottom.style = "none",
    column_labels.border.bottom.color = "#FFD600",
    table_body.hlines.color = "#FFD600",
    table_body.vlines.color = "#FFD600"
  )

 # B) Bottoming (Topes de suspensión)

maximo_rebote_amo_del_der <- Dataset_rally_corsa %>% filter(pos_amo_del_der <= 10)
maximo_rebote_amo_del_izq <- Dataset_rally_corsa %>% filter(pos_amo_del_izq <= 10)
maximo_rebote_amo_tras_der <- Dataset_rally_corsa %>% filter(pos_amo_tras_izq <= 10)
maximo_rebote_amo_tras_izq <- Dataset_rally_corsa %>% filter(pos_amo_tras_izq <= 10)

maximo_compresion_amo_del_der <- Dataset_rally_corsa %>% filter(pos_amo_del_der >= 115)
maximo_compresion_del_izq <- Dataset_rally_corsa %>% filter(pos_amo_del_izq >= 115)
maximo_compresion_tras_der <- Dataset_rally_corsa %>% filter(pos_amo_tras_der >= 115)
maximo_compresion_tras_izq <- Dataset_rally_corsa %>% filter(pos_amo_tras_izq >= 115)

maximo_compresion_amo_del_der_porcentaje <- ((3280/10000) * 100)
maximo_compresion_amo_del_izq_porcentaje  <- ((3298/10000) * 100)
maximo_compresion_amo_tras_der_porcentaje  <- ((4443/10000) * 100)
maximo_compresion_amo_tras_izq_porcentaje  <- ((4424/10000) * 100)

maximo_rebote_amo_del_der_porcentaje <- ((3280/10000) * 100)
maximo_rebote_amo_del_izq_porcentaje  <- ((3298/10000) * 100)
maximo_rebote_amo_tras_der_porcentaje  <- ((4443/10000) * 100)
maximo_rebote_amo_tras_izq_porcentaje  <- ((4424/10000) * 100)

max_compresion_4_amos <- data.frame(
  eje = c("Delantero", "Delantero", "Trasero", "Trasero"),
  lado = c("Derecho", "Izquierdo", "Derecho", "Izquierdo"),
  porcentaje = c(32.8, 32.98, 44.43, 44.24)
)

gt(max_compresion_4_amos) %>%
  cols_label(eje = "Eje", lado = "Lado", porcentaje = "Proprción de tiempo en compresión máxima") %>%
  tab_options(
    table.align = "center",
    heading.align = "center",
    table.border.top.style = "none",
    table.border.bottom.style = "none",
    column_labels.border.bottom.color = "#FFD600",
    table_body.hlines.color = "#FFD600",
    table_body.vlines.color = "#FFD600"
) %>%
  tab_style(
    style = list(
      cell_fill(color = "#FFD600"),
      cell_text(weight = "bold", color = "black")
    ),
    locations = cells_column_labels(everything())
  )

 # C) Transferencia de cargas (Pitch & roll)

#Balanceo longitudinal - pitch

max_pos_amo_del_der <- (max(abs(Dataset_rally_corsa$pos_amo_del_der)))
max_pos_amo_tras_der <- (max(abs(Dataset_rally_corsa$pos_amo_tras_der)))
max_pos_amo_del_izq <- (max(abs(Dataset_rally_corsa$pos_amo_del_izq)))
max_pos_amo_tras_izq <- (max(abs(Dataset_rally_corsa$pos_amo_tras_izq)))

max_pos_del <- ((max_pos_amo_del_der + max_pos_amo_del_izq) / 2)
max_pos_tras <- ((max_pos_amo_tras_der + max_pos_amo_tras_izq) / 2)
cabeceo_longitudinal <- data.frame(max_pos_tras, max_pos_del)


gt(cabeceo_longitudinal) %>%
  cols_label(max_pos_tras = "Máxima posición del eje trasero", max_pos_del = "Máxima posición del eje delantero") %>%
  tab_options(
    table.align = "center",
    heading.align = "center",
    table.border.top.style = "none",
    table.border.bottom.style = "none",
    column_labels.border.bottom.color = "#FFD600",
    table_body.hlines.color = "#FFD600",
    table_body.vlines.color = "#FFD600"
  ) %>%
  tab_style(
    style = list(
      cell_fill(color = "#FFD600"),
      cell_text(weight = "bold", color = "black")
    ),
    locations = cells_column_labels(everything())
  )
# diferencia de 8 mm entre ejes. El delantero es menor que el trasero.


# Balanceo lateral

max_pos_der <- ((max_pos_amo_del_der + max_pos_amo_tras_der) / 2)
max_pos_izq<- ((max_pos_amo_del_izq + max_pos_amo_tras_izq) / 2)
balaceo_lateral <- data.frame(max_pos_izq, max_pos_der)

gt(balaceo_lateral) %>%
  cols_label(max_pos_der = "Máxima posición del lado derecho", max_pos_izq = "Máxima posición del eje izquierdo") %>%
  tab_options(
    table.align = "center",
    heading.align = "center",
    table.border.top.style = "none",
    table.border.bottom.style = "none",
    column_labels.border.bottom.color = "#FFD600",
    table_body.hlines.color = "#FFD600",
    table_body.vlines.color = "#FFD600"
  ) %>%
  tab_style(
    style = list(
      cell_fill(color = "#FFD600"),
      cell_text(weight = "bold", color = "black")
    ),
    locations = cells_column_labels(everything())
  )







