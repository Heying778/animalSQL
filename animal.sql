DROP TABLE assignment;
DROP TABLE staff;
DROP TABLE animal;
DROP TABLE enclosure ;

-- // enclosure
CREATE TABLE enclosure (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255), 
    capacity INT,
    closedForMaintenance BOOLEAN
);
-- // staff
CREATE TABLE staff(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    employeeNumber INT
);
-- // animal
CREATE TABLE animal (

	id SERIAL PRIMARY KEY,
    name VARCHAR(255), 
    type VARCHAR(255),
    age int ,
    enclosure_id INT REFERENCES enclosure(id)
);
-- // assignment
CREATE TABLE assignment(
    id SERIAL PRIMARY KEY,
    employeeId INT REFERENCES staff(id),
    enclosureId INT REFERENCES enclosure(id),
    day VARCHAR (255)
);

INSERT INTO enclosure (name, capacity, closedForMaintenance) VALUES ('big cat field',20,false);
INSERT INTO enclosure (name, capacity, closedForMaintenance) VALUES ('bird field',20,false);
INSERT INTO enclosure (name, capacity, closedForMaintenance) VALUES ('snake field',20,true);
INSERT INTO enclosure (name, capacity, closedForMaintenance) VALUES ('elephant field',20,false);

INSERT INTO staff (name,employeeNumber ) VALUES ('Captain Rik', 12345);
INSERT INTO staff (name,employeeNumber ) VALUES ('Allen', 11111);
INSERT INTO staff (name,employeeNumber ) VALUES ('Bill', 22222);
INSERT INTO staff (name,employeeNumber ) VALUES ('Cala', 33333);

INSERT INTO animal (name, type, age,enclosure_id ) VALUES ('Tony', 'Tiger', 59, 1);
INSERT INTO animal (name, type, age,enclosure_id ) VALUES ('Simba', 'Lion', 23, 1);
INSERT INTO animal (name, type, age,enclosure_id ) VALUES ('Tom', 'Snake', 34, 3);
INSERT INTO animal (name, type, age,enclosure_id ) VALUES ('Jeff', 'Elephant', 76, 4);

INSERT INTO assignment(employeeId, enclosureId, day) VALUES (1,1,'Tuesday');
INSERT INTO assignment(employeeId, enclosureId, day) VALUES (2,3,'Monday');
INSERT INTO assignment(employeeId, enclosureId, day) VALUES (3,1,'Tuesday');
INSERT INTO assignment(employeeId, enclosureId, day) VALUES (4,2,'Friday');

-- SELECT * FROM enclosure;
-- SELECT * FROM staff;
-- SELECT * FROM animal;
-- SELECT * FROM assignment;

-- The names of the animals in a given enclosure
------------------------------------------------
SELECT animal.name FROM animal
INNER JOIN enclosure
ON enclosure.id = animal.enclosure_id
WHERE enclosure.name = 'big cat field';

------------------------------------------------


-- The names of the staff working in a given enclosure
------------------------------------------------
SELECT staff.name FROM staff
INNER JOIN assignment
ON assignment.employeeId = staff.id
INNER JOIN enclosure
ON enclosure.id = assignment.enclosureId
WHERE enclosure.name = 'big cat field';

------------------------------------------------

-- * The names of staff working in enclosures which 
-- are closed for maintenance
------------------------------------------------
SELECT staff.name FROM staff
INNER JOIN assignment
ON assignment.employeeId = staff.id
INNER JOIN enclosure
ON enclosure.id = assignment.enclosureId
WHERE enclosure.closedForMaintenance = true;

------------------------------------------------

-- * The name of the enclosure where the oldest animal 
-- lives. If there are two animals who are the same age choose the first one alphabetically.
------------------------------------------------
SELECT enclosure.name, animal.type, animal.age from animal
INNER JOIN enclosure
ON enclosure.id = animal.enclosure_id
ORDER BY animal.age DESC
LIMIT 1 ;
------------------------------------------------

-- * The number of different animal types a given keeper 
-- has been assigned to work with.
------------------------------------------------
SELECT COUNT(DISTINCT( animal.type )) FROM staff
INNER JOIN assignment
ON assignment.employeeId = staff.id
INNER JOIN enclosure
ON enclosure.id = assignment.enclosureId
INNER JOIN animal
ON animal.enclosure_id = enclosure.id
WHERE staff.name = 'Allen'
;
------------------------------------------------

-- * The number of different keepers who have been assigned 
-- to work in a given enclosure
------------------------------------------------
SELECT COUNT(DISTINCT employees.name) FROM employees
INNER JOIN assignments
ON employees.id = assignments.employee_id
WHERE assignments.enclosure_id = 1;
------------------------------------------------

-- * The names of the other animals sharing an enclosure with 
-- a given animal (eg. find the names of all the animals sharing 
-- the big cat field with Tony)
------------------------------------------------
SELECT roommates.name FROM animals
INNER JOIN enclosures
ON animals.enclosure_id = enclosures.id
INNER JOIN animals AS roommates
ON enclosures.id = roommates.enclosure_id
WHERE animals.id = 1;
------------------------------------------------
