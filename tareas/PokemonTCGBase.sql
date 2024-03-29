-- Creación de tabla Carta
Use pokemonTCG;
SELECT * FROM Estadisticas;
CREATE TABLE Carta (
    id_carta INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion VARCHAR(1000),
    Vida TINYINT UNSIGNED,
    Daño TINYINT UNSIGNED,
    Energia TINYINT UNSIGNED,
    Tipo VARCHAR(50) NOT NULL,
    Evolucion VARCHAR(50),
    Simbolo_rareza VARCHAR(50),
    Debilidad VARCHAR(50)
);

-- Creación de tabla Jugador
CREATE TABLE Jugador (
    id_jugador INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion VARCHAR(1000),
    Nivel TINYINT UNSIGNED NOT NULL,
    Contraseña VARCHAR(255) NOT NULL,
    Estrategia VARCHAR(1000),
    Vestimenta VARCHAR(255)
);

-- Creación de tabla Mazo
CREATE TABLE Mazo (
    id_mazo INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_jugador INT UNSIGNED NOT NULL,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion VARCHAR(1000),
    Elemento VARCHAR(50),
    Tamaño TINYINT UNSIGNED NOT NULL,
    Numero_cartas TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (id_jugador) REFERENCES Jugador(id_jugador)
);

-- Creación de tabla Inventario
CREATE TABLE Inventario (
    id_composicion INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_Carta INT UNSIGNED NOT NULL,
    id_Jugador INT UNSIGNED NOT NULL,
    id_mazo INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_Carta) REFERENCES Carta(id_carta),
    FOREIGN KEY (id_Jugador) REFERENCES Jugador(id_jugador),
    FOREIGN KEY (id_mazo) REFERENCES Mazo(id_mazo)
);

-- Creación de tabla Efecto
CREATE TABLE Efecto (
    Effecto_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Duracion VARCHAR(50),
    Nombre VARCHAR(255) NOT NULL,
    Detalles VARCHAR(1000),
    Tipo VARCHAR(50) NOT NULL,
    Cantidad INT UNSIGNED
);

-- Creación de tabla Trigger
CREATE TABLE `Trigger` (
    Trigger_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Effect_id INT UNSIGNED NOT NULL,
    Card_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (Effect_id) REFERENCES Efecto(Effecto_id),
    FOREIGN KEY (Card_id) REFERENCES Carta(id_carta)
);

-- Creación de tabla Juego
CREATE TABLE Juego (
    Juego_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Turno INT UNSIGNED,
    Jugador1_id INT UNSIGNED NOT NULL,
    Jugador2_id INT UNSIGNED NOT NULL,
    Duracion SMALLINT UNSIGNED NOT NULL,
    Ganador INT UNSIGNED,
    FOREIGN KEY (Jugador1_id) REFERENCES Jugador(id_jugador),
    FOREIGN KEY (Jugador2_id) REFERENCES Jugador(id_jugador)
);

-- Creación de tabla Turno
CREATE TABLE Turno (
    Turno_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Jugador_id INT UNSIGNED NOT NULL,
    Juego_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (Jugador_id) REFERENCES Jugador(id_jugador),
    FOREIGN KEY (Juego_id) REFERENCES Juego(Juego_id)
);

-- Creación de tabla Banca
CREATE TABLE Banca (
    Banca_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Carta_id INT UNSIGNED NOT NULL,
    Jugador_id INT UNSIGNED NOT NULL,
    Numero_cartas TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (Carta_id) REFERENCES Carta(id_carta),
    FOREIGN KEY (Jugador_id) REFERENCES Jugador(id_jugador)
);

-- Creación de tabla Estadisticas
CREATE TABLE Estadisticas (
    Estadisticas_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Jugador_id INT UNSIGNED NOT NULL,
    Partidas_ganadas INT UNSIGNED NOT NULL,
    Partidas_jugadas INT UNSIGNED NOT NULL,
    Partidas_perdidas INT UNSIGNED NOT NULL,
    Puntos_torneo INT UNSIGNED NOT NULL,
    FOREIGN KEY (Jugador_id) REFERENCES Jugador(id_jugador)
);

-- Creación de Dummy Data

