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
-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that species columns went back to the state before transaction.
BEGIN;
UPDATE animals SET species='unspecified';
ROLLBACK;

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


--Write queries (using JOIN)

--What animals belong to Melody Pond?
SELECT * FROM animals A JOIN owners O  ON A.owner_id=O.id WHERE full_name='Melody Pond';

--List of all animals that are pokemon (their type is Pokemon).

SELECT * FROM animals A JOIN species S  ON A.species_id=S.id WHERE S.name='Pokemon';

--List all owners and their animals, remember to include those that don't own any animal.
SELECT * FROM animals A JOIN owners O  ON A.owner_id=O.id;

--How many animals are there per species?
SELECT COUNT(species_id), S.name FROM animals A JOIN species S  ON A.species_id=S.id GROUP BY S.name;

--List all Digimon owned by Jennifer Orwell.
SELECT * FROM animals A JOIN owners O  ON A.owner_id=O.id JOIN species S ON S.id=A.species_id WHERE O.full_name='Jennifer Orwell' AND S.name='Digimon';

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals A JOIN owners O  ON A.owner_id=O.id  WHERE O.full_name='Dean Winchester' AND A.escape_attempts=0;

--Who owns the most animals?

SELECT full_name, COUNT(name) AS ownings FROM owners O JOIN animals A ON O.id=A.owner_id GROUP BY full_name ORDER BY ownings DESC LIMIT 1;

--write join queries
--Who was the last animal seen by William Tatcher?
SELECT A.name FROM animals A JOIN visits V ON A.id=V.animal_id JOIN vets VE ON VE.id=V.vet_id WHERE VE.name='William Tatcher' ORDER BY V.v_date DESC LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animal_id) FROM visits V JOIN vets VE ON V.vet_id=VE.id WHERE VE.name='Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties.
SELECT V.name,S.name FROM vets V JOIN specializations SP ON V.id=SP.vet_id JOIN species S ON SP.species_id=S.id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT A.id, A.name FROM animals A JOIN visits V ON A.id=V.animal_id JOIN vets VE ON VE.id=V.vet_id WHERE VE.name='Stephanie Mendez' AND V.v_date BETWEEN 'April 1, 2020' AND 'August 30, 2020';

--What animal has the most visits to vets?
SELECT name, COUNT(animal_id) AS visited FROM animals A JOIN visits V ON A.id=V.animal_id GROUP BY name ORDER BY visited DESC LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT A.id, A.name, V.v_date FROM animals A JOIN visits V ON A.id=V.animal_id JOIN vets VE ON VE.id=V.vet_id WHERE VE.name='Maisy Smith' ORDER BY V.v_date ASC LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT A.id, A.name, VE.name, V.v_date AS visit_date FROM animals A JOIN visits V ON A.id=V.animal_id JOIN vets VE ON V.vet_id=VE.id ORDER BY V.v_date DESC LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(V.animal_id) FROM animals A JOIN  visits V  ON A.id=V.animal_id JOIN vets VE ON V.vet_id=VE.id JOIN specializations S ON S.vet_id=VE.id  WHERE A.species_id <> S.species_id;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT SP.name, COUNT(V.animal_id) AS visit_times FROM visits V JOIN animals A ON V.animal_id=A.id JOIN vets VE ON V.vet_id=VE.id JOIN species SP ON SP.id=A.species_id WHERE VE.name='Maisy Smith' GROUP BY SP.name ORDER BY visit_times DESC LIMIT 1; 

--check exucution time 
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4; --=Execution Time: 1258.138 ms

-- The following queries are taking too much time (1 sec = 1000ms can be considered as too much time for database query). Try them on your machine to confirm it:

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;

EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;

EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';