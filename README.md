# GameOfLife - FPGA

## Integrantes
> - Mariana Shimane
> - Francisco Roth
> - Luis José Martín

## Contenido
El repositorio contiene el código fuente de la implementación del **Game of life de Conway** en VHDL para una FPGA. El mismo contiene archivos correspondientes a los módulos utilizados, así como también los archivos de tests para cada módulo.

Los archivos `cell.vhd` y `board.vhd` contienen las entidades y arquitecturas de las células y el tablero respectivamente. El tablero representa un conjunto de células con una topología de grilla bidimensional. Cada célula tiene 8 vecinos de los cuales recibe en cada clock su estado, y en base a eso decide su próximo estado. El tablero se encarga de conectar las células entre sí.

> Notar que el módulo `board.vhd` es parametrizable en cuanto a la cantidad de células que contiene. Esto permite que el tablero pueda ser de cualquier tamaño pero siempre cuadrado de N x N células. La limitación en la cantidad de células dependerá de cuántas de estas quepan en la FPGA.

El archivo `game_of_life.vhd` contiene la entidad y arquitectura del juego. El mismo se encarga de inicializar el tablero con los valores iniciales, y de correr la simulación por la cantidad de iteraciones especificada. Al finalizar la simulación, el usuario del módulo puede realizar la lectura de los valores finales de cada célula.

La escritura y la lectura se hace en forma de loop, escribiendo de a una célula por vez. De esta forma, no hace falta tener una memoria distribuida para guardar los valores de las células, sino que se puede hacer con una memoria distribuida de 1 bit. Esto es posible porque la escritura y la lectura se hacen en forma secuencial, y no en forma paralela.

## Testing
El testing de todo el código se realizó utilizando la herramienta online [EDA playground](https://www.edaplayground.com/) ya que no pudimos instalar el software necesario para simular en nuestras computadoras. El código de los tests se encuentra en los archivos `cell_tb.vhd`, `board_tb.vhd` y `game_of_life_tb.vhd`.

El proceso de desarrollo fue bottom-up, es decir, primero se desarrolló la célula con sus tests, luego el tablero con sus tests, y por último el juego completo. Esto permitió ir probando cada módulo a medida que se iban desarrollando, y así poder detectar errores más fácilmente.

Para poder testear el output final del juego, se comparó con una implementación en Ruby del mismo. El código de la implementación en Ruby se encuentra en el archivo `game_of_life.rb`. El mismo tiene configurado el board inicial y la cantidad de iteraciones a simular. Al finalizar la simulación, se imprime el board final por pantalla.

> ### Nota
> En caso de querer correr el código de Ruby, es necesario tener instalado Ruby en la computadora. Luego basta con ejecutar el comando `ruby game_of_life.rb` en la terminal.