-- Creación de Dummy Data a tabla Carta
INSERT INTO Carta (Nombre, Descripcion, Vida, Daño, Energia, Tipo, Evolucion, Simbolo_rareza, Debilidad) VALUES
('Pikachu', 'Ratón eléctrico famoso por su cola en forma de rayo.', 40, 20, 10, 'Eléctrico', 'Raichu', 'Común', 'Tierra'),
('Charmander', 'Pequeño lagarto de fuego, siempre con una llama en la punta de su cola.', 50, 30, 20, 'Fuego', 'Charmeleon', 'Común', 'Agua'),
('Bulbasaur', 'Una rara semilla fue plantada en su espalda al nacer. La planta brota y crece con este Pokémon.', 60, 20, 10, 'Planta', 'Ivysaur', 'Común', 'Fuego'),
('Squirtle', 'Cuando retrae su largo cuello en su caparazón, dispara agua a alta velocidad.', 50, 20, 15, 'Agua', 'Wartortle', 'Común', 'Eléctrico'),
('Eevee', 'Debido a su inestable código genético, este Pokémon puede evolucionar en varias formas.', 55, 25, 15, 'Normal', 'Vaporeon/Jolteon/Flareon', 'Raro', 'Lucha'),
('Jolteon', 'Genera cargas eléctricas negativas en su pelaje. Provoca chispazos si se carga de electricidad estática.', 65, 40, 0, 'Eléctrico', NULL, 'Raro', 'Tierra'),
('Vaporeon', 'Su estructura celular es similar a la de las moléculas de agua. Puede fundirse en el agua.', 70, 30, 0, 'Agua', NULL, 'Raro', 'Planta'),
('Flareon', 'Tiene una llama saca por su esponjoso pelaje, que tiene un aroma dulce cuando se quema.', 65, 45, 0, 'Fuego', NULL, 'Raro', 'Agua'),
('Psyduck', 'Siempre sufre de dolores de cabeza. Cuando estos se intensifican, usa poderes psíquicos.', 50, 15, 20, 'Agua', 'Golduck', 'Común', 'Eléctrico'),
('Machop', 'Su músculo se fortalece cuando lo expone a todo tipo de golpes y golpizas.', 70, 35, 5, 'Lucha', 'Machoke', 'Común', 'Psíquico'),
('Gastly', 'Casi invisible, este gaseoso Pokémon se envuelve alrededor de su presa y la asfixia sin ser visto.', 30, 35, 5, 'Fantasma', 'Haunter', 'Común', 'Fantasma'),
('Haunter', 'Debido a su habilidad para deslizarse a través de bloques sólidos, ha sido confundido con una sombra.', 45, 50, 0, 'Fantasma', 'Gengar', 'Raro', 'Oscuridad'),
('Gengar', 'En la noche de luna llena, se dice que las sombras de aquellos que se llevaron a Gengar bailan en la luna.', 60, 65, 0, 'Fantasma', NULL, 'Muy Raro', 'Psíquico'),
('Cubone', 'Lleva el cráneo de su madre muerta como un casco. Su grito hace eco dentro del cráneo y sale como un triste lamento.', 50, 25, 10, 'Tierra', 'Marowak', 'Común', 'Agua'),
('Marowak', 'El hueso que sostiene es su arma clave. Es habilidoso en el manejo del hueso.', 60, 35, 5, 'Tierra', NULL, 'Raro', 'Planta');

