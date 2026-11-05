# Laboratorio 11 — Parte 2: SwiftData con SwiftUI

Abre `apple_lab11_02_SwiftUI_SwiftData.xcodeproj`, selecciona el esquema del mismo nombre y un simulador iPhone. Requiere iOS 17 o superior. No utiliza paquetes externos.

## Prueba manual

1. Pulsa +. Completa apellido, nombre y DNI y pulsa Guardar Alumno. Los campos vacíos o con espacios mantienen el botón desactivado.
2. Agrega García/Ana, Gómez/Juan y Pérez/Luis. La lista se ordena por apellido y se actualiza mediante @Query.
3. Selecciona un alumno. En el detalle pulsa Editar, modifica sus datos y pulsa Listo.
4. Busca GARCÍA. Debe aparecer García aunque cambien las mayúsculas. Borra ese alumno deslizando la fila. Limpia la búsqueda: los demás alumnos deben seguir presentes.
5. Pulsa el libro de la barra. Asigna Programación en Móviles a todos los alumnos, incluso si hay un filtro activo. Selecciona uno para ver su curso. Repetir el botón reutiliza el curso.
6. Detén y vuelve a ejecutar la app sin desinstalarla: los registros, las modificaciones, las eliminaciones y el curso deben conservarse.
7. La consola muestra `Base de datos SQLite en: .../AlumnosData.sqlite`. El libro imprime `Curso demo: Programación en Móviles — N alumno(s)`.

## Archivos

- Alumno.swift y Curso.swift: modelos y relación uno a muchos con Nullify.
- ModelContainerProvider.swift: contenedor compartido y SQLite persistente.
- apple_lab11_02_SwiftUI_SwiftDataApp.swift: punto de entrada y contenedor en el entorno.
- ContentView.swift: consulta, detalle, búsqueda, eliminación y curso de demostración.
- NuevoAlumnoView.swift: creación con validación básica.
- EditarAlumnoView.swift: modificación con @Bindable y guardado al pulsar Listo.

El curso se asigna únicamente al pulsar el botón del libro. No se insertan datos de ejemplo al iniciar. Los previews utilizan almacenamiento en memoria.

## Validación en esta sesión

- Xcode reconoce el proyecto, target y esquema compartido.
- project.pbxproj, workspace y esquema tienen estructura válida.
- Los siete archivos Swift pasan el análisis sintáctico del compilador.
- La compilación para iOS Simulator con SDK 26.2 se intentó, pero la sesión bloqueó el proceso de expansión de macros (`sandbox-exec: sandbox_apply: Operation not permitted`). No se obtuvo una compilación completa.
- CoreSimulator no estuvo accesible desde esta sesión; no se ejecutó la aplicación ni se verificó visualmente en iPhone 17 / iOS 26.3.
- Se preparó una prueba temporal de SwiftData fuera del proyecto, pero tampoco pudo compilar por la misma restricción. CRUD, búsqueda, relaciones y persistencia quedan pendientes de prueba en Xcode con el procedimiento anterior.
- No se modificaron las fuentes ni la configuración de la Parte 1. No se realizaron commits ni push.
