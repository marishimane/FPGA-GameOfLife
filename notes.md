# Notas

### Motivación
- PDES (Parallel Discrete Event Simulation)
- Reglas del GOL
	- Simulación de 3 pasos

### Pasos
- Memoria distribuida

- La célula
	- Tests
- El board
	- Tests
- El juego, con la lógica de escritura y con el conteo de la cantidad de iteraciones a simular.
	- Tests

### Retos
- Hacerlo parametrizable en cuanto a la cantidad de elementos.
- Setear los valores iniciales de todo el board, y leerlos al terminar
	- Hablar de cómo lo solucionamos
- ¿Usar multiplexor para configurar la lógica de escritura inicial, o hacer el loop que hicimos? Lo mismo con la lectura.
- Conectar vecinos de manera parametrizable
	- Casos de borde: esquinas, aristas, y el resto.
- Testearlo con inputs grandes con la escritura y la lectura por loops.


### Mejoras
- Optimizar la escritura y la lectura, haciéndolo por batches en vez de célula por célula.
- Pasarle los datos desde un stream de datos
- Parametrizar la lógica de las células, con LUTs por ejemplo. Estamos limitados con nuestra implementación a solo los 8 vecinos de alrededor.
	- La lógica está contenida dentro de cada célula, con lo cual se podría modificar fácilmente.
- Poder resetear la simulación.

### Extra
