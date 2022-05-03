--create patients table
CREATE TABLE patients(
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name CHAR(255),
	date_of_birth DATE
);

-- create medical_hitories
CREATE TABLE medical_histories(
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	admitted_at TIME,
	patient_id INT,
	status CHAR(255)
);

-- create invoices table

CREATE TABLE invoices(
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	total_amount DECIMAL,
	generated_at TIME,
	payed_at TIME,
	medical_history_id INT
);

--create invoice_items

CREATE TABLE invoice_items(
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	unit_price DECIMAL,
	quantity INT,
	total_price DECIMAL,
	invoice_id INT,
	treatment_id INT
);

-- create treatments table
CREATE TABLE treatments(
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	type CHAR(255),
	name CHAR(255)
);

-- add table relationships
-- for one-to-many relations

ALTER TABLE medical_histories ADD FOREIGN KEY (patient_id) REFERENCES patients(id);
ALTER TABLE invoices ADD FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id);
ALTER TABLE invoice_items ADD FOREIGN KEY (invoice_id) REFERENCES invoices(id);
ALTER TABLE invoice_items ADD FOREIGN KEY (treatment_id) REFERENCES treatments(id);

-- for many-to-many relations

-- create a "join table" called hospitalizations for the medical_histories and treatments tables
CREATE TABLE hospitalizations(
	medical_history_id INT,
	treatment_id INT
);