-- Creación de Dummy Data a tabla Jugador
INSERT INTO Jugador (Nombre, Descripcion, Nivel, Contraseña, Estrategia, Vestimenta) VALUES
('Alex', 'Entusiasta de los juegos de cartas con una colección impresionante.', 10, 'alex1234', 'Balance entre ataque y defensa', 'Casual'),
('Sam', 'Jugador competitivo que ha ganado varios torneos locales.', 15, 'samPass', 'Agresivo desde el primer turno', 'Deportiva'),
('Jess', 'Ama los Pokémon de agua y siempre busca estrategias relacionadas.', 8, 'waterLover', 'Especialización en Pokémon de agua', 'Tropical'),
('Pat', 'Nuevo en el mundo de TCG, aprendiendo rápidamente.', 3, 'pat9876', 'Aprendizaje y adaptación', 'Informal'),
('Lee', 'Veterano de las cartas coleccionables con años de experiencia.', 20, 'leeStrong', 'Uso de cartas raras y poderosas', 'Elegante'),
('Chris', 'Prefiere los mazos rápidos y ligeros para sorprender al oponente.', 12, 'chrisSpeed', 'Velocidad y sorpresa', 'Urbano'),
('Jordan', 'Fiel a los Pokémon de tipo psíquico, con un enfoque táctico.', 9, 'mindPower', 'Control mental y predicción', 'Psíquico'),
('Casey', 'Coleccionista que disfruta del aspecto social del juego.', 5, 'caseyCollects', 'Diversión y comunidad', 'Cómodo'),
('Robin', 'Estratega que estudia cada movimiento antes de jugar una carta.', 13, 'robinThink', 'Estrategia y paciencia', 'Profesional'),
('Drew', 'Busca crear mazos únicos con combinaciones inesperadas.', 7, 'drewCreative', 'Innovación y creatividad', 'Artístico'),
('Morgan', 'Enfocado en el juego defensivo para agotar al oponente.', 11, 'morganDefense', 'Defensa y resistencia', 'Blindaje'),
('Taylor', 'Aventurero que gusta de explorar todas las facetas del juego.', 4, 'taylorExplore', 'Exploración y aprendizaje', 'Aventurero'),
('Reese', 'Amante de los Pokémon de fuego, siempre buscando la victoria ardiente.', 14, 'fireChamp', 'Dominación con fuego', 'Flamejante'),
('Quinn', 'Prefiere las batallas largas y calculadas para desgastar al rival.', 6, 'quinnCalm', 'Calma y cálculo', 'Meditativo'),
('Parker', 'Jugador ocasional que valora la diversión sobre la competencia.', 2, 'parkerFun', 'Diversión y casualidad', 'Festivo');

-- Creación de Dummy Data a tabla Mazo
INSERT INTO Mazo (id_jugador, Nombre, Descripcion, Elemento, Tamaño, Numero_cartas) VALUES
(1, 'Relámpagos rápidos', 'Un mazo centrado en Pokémon eléctricos para ataques rápidos.', 'Eléctrico', 60, 20),
(2, 'Profundidades oscuras', 'Explora las profundidades con este mazo de Pokémon de agua.', 'Agua', 60, 20),
(3, 'Furia ígnea', 'Quema a tus oponentes con este mazo de tipo fuego.', 'Fuego', 60, 20),
(4, 'Crecimiento silvestre', 'Deja que la naturaleza tome el control con este mazo de tipo planta.', 'Planta', 60, 20),
(5, 'Golpe fantasma', 'Aterroriza a tus oponentes con un mazo de tipo fantasma.', 'Fantasma', 60, 20),
(6, 'Fuerza bruta', 'Somete a tus oponentes con este mazo de tipo lucha.', 'Lucha', 60, 20),
(7, 'Psíquicos misteriosos', 'Desconcierta a tus rivales con estrategias psíquicas.', 'Psíquico', 60, 20),
(8, 'Estrategia helada', 'Congela a tus oponentes con este mazo de tipo hielo.', 'Hielo', 60, 20),
(9, 'Voladores altos', 'Domina los cielos con este mazo de tipo volador.', 'Volador', 60, 20),
(10, 'Veneno letal', 'Envenena y debilita a tus rivales con este mazo.', 'Veneno', 60, 20),
(11, 'Poder terrenal', 'Controla el campo de batalla con este mazo de tipo tierra.', 'Tierra', 60, 20),
(12, 'Rocas sólidas', 'Defiéndete con la inquebrantable fuerza de este mazo.', 'Roca', 60, 20),
(13, 'Acero inquebrantable', 'Un mazo que destaca por su defensa y ataques potentes.', 'Acero', 60, 20),
(14, 'Insectos zumbantes', 'Atrapa a tus oponentes en una red de sorpresas con este mazo.', 'Bicho', 60, 20),
(15, 'Dragones legendarios', 'Desata el poder de los Pokémon más raros y poderosos.', 'Dragón', 60, 20);

-- Creación de Dummy Data a tabla Inventario
INSERT INTO Inventario (id_Carta, id_Jugador, id_mazo) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(4, 2, 2),
(5, 2, 2),
(6, 2, 2),
(7, 3, 3),
(8, 3, 3),
(9, 3, 3),
(10, 4, 4),
(11, 4, 4),
(12, 4, 4),
(13, 5, 5),
(14, 5, 5),
(15, 5, 5);

