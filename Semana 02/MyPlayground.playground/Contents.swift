import Foundation

// definir el promedio por pesos
let parcial = 0.3
let trabajo = 0.3
let final = 0.4

print("Nombre del Alumno")
let alumno = readLine() ?? ""

print("Nota del Examen Parcial:")
let examenParcial = Double(readLine() ?? "") ?? 0
print("Nota del Trabajo:")
let notaTrabajo = Double(readLine() ?? "") ?? 0

print("Nota del Examen Final:")
let examenFinal = Double(readLine() ?? "") ?? 0

// calculo del promedio
let promedio = (examenParcial * parcial) +
               (notaTrabajo * trabajo) +
               (examenFinal * final)
