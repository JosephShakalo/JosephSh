# Evidencia Métodos Computacionales

Joseph Shakalo

A01784107

24/05/2024

### Reporte de Reflexión y Complejidad Algorítmica de Actividad Integradora Resaltador de sintaxis

#### Solución Planteada
La solución implementada consiste en un módulo de Elixir que convierte un archivo de Python a un archivo HTML con tokens resaltados mediante CSS. La conversión incluye la tokenización de líneas de código Python, clasificación de los tokens y generación de un archivo HTML estructurado.

#### Algoritmos Implementados
1. **Tokenización**: 
   - Se divide cada línea del archivo de Python en tokens usando una expresión regular.
   - Esta operación se realiza utilizando `String.split` con el modificador `include_captures`.

2. **Clasificación**:
   - Cada token es clasificado en una de varias categorías.
   - La clasificación se realiza utilizando una combinación de `cond` y funciones de coincidencia de expresiones regulares (`Regex.match?`).

3. **Conversión a HTML**:
   - Cada token clasificado se convierte en una etiqueta HTML `<span>` con una clase correspondiente para el estilo.
   - Los tokens se unen en una cadena HTML que es finalmente escrita en un archivo de salida en el cual es vinculada con el archivo de css `styles.css` para darle estilo y colores.

#### Complejidad Algorítmica
El análisis de complejidad se basa en el número de iteraciones y operaciones realizadas:

1. **Lectura del Archivo**: 
   - `File.stream!` abre el archivo y lo lee línea por línea.
   - La complejidad de esta operación es O(n), donde n es el número de líneas en el archivo.

2. **Tokenización y Clasificación**:
   - Cada línea es tokenizada usando `String.split`, que tiene una complejidad de O(m) por línea, donde m es el número de caracteres en la línea.
   - La clasificación de cada token dentro de la línea implica evaluar varias condiciones, lo que puede considerarse O(1) para cada token.
   - La complejidad combinada para tokenización y clasificación es O(n * m), donde n es el número de líneas y m es el número promedio de caracteres por línea.

3. **Conversión y Escritura de HTML**:
   - La conversión de tokens a HTML y la concatenación de líneas tienen una complejidad de O(n).
   - Escribir el archivo de salida es también O(n).

En conjunto, la complejidad general del algoritmo es aproximadamente O(n * m), dominada por la tokenización y clasificación de cada línea de entrada.

#### Tiempo de Ejecución Estimado
En la práctica, el tiempo de ejecución dependerá del tamaño del archivo de entrada y la velocidad del sistema de archivos. Para archivos de código fuente típicos, el tiempo de ejecución será rápido y manejable. Para archivos extremadamente grandes, la eficiencia de la tokenización y clasificación se vuelve más relevante.

#### Reflexión sobre Implicaciones Éticas
El uso de tecnologías para analizar y procesar código, como el resaltado de sintaxis y la tokenización, tiene varios impactos:

1. **Educación y Accesibilidad**:
   - Mejora la experiencia de aprendizaje al proporcionar herramientas más efectivas.
   - Facilita la comprensión del código para principiantes.

2. **Automatización y Productividad**:
   - Aumenta la productividad de los desarrolladores al automatizar tareas repetitivas.
   - Facilita la revisión y análisis del código, mejorando la calidad del software.

3. **Privacidad y Seguridad**:
   - El análisis de código puede ayudar a detectar problemas de seguridad, mejorando el software.
   - Pero también se podría usar para revisar código sin permiso, creando problemas de privacidad y derechos de autor.

4. **Impacto en el Empleo**:
   - La automatización del análisis de código puede reducir la necesidad de algunas tareas manuales, afectando potencialmente empleos relacionados con la revisión y el análisis de código.