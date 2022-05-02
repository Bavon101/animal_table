INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES(
	'Agumon',
	'Feb 3, 2020',
	0,
	'1',
	10.23
),(
	'Gabumon',
	'Nov 15, 2018',
	2,
	'1',
	8.0
),(
	'Pikachu',
	'Jan 7, 2021',
	1,
	'0',
	15.04
),(
	'Devimon',
	'May 12, 2017',
	5,
	'1',
	11.0
);

--Insert new data

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES(
	'Charmander',
	'Feb 8, 2020',
	0,
	'0',
	-11
),(
	'Plantmon',
	'Nov 15, 2021',
	2,
	'1',
	-5.7
),(
	'Squirtle',
	'Apr 2, 1993',
	3,
	'0',
	-12.13
),(
	'Angemon',
	'Jun 12, 2005',
	1,
	'1',
	-45
),(
	'Boarmon',
	'Jun 7, 2005',
	7,
	'1',
	20.4
),(
	'Blossom',
	'Oct 13, 1998',
	3,
	'1',
	17
),(
	'Ditto',
	'May 14, 2022',
	4,
	'1',
	22
);

-- insert owners data

INSERT INTO owners (full_name,age) VALUES(
	'Sam Smith',
	34
),(
	'Jennifer Orwell',
	19
),(
	'Bob',
	45
),(
	'Melody Pond',
	77
),(
	'Dean Winchester',
	14
),(
	'Jodie Whittaker',
	38
);

--insert species data
INSERT INTO species(name) VALUES(
	'Pokemon'
),(
	'Digimon'
);

--Modify your inserted animals so it includes the species_id value:
--If the name ends in "mon" it will be Digimon'
UPDATE animals SET species_id=specie.id FROM (SELECT id FROM species WHERE name='Digimon') AS specie WHERE upper(name) LIKE '%MON';

--All other animals are Pokemon
UPDATE animals SET species_id=specie.id FROM (SELECT id FROM species WHERE name='Pokemon') AS specie WHERE species_id IS NULL;

--Modify your inserted animals to include owner information (owner_id):
UPDATE animals SET owner_id=owner.id FROM (SELECT id FROM owners WHERE full_name='Sam Smith') AS owner WHERE name='Agumon';

UPDATE animals SET owner_id=owner.id FROM (SELECT id FROM owners WHERE full_name='Jennifer Orwell') AS owner WHERE (name='Gabumon' OR name='Pikachu');

UPDATE animals SET owner_id=owner.id FROM (SELECT id FROM owners WHERE full_name='Bob') AS owner WHERE (name='Devimon' OR name='Plantmon');

UPDATE animals SET owner_id=owner.id FROM (SELECT id FROM owners WHERE full_name='Melody Pond') AS owner WHERE (name='Charmander' OR name='Squirtle' OR name='Blossom');

UPDATE animals SET owner_id=owner.id FROM (SELECT id FROM owners WHERE full_name='Dean Winchester') AS owner WHERE (name='Angemon' OR name='Boarmon');

--insert vets data
INSERT INTO vets(name,age,date_of_graduation) VALUES(
	'William Tatcher',
	45,
	'Apr 23, 2000'
),(
	'Maisy Smith',
	26,
	'Jan 17, 2019'
),(
	'Stephanie Mendez',
	64,
	'May 4, 1981'
),(
	'Jack Harkness',
	38,
	'Jun 8, 2008'
);

-- insert specialties data
INSERT INTO specializations(species_id,vet_id) VALUES( 
	(SELECT id AS species_id FROM species WHERE name='Pokemon'),
	(SELECT id AS vet_id FROM vets WHERE name='William Tatcher')
	),
	(
	 (SELECT id AS species_id FROM species WHERE name='Pokemon'),
	(SELECT id AS vet_id FROM vets WHERE name='Stephanie Mendez')
	),
	(
	 (SELECT id AS species_id FROM species WHERE name='Digimon'),
	(SELECT id AS vet_id FROM vets WHERE name='Stephanie Mendez')
	),
	(
	 (SELECT id AS species_id FROM species WHERE name='Digimon'),
	(SELECT id AS vet_id FROM vets WHERE name='Jack Harkness')
	);
	

--insert visits data
INSERT INTO visits(animal_id,vet_id,v_date) VALUES(
	(SELECT id AS animal_id FROM animals WHERE name='Agumon'),
	(SELECT id AS vet_id FROM vets WHERE name='William Tatcher'),
	'May 24, 2020'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Agumon'),
	(SELECT id AS vet_id FROM vets WHERE name='Stephanie Mendez'),
	'Jul 22, 2020'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Gabumon' ),
	(SELECT id AS vet_id FROM vets WHERE name='Jack Harkness'),
	'Feb 2, 2021'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Pikachu'),
	(SELECT id AS vet_id FROM vets WHERE name='Maisy Smith'),
	'Jan 5, 2020'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Pikachu'),
	(SELECT id AS vet_id FROM vets WHERE name='Maisy Smith'),
	'Mar 8, 2020'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Pikachu'),
	(SELECT id AS vet_id FROM vets WHERE name='Maisy Smith'),
	'May 14, 2020'
),
(
	(SELECT id AS animal_id  FROM animals WHERE name='Devimon'),
	(SELECT id AS vet_id FROM vets WHERE name='Stephanie Mendez'),
	'May 14, 2021'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Charmander'),
	(SELECT id AS vet_id FROM vets WHERE name='Jack Harkness'),
	'Feb 24, 2021'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Plantmon'),
	(SELECT id AS vet_id FROM vets WHERE name='Maisy Smith'),
	'Dec 21, 2019'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Plantmon'),
	(SELECT id AS vet_id FROM vets WHERE name='William Tatcher'),
	'Aug 10, 2020'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Plantmon'),
	(SELECT id AS vet_id FROM vets WHERE name='Maisy Smith'),
	'Apr 7, 2021'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Squirtle'),
	(SELECT id AS vet_id FROM vets WHERE name='Stephanie Mendez'),
	'Sep 29, 2019'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Angemon'),
	(SELECT id AS vet_id FROM vets WHERE name='Jack Harkness'),
	'Oct 3, 2020'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Angemon'),
	(SELECT id AS vet_id FROM vets WHERE name='Jack Harkness'),
	'Nov 4, 2020'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Boarmon'),
	(SELECT id AS vet_id FROM vets WHERE name='Maisy Smith'),
	'Jan 24, 2019'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Boarmon'),
	(SELECT id AS vet_id FROM vets WHERE name='Maisy Smith'),
	'May 15, 2019'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Boarmon'),
	(SELECT id AS vet_id FROM vets WHERE name='Maisy Smith'),
	'Feb 27, 2020'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Boarmon'),
	(SELECT id AS vet_id FROM vets WHERE name='Maisy Smith'),
	'Aug 3, 2020'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Blossom'),
	(SELECT id AS vet_id FROM vets WHERE name='Stephanie Mendez'),
	'May 24, 2020'
),
(
	(SELECT id AS animal_id FROM animals WHERE name='Blossom'),
	(SELECT id AS vet_id FROM vets WHERE name='William Tatcher'),
	'Jan 11, 2021'
);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, v_date) SELECT * FROM (SELECT id FROM animalss) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';