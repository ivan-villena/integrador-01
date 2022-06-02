
USE `ba_desafio`;

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `departamento`
;
CREATE TABLE `departamento` (
  `numero` TINYINT UNSIGNED NOT NULL,
  `nombre` VARCHAR(30) NOT NULL,
  `presupuesto` DOUBLE(8.2) NOT NULL,
  PRIMARY KEY (`numero`)
) 
  ENGINE = InnoDB
;

DELETE FROM `departamento`
;
INSERT INTO `departamento` (`numero`,`nombre`,`presupuesto`) VALUES 
  (14, 'Informática', 80000), 
  (15, 'Gestión', 95000),
  (16, 'Comunicación', 75000),
  (37, 'Desarrollo', 65000 ),
  (77, 'Investigación', 40000)  
;

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `empleado`
;
CREATE TABLE `empleado` ( 
  `id` INT NOT NULL AUTO_INCREMENT ,  
  `dni` INT(8) UNSIGNED NOT NULL ,  
  `nombre` VARCHAR(30) NOT NULL ,  
  `apellido` VARCHAR(30) NOT NULL ,
  `departamento` TINYINT UNSIGNED,
  PRIMARY KEY (`id`),
  INDEX (`departamento`)
) 
  ENGINE = InnoDB
;

ALTER TABLE `empleado` 
  ADD CONSTRAINT `empleado_departamento` FOREIGN KEY (`departamento`) REFERENCES `departamento`(`numero`)    
;

DELETE FROM `empleado`
;
INSERT INTO `empleado` (`dni`,`nombre`,`apellido`,`departamento`) VALUES 
  ( 31096678, 'Juan', 'Lopez', 14 ),
  ( 31096675, 'Martin', 'Zarabia', 77 ),
  ( 34269854, 'Jose', 'velez', 77 ),
  ( 41369852, 'Paula', 'Madariaga', 77 ),
  ( 33698521, 'Pedro', 'Perez', 14 ),
  ( 32698547, 'Mariana', 'Lopez', 15 ),
  ( 42369854, 'Abril', 'Sanchez', 37 ),
  ( 36125896, 'Marti', 'Julia', 14 ),
  ( 36985471, 'Omar', 'Diaz', 15 ),
  ( 32145698, 'Guadalupe', 'Perez', 77 ),
  ( 32369854, 'Bernardo', 'pantera', 37 ),
  ( 36125965, 'Lucia', 'Pesaro', 14 ),
  ( 31236985, 'Maria', 'diamante', 14 ),
  ( 32698547, 'Carmen', 'barbieri', 16 )
;

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

-- 2.1 obtener los apellidos de los empleados
SELECT `apellido` FROM `empleado` ORDER BY `apellido` ASC,`nombre` ASC;

-- 2.2 obtener los apellidos de los empleados sin repeticiones
SELECT DISTINCT `apellido` FROM `empleado` ORDER BY `apellido` ASC,`nombre` ASC;

-- 2.3 obtener los datos de los empleados que tengan el apellido Lopez
SELECT * FROM `empleado` WHERE `apellido` = 'Lopez';

-- 2.4 obtener los datos de los empleados que tengan el apellido Lopez y los que tengan apellido Perez
SELECT * FROM `empleado` WHERE `apellido` IN ('Lopez','Perez') ORDER BY `apellido` ASC, `nombre` ASC;

-- 2.5 Obtener todos los datos de los empleados que trabajen en el departamento 14
SELECT * FROM `empleado` WHERE `departamento` = 14;

-- 2.6 Obtener todos los datos de los empleados que trabajen en el departamento 37 y 77
SELECT * FROM `empleado` WHERE `departamento` = 37 OR `departamento` = 77;

-- 2.7 Obtener los datos de los empleados cuyo apellido comience con P
SELECT * FROM `empleado` WHERE `apellido` LIKE 'P%' ORDER BY `apellido` ASC, `nombre` ASC;

-- 2.8 Obtener el presupuesto total de todos los departamentos
SELECT SUM(`presupuesto`) AS `total` FROM `departamento`;

-- 2.9 Obtener un listado completo de empleados, incluyendo por cada empleado los datos del empleado y de su departamento
SELECT * FROM `empleado` LEFT JOIN `departamento` ON `departamento`.`numero` = `empleado`.`departamento`;

-- 2.10 Obtener un listado completo de empleados, incluyendo el nombre y apellido del empleado junto al nombre y presupuesto de su departamento
SELECT `empleado`.`nombre`, `empleado`.`apellido`, `departamento`.`nombre`, `departamento`.`presupuesto` 
  FROM `empleado` LEFT JOIN `departamento` ON `departamento`.`numero` = `empleado`.`departamento`;

-- 2.11 Obtener los nombres y apellidos de los empleados que trabajen en departamentos cuyo presupuesto sea mayor de 60000
SELECT `empleado`.`nombre`, `empleado`.`apellido`
  FROM `empleado`
  LEFT JOIN `departamento` ON `departamento`.`numero` = `empleado`.`departamento`
  WHERE `departamento`.`presupuesto` > 60000;

-- 2.12 Añadir un nuevo departamento: Calidad con un presupuesto de 40000 y código 11, añadir un empleado vinculado al departamento recién creado: Esther Vazquez, DNI 89267109
INSERT INTO `departamento` ( `numero`,`nombre`,`presupuesto` ) VALUES ( 11, 'Calidad', 40000 );
INSERT INTO `empleado` ( `dni`,`nombre`,`apellido`,`departamento` ) VALUES ( 89267109, 'Esther', 'Vazquez', 11 );

-- 2.13 Aplicar un recorte presupuestario del 10% a todos los departamentos
UPDATE `departamento` SET `presupuesto` = `presupuesto` - ( `presupuesto` * .1 );

-- 2.14 Reasignar a los empleados del departamento de investigación (código 77) al departamento de informática (código 14)
UPDATE `empleado` SET `departamento` = 14 WHERE `departamento` = 77;

-- 2.15 Despedir a los empleados del departamento de informática (código 14)
DELETE FROM `empleado` WHERE `departamento` = 14;

-- 2.16 Despedir a los empleados que trabajen en departamentos con un presupuesto superior a 90000
DELETE FROM `empleado` WHERE `departamento` IN ( SELECT `numero` FROM `departamento` WHERE `presupuesto` > 90000  );

SELECT * FROM `empleado` WHERE `departamento` IN ( SELECT `numero` FROM `departamento` WHERE `presupuesto` > 90000  );

