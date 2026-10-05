# Calculadora de Venta a Plazos - Prompt IA

## Contexto

Estoy desarrollando el Laboratorio 06 del curso Programación en Móviles Avanzado. La aplicación corresponde a una calculadora de venta a plazos de un electrodoméstico y utiliza UIKit con dos pantallas conectadas mediante un UINavigationController.

Los resultados deben almacenarse en una instancia de `VentaModel` y enviarse desde `NuevaVentaViewController` hacia `ResultadoViewController` mediante `prepare(for:sender:)` utilizando el segue `showResultado`.

## Tarea

Debo implementar una aplicación que permita ingresar el nombre del electrodoméstico, precio unitario, cantidad, número de meses e interés mensual.

Debo calcular el subtotal, IGV, monto base, intereses totales, total a pagar y cuota mensual. Luego, debo enviar los resultados mediante una instancia de `VentaModel` hacia la pantalla `ResultadoViewController`.

## Restricciones

- Utilizar solamente conceptos estudiados hasta la Semana 6: clases, `UIViewController`, `UINavigationController`, `IBOutlet`, `IBAction` y `prepare(for:sender:)`.
- Utilizar `VentaModel` como clase heredada de `NSObject`.
- No utilizar SwiftUI, Combine, Codable, persistencia, arquitecturas avanzadas ni librerías externas.

## Formato

La solución debe estar separada en tres archivos Swift:

1. `VentaModel.swift`, con las seis propiedades calculadas.
2. `NuevaVentaViewController.swift`, con los campos de entrada, las fórmulas y el envío del modelo.
3. `ResultadoViewController.swift`, con las etiquetas que muestran los resultados usando el formato `S/. %.2f`.

La aplicación debe considerar las siguientes fórmulas:

- `subtotal = precioUnitario * cantidad`
- `igv = subtotal * 0.18`
- `base = subtotal + igv`
- `intereses = base * (interesMensual / 100) * meses`
- `total = base + intereses`
- `cuota = total / meses`

## Ejemplo

Si el precio unitario es `1000`, la cantidad es `2`, el plazo es `10` meses y el interés mensual es `1%`, la aplicación debe calcular:

- Subtotal: `S/. 2000.00`
- IGV: `S/. 360.00`
- Base: `S/. 2360.00`
- Intereses: `S/. 236.00`
- Total: `S/. 2596.00`
- Cuota mensual: `S/. 259.60`

## Reflexión

La IA me ayudó a organizar el modelo, implementar las fórmulas y preparar el paso de datos entre las dos pantallas mediante `prepare(for:sender:)`.

También me permitió estructurar el código de manera más rápida, pero mantuve una solución sencilla y limitada a los conceptos vistos hasta la Semana 6. Por ejemplo, utilicé conversiones directas a `Double`, una validación básica para evitar dividir entre cero y un único modelo para transportar los resultados hacia la pantalla de resultado.
