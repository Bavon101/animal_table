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
