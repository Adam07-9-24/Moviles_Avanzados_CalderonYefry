# MetroLima - Sistema de consulta del Metro de Lima y Callao

## Descripción

MetroLima es un sistema desarrollado en Swift que se ejecuta mediante consola y permite consultar información de las líneas y estaciones del Metro de Lima y Callao.

Este es un proyecto académico. Para efectos del proyecto, se asume que las cuatro líneas registradas y todas sus estaciones se encuentran disponibles, aunque algunas correspondan actualmente a proyectos o se encuentren en construcción.

## Objetivo

El objetivo del proyecto es aplicar los conocimientos de Swift mediante el uso de colecciones y estructuras básicas para gestionar información sobre líneas, estaciones, conexiones y rutas.

## Funcionalidades

El sistema cuenta con las siguientes funcionalidades:

1. Ver líneas disponibles.
2. Ver estaciones de una línea.
3. Buscar una estación.
4. Ver estaciones cercanas.
5. Ver conexiones de una estación.
6. Cómo llegar de una estación a otra.
7. Filtrar estaciones por nombre.
8. Ver información general del Metro.
9. Salir del sistema.

El detalle completo de los requerimientos funcionales se encuentra en [REQUERIMIENTOS.md](REQUERIMIENTOS.md).

## Líneas registradas

- Línea 1: 26 estaciones.
- Línea 2: 27 estaciones.
- Línea 3: 28 estaciones.
- Línea 4: 28 estaciones.

Las estaciones se encuentran almacenadas utilizando colecciones de Swift.

## Colecciones utilizadas

- **Array:** almacena las estaciones de cada línea en el orden correspondiente.
- **Dictionary:** relaciona cada línea con sus estaciones y permite agrupar información durante las búsquedas.
- **Set:** evita visitar repetidamente una misma estación durante la búsqueda de rutas y permite trabajar con elementos únicos.

## Búsquedas

El sistema utiliza una función llamada `normalizar()` para facilitar las búsquedas. Esta función permite ignorar:

- Mayúsculas y minúsculas.
- Tildes.
- Espacios al inicio y al final.

Existen dos formas de consultar nombres:

- **Buscar una estación:** requiere ingresar el nombre completo.
- **Filtrar estaciones:** permite ingresar una palabra o una parte del nombre.

Ejemplo de búsqueda:

```text
Miguel Grau
```

Ejemplo de filtro:

```text
San
```

## Conexiones y rutas

Una estación se considera de conexión cuando aparece en más de una línea.

El sistema puede buscar una ruta desde una estación de origen hasta una estación de destino. Para ello, recorre las estaciones consecutivas de cada línea y utiliza las conexiones cuando es necesario cambiar de línea.

## Estructura del proyecto

```text
MetroLima/
├── main.swift
├── README.md
└── REQUERIMIENTOS.md
```

- **main.swift:** contiene los datos, las funciones y el menú del sistema.
- **README.md:** contiene la documentación general del proyecto.
- **REQUERIMIENTOS.md:** contiene los requerimientos funcionales.

## Ejecución

Para ejecutar el sistema es necesario tener Swift instalado. Desde una terminal, se debe ingresar al directorio `MetroLima` y ejecutar:

```bash
swift main.swift
```

Después aparecerá el menú principal:

```text
========================================
       METRO DE LIMA Y CALLAO
========================================

1. Ver líneas disponibles
2. Ver estaciones de una línea
3. Buscar una estación
4. Ver estaciones cercanas
5. Ver conexiones de una estación
6. Cómo llegar de una estación a otra
7. Filtrar estaciones por nombre
8. Ver información general del Metro
0. Salir

Seleccione una opción:
```

## Tecnologías

- Swift
- Programación en consola
