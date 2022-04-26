-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE upper(name) LIKE '%MON';

-- List the name of all animals born between 2016 and 2019.
SELECT * FROM animals WHERE date_of_birth BETWEEN 'Jan 1, 2016' AND 'Dec 31, 2019';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered='1' AND escape_attempts<3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;

--Find all animals that are neutered.
SELECT * FROM animals WHERE neutered='1';

--Find all animals not named Gabumon.
SELECT * FROM animals WHERE NOT name='Gabumon';

--Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.3 AND 17.4;

--Inside a transaction
BEGIN;
--Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species='digimon' WHERE upper(name) LIKE '%MON';

--Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species='pokemon' WHERE TRIM(species) IS NULL;

--Commit the transaction.
COMMIT;


--delete all records in the animals table, then roll back the transaction.
--Inside a transaction
BEGIN;
DELETE FROM animals;
--roll back verify if all records in the animals table still exist
ROLLBACK;

--Inside a transaction
--Delete all animals born after Jan 1st, 2022.
BEGIN;
DELETE FROM animals WHERE date_of_birth > 'Jan 1, 2022';
--Create a savepoint for the transaction.
SAVEPOINT del;

--Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;

--Rollback to the savepoint
ROLLBACK del;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
--Commit the transaction.
COMMIT;

--Write queries to

--How many animals are there?
SELECT COUNT(*) FROM animals;

--How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts=0;

--What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

--Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered; 

--What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species; 

--What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN 'Jan 1, 1990' AND 'Dec 31, 2000' GROUP BY species; 