-- Creación de Dummy Data a tabla Efecto
INSERT INTO Efecto (Nombre, Tipo, Duracion, Cantidad, Detalles) VALUES
('Recuperación', 'Curación', 'Instantáneo', 20, 'Restaura puntos de vida.'),
('Parálisis', 'Estado', '2 turnos', NULL, 'Impide que el oponente ataque.'),
('Intercambio', 'Estrategia', 'Instantáneo', NULL, 'Intercambia Pokémon en batalla.'),
('Potenciación', 'Mejora', 'Permanente', 10, 'Aumenta el daño de ataque.'),
('Envenenamiento', 'Estado', 'Permanente', NULL, 'Inflige daño cada turno.'),
('Confusión', 'Estado', '3 turnos', NULL, 'Pokémon puede atacarse a sí mismo.'),
('Congelación', 'Estado', '1 turno', NULL, 'Congela al Pokémon enemigo.'),
('Quemadura', 'Estado', 'Permanente', NULL, 'Inflige daño cada turno.'),
('Dormir', 'Estado', '2 turnos', NULL, 'Pokémon no puede realizar acciones.'),
('Curar Estado', 'Curación', 'Instantáneo', NULL, 'Elimina estados negativos.'),
('Robo de Vida', 'Curación', 'Instantáneo', 10, 'Roba vida al oponente y cura.'),
('Escudo', 'Defensa', '3 turnos', NULL, 'Reduce el daño recibido.'),
('Duplicación', 'Estrategia', '4 turnos', NULL, 'Duplica la cantidad de ataque.'),
('Reflejo', 'Defensa', '1 turno', NULL, 'Refleja el daño hacia el atacante.'),
('Absorción', 'Mejora', 'Permanente', NULL, 'Absorbe agua para aumentar vida.');

-- Creación de Dummy Data a tabla Trigger
INSERT INTO `Trigger` (Effect_id, Card_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15);

-- Creación de Dummy Data a tabla Juego
INSERT INTO Juego (Turno, Jugador1_id, Jugador2_id, Duracion, Ganador) VALUES
(1, 1, 2, 15, 1),
(2, 3, 4, 20, 4),
(3, 5, 6, 10, 5),
(4, 7, 8, 25, 8),
(5, 9, 10, 30, 9),
(6, 11, 12, 22, 12),
(7, 13, 14, 18, 13),
(8, 15, 1, 16, 1),
(9, 2, 3, 24, 3),
(10, 4, 5, 19, 4),
(11, 6, 7, 28, 6),
(12, 8, 9, 17, 9),
(13, 10, 11, 15, 10),
(14, 12, 13, 20, 12),
(15, 14, 15, 22, 14);

-- Creación de Dummy Data a tabla Turno
INSERT INTO Turno (Jugador_id, Juego_id) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 3),
(7, 4),
(8, 4),
(9, 5),
(10, 5),
(11, 6),
(12, 6),
(13, 7),
(14, 7),
(15, 8),
(1, 8),
(2, 9),
(3, 9),
(4, 10),
(5, 10),
(6, 11),
(7, 11),
(8, 12),
(9, 12),
(10, 13),
(11, 13),
(12, 14),
(13, 14),
(14, 15),
(15, 15);

-- Creación de Dummy Data a tabla Banca
INSERT INTO Banca (Carta_id, Jugador_id, Numero_cartas) VALUES
(1, 1, 3),
(2, 2, 3),
(3, 3, 3),
(4, 4, 3),
(5, 5, 3),
(6, 6, 3),
(7, 7, 3),
(8, 8, 3),
(9, 9, 3),
(10, 10, 3),
(11, 11, 3),
(12, 12, 3),
(13, 13, 3),
(14, 14, 3),
(15, 15, 3);

-- Creación de Dummy Data a tabla Estadisticas
INSERT INTO Estadisticas (Jugador_id, Partidas_ganadas, Partidas_jugadas, Partidas_perdidas, Puntos_torneo) VALUES
(1, 10, 15, 5, 30),
(2, 8, 14, 6, 24),
(3, 12, 18, 6, 36),
(4, 15, 20, 5, 45),
(5, 5, 10, 5, 15),
(6, 7, 12, 5, 21),
(7, 9, 13, 4, 27),
(8, 11, 15, 4, 33),
(9, 6, 10, 4, 18),
(10, 14, 19, 5, 42),
(11, 4, 8, 4, 12),
(12, 3, 7, 4, 9),
(13, 13, 18, 5, 39),
(14, 2, 5, 3, 6),
(15, 1, 3, 2, 3);


