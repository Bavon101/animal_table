--create patients table
CREATE TABLE patients(
	id INT,
	name CHAR(255),
	date_of_birth DATE
);

-- create medical_hitories
CREATE TABLE medical_histories(
	id INT,
	admitted_at TIME,
	patient_id INT,
	status CHAR(255)
);

-- create invoices table

CREATE TABLE invoices(
	id INT,
	total_amount DECIMAL,
	generated_at TIME,
	payed_at TIME,
	medical_history_id INT
);

--create invoice_items

CREATE TABLE invoice_items(
	id INT,
	unit_price DECIMAL,
	quantity INT,
	total_price DECIMAL,
	invoice_id INT,
	treatment_id INT
);

-- create treatments table
CREATE TABLE treatments(
	id INT,
	type CHAR(255),
	name CHAR(255)
);