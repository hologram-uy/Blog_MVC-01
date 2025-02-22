USE master
GO

--=======================================================================
-- Creación de la base de datos -----------------------------------------
--=======================================================================
IF EXISTS(SELECT * FROM SysDataBases WHERE name='VideojuegosDB')
BEGIN
	DROP DATABASE VideojuegosDB
END
GO

CREATE DATABASE VideojuegosDB
GO

USE VideojuegosDB
GO

--=======================================================================
-- Creación de Tablas ---------------------------------------------------
--=======================================================================
-- Tabla de Juegos
CREATE TABLE Juegos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Genero NVARCHAR(50) NOT NULL,
    Desarrollador NVARCHAR(100) NOT NULL,
    AnioLanzamiento INT CHECK (AnioLanzamiento >= 1970 AND AnioLanzamiento <= YEAR(GETDATE())),
    Plataforma NVARCHAR(50) NOT NULL
);

-- Tabla de Reseñas
CREATE TABLE Reseñas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    JuegoId INT NOT NULL,
    Usuario NVARCHAR(50) NOT NULL,
    Puntaje INT CHECK (Puntaje BETWEEN 1 AND 10),
    Comentario NVARCHAR(255) NULL,
    Fecha DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (JuegoId) REFERENCES Juegos(Id) ON DELETE CASCADE
);

-- Insertar algunos juegos de ejemplo
INSERT INTO Juegos (Nombre, Genero, Desarrollador, AnioLanzamiento, Plataforma)
VALUES 
('The Legend of Zelda: Breath of the Wild', 'Aventura', 'Nintendo', 2017, 'Nintendo Switch'),
('The Legend of Zelda: Ocarina of Time', 'Aventura', 'Nintendo', 1998, 'Nintendo 64'),
('The Legend of Zelda: Majora''s Mask', 'Aventura', 'Nintendo', 2000, 'Nintendo 64'),
('The Legend of Zelda: Twilight Princess', 'Aventura', 'Nintendo', 2006, 'Nintendo Wii'),
('The Legend of Zelda: Skyward Sword', 'Aventura', 'Nintendo', 2011, 'Nintendo Wii'),
('Elden Ring: Shadow of the Erdtree', 'RPG', 'FromSoftware', 2024, 'PlayStation 5'),
('Elden Ring: Lost Tales', 'RPG', 'FromSoftware', 2023, 'PC'),
('God of War: Ragnarok', 'Acción', 'Santa Monica Studio', 2022, 'PlayStation 5'),
('Cyberpunk 2077: Phantom Liberty', 'RPG', 'CD Projekt Red', 2023, 'PC'),
('Halo 2', 'FPS', 'Bungie', 2004, 'Xbox'),
('Halo 3', 'FPS', 'Bungie', 2007, 'Xbox 360'),
('Halo Reach', 'FPS', 'Bungie', 2010, 'Xbox 360'),
('Red Dead Redemption', 'Aventura', 'Rockstar Games', 2010, 'PlayStation 3'),
('Hollow Knight: Silksong', 'Metroidvania', 'Team Cherry', 2024, 'PC'),
('Sekiro: Shadows Die Twice - GOTY Edition', 'Acción', 'FromSoftware', 2020, 'PC'),
('The Witcher 2: Assassins of Kings', 'RPG', 'CD Projekt Red', 2011, 'PC'),
('The Witcher', 'RPG', 'CD Projekt Red', 2007, 'PC'),
('Super Mario Galaxy', 'Plataformas', 'Nintendo', 2007, 'Nintendo Wii'),
('Super Mario 3D World', 'Plataformas', 'Nintendo', 2013, 'Nintendo Wii U'),
('Dark Souls II', 'RPG', 'FromSoftware', 2014, 'PC'),
('Dark Souls', 'RPG', 'FromSoftware', 2011, 'PC'),
('Bloodborne: The Old Hunters', 'RPG', 'FromSoftware', 2015, 'PlayStation 4'),
('Fortnite: Chapter 4', 'Battle Royale', 'Epic Games', 2023, 'Multiplataforma'),
('GTA IV', 'Acción', 'Rockstar Games', 2008, 'PlayStation 3'),
('League of Legends: Wild Rift', 'MOBA', 'Riot Games', 2020, 'Mobile'),
('Valorant: Episode 6', 'FPS', 'Riot Games', 2023, 'PC'),
('The Last of Us', 'Aventura', 'Naughty Dog', 2013, 'PlayStation 3'),
('Horizon Forbidden West', 'Aventura', 'Guerrilla Games', 2022, 'PlayStation 5'),
('Resident Evil 2 Remake', 'Survival Horror', 'Capcom', 2019, 'Multiplataforma'),
('DOOM', 'FPS', 'id Software', 1993, 'PC'),
('Celeste Classic', 'Plataformas', 'Maddy Makes Games', 2016, 'PC'),
('Dead Cells: Return to Castlevania', 'Roguelike', 'Motion Twin', 2023, 'PC'),
('Undertale: Genocide Route', 'RPG', 'Toby Fox', 2015, 'PC'),
('Persona 5 Royal', 'RPG', 'Atlus', 2019, 'PlayStation 4'),
('Elden Ring', 'RPG', 'FromSoftware', 2022, 'PlayStation 5'),
('God of War', 'Acción', 'Santa Monica Studio', 2018, 'PlayStation 4'),
('Cyberpunk 2077', 'RPG', 'CD Projekt Red', 2020, 'PC'),
('Halo Infinite', 'FPS', '343 Industries', 2021, 'Xbox Series X'),
('Red Dead Redemption 2', 'Aventura', 'Rockstar Games', 2018, 'PC'),
('Hollow Knight', 'Metroidvania', 'Team Cherry', 2017, 'PC'),
('Sekiro: Shadows Die Twice', 'Acción', 'FromSoftware', 2019, 'PC'),
('The Witcher 3: Wild Hunt', 'RPG', 'CD Projekt Red', 2015, 'PC'),
('Minecraft', 'Sandbox', 'Mojang', 2011, 'Multiplataforma'),
('Super Mario Odyssey', 'Plataformas', 'Nintendo', 2017, 'Nintendo Switch'),
('Dark Souls III', 'RPG', 'FromSoftware', 2016, 'PC'),
('Bloodborne', 'RPG', 'FromSoftware', 2015, 'PlayStation 4'),
('Fortnite', 'Battle Royale', 'Epic Games', 2017, 'Multiplataforma'),
('GTA V', 'Acción', 'Rockstar Games', 2013, 'Multiplataforma'),
('League of Legends', 'MOBA', 'Riot Games', 2009, 'PC'),
('Valorant', 'FPS', 'Riot Games', 2020, 'PC'),
('The Last of Us Part II', 'Aventura', 'Naughty Dog', 2020, 'PlayStation 4'),
('Horizon Zero Dawn', 'Aventura', 'Guerrilla Games', 2017, 'PC'),
('Resident Evil 4 Remake', 'Survival Horror', 'Capcom', 2023, 'Multiplataforma'),
('DOOM Eternal', 'FPS', 'id Software', 2020, 'PC'),
('Celeste', 'Plataformas', 'Maddy Makes Games', 2018, 'PC'),
('Dead Cells', 'Roguelike', 'Motion Twin', 2018, 'PC'),
('Undertale', 'RPG', 'Toby Fox', 2015, 'PC'),
('Persona 5', 'RPG', 'Atlus', 2016, 'PlayStation 4');

-- Insertar algunas reseñas de ejemplo
INSERT INTO Reseñas (JuegoId, Usuario, Puntaje, Comentario)
VALUES 
(1, 'Gamer123', 10, 'Increíble mundo abierto y jugabilidad.'),
(2, 'DarkSoulFan', 9, 'Dificultad perfecta y un lore impresionante.'),
(3, 'KratosLover', 10, 'Mejor historia en un juego de acción.'),
(4, 'CyberGuy', 7, 'Muchos bugs al inicio, pero ahora está bien.'),
(5, 'Spartan117', 8, 'Buen multijugador, pero la campaña es floja.'),
(6, 'JohnDoe', 10, 'Un mundo increíblemente detallado y una historia atrapante.'),
(7, 'IndieLover', 9, 'Un metroidvania con una excelente ambientación.'),
(8, 'NinjaWarrior', 10, 'El combate es desafiante y muy satisfactorio.'),
(9, 'RPGMaster', 10, 'Uno de los mejores RPG de la década.'),
(10, 'CreativeMind', 9, 'La creatividad no tiene límites en este juego.'),
(11, 'MarioFan', 10, 'El mejor Mario en 3D hasta la fecha.'),
(12, 'GitGud', 9, 'Dark Souls III mantiene la esencia de la saga y mejora la jugabilidad.'),
(13, 'Hunter', 10, 'Bloodborne tiene una atmósfera única y un combate rápido.'),
(14, 'BattleRoyaleKing', 8, 'Adictivo pero con una comunidad tóxica.'),
(15, 'CriminalMastermind', 9, 'Historia y mundo abierto espectaculares.'),
(16, 'MOBAFan', 7, 'Muy competitivo pero difícil de entrar sin experiencia.'),
(17, 'TacticalShooter', 9, 'Buen equilibrio de habilidades y armas.'),
(18, 'StoryGamer', 10, 'Historia impactante y personajes profundos.'),
(19, 'Explorer', 9, 'Un mundo hermoso para explorar.'),
(20, 'Survivor', 8, 'Gran remake pero algunos cambios en la historia.'),
(21, 'DemonSlayer', 9, 'Una montaña rusa de adrenalina y heavy metal.'),
(22, 'Speedrunner', 10, 'Plataformas con una historia emotiva.'),
(23, 'RougeFan', 9, 'Dificultad bien balanceada y jugabilidad fluida.'),
(24, 'IndieRPG', 10, 'Un RPG único con mecánicas innovadoras.'),
(25, 'PhantomThief', 10, 'Estilo, historia y combate increíble.'),
(1, 'GamerX', 8, 'Muy buen juego pero con algunos errores técnicos.'),
(2, 'MetroidvaniaFan', 9, 'Una obra maestra del género.'),
(3, 'FromSoftwareLover', 10, 'Cada pelea es un reto, pero vale la pena.'),
(4, 'WitcherFan', 10, 'Misiones secundarias que parecen historias principales.'),
(5, 'BlockBuilder', 9, 'Nunca deja de ser divertido.'),
(6, 'WesternLegend', 10, 'El mejor juego de vaqueros que existe.'),
(7, 'Knight', 9, 'Arte hermoso y mecánicas muy pulidas.'),
(8, 'SekiroMain', 10, 'El parry nunca se sintió tan satisfactorio.'),
(9, 'Slayer', 10, 'El combate es arte en movimiento.'),
(10, 'SurvivalHorrorFan', 9, 'Un remake digno de su nombre.');