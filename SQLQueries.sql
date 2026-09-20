DROP TABLE IF EXISTS Viewing;
DROP TABLE IF EXISTS `Transaction`;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Agent;


-- Tables creation
CREATE TABLE Agent (
    agent_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    hire_date DATE NOT NULL
);

CREATE TABLE Client (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    client_type ENUM('Buyer', 'Seller', 'Landlord', 'Tenant') NOT NULL
);

CREATE TABLE Property (
    property_id INT PRIMARY KEY AUTO_INCREMENT,
    address VARCHAR(150) NOT NULL,
    city VARCHAR(50) NOT NULL,
    postcode VARCHAR(20) NOT NULL,
    property_type ENUM('Apartment', 'House', 'Commercial', 'Studio') NOT NULL,
    bedrooms INT,
    bathrooms INT,
    price DECIMAL(12,2) NOT NULL,
    status ENUM('Available', 'Under Offer', 'Sold', 'Rented') NOT NULL DEFAULT 'Available',
    listing_date DATE NOT NULL
);

CREATE TABLE `Transaction` (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT NOT NULL,
    client_id INT NOT NULL,
    agent_id INT NOT NULL,
    transaction_type ENUM('Sale', 'Rental') NOT NULL,
    transaction_date DATE NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    status ENUM('Pending', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Pending',
    CONSTRAINT fk_transaction_property FOREIGN KEY (property_id) REFERENCES Property(property_id),
    CONSTRAINT fk_transaction_client FOREIGN KEY (client_id) REFERENCES Client(client_id),
    CONSTRAINT fk_transaction_agent FOREIGN KEY (agent_id) REFERENCES Agent(agent_id)
);

CREATE TABLE Viewing (
    viewing_id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT NOT NULL,
    client_id INT NOT NULL,
    agent_id INT NOT NULL,
    viewing_date DATETIME NOT NULL,
    viewing_status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Scheduled',
    CONSTRAINT fk_viewing_property FOREIGN KEY (property_id) REFERENCES Property(property_id),
    CONSTRAINT fk_viewing_client FOREIGN KEY (client_id) REFERENCES Client(client_id),
    CONSTRAINT fk_viewing_agent FOREIGN KEY (agent_id) REFERENCES Agent(agent_id)
);


-- Data insertion into tables
INSERT INTO Agent (first_name, last_name, email, phone, hire_date)
VALUES
('Anna', 'Schmidt', 'anna.schmidt@berealty.de', '+49 30 5551001', '2021-03-15'),
('Markus', 'Weber', 'markus.weber@berealty.de', '+49 30 5551002', '2022-06-20'),
('Sophie', 'Fischer', 'sophie.fischer@berealty.de', '+49 30 5551003', '2020-11-10'),
('Daniel', 'Klein', 'daniel.klein@berealty.de', '+49 30 5551004', '2023-01-12'),
('Laura', 'Wagner', 'laura.wagner@berealty.de', '+49 30 5551005', '2024-04-08');

INSERT INTO Client (first_name, last_name, email, phone, client_type)
VALUES
('Thomas', 'Muller', 'thomas.muller@example.com', '+49 171 1000001', 'Buyer'),
('Emma', 'Becker', 'emma.becker@example.com', '+49 171 1000002', 'Buyer'),
('Lukas', 'Hoffmann', 'lukas.hoffmann@example.com', '+49 171 1000003', 'Seller'),
('Clara', 'Schneider', 'clara.schneider@example.com', '+49 171 1000004', 'Tenant'),
('Felix', 'Richter', 'felix.richter@example.com', '+49 171 1000005', 'Buyer'),
('Mia', 'Zimmermann', 'mia.zimmermann@example.com', '+49 171 1000006', 'Landlord'),
('Jonas', 'Hartmann', 'jonas.hartmann@example.com', '+49 171 1000007', 'Buyer'),
('Lea', 'Kruger', 'lea.kruger@example.com', '+49 171 1000008', 'Tenant');

INSERT INTO Property
(address, city, postcode, property_type, bedrooms, bathrooms, price, status, listing_date)
VALUES
('12 Friedrichstrasse', 'Berlin', '10117', 'Apartment', 2, 1, 385000.00, 'Available', '2026-01-10'),
('45 Kurfurstenstrasse', 'Berlin', '10785', 'Apartment', 3, 2, 525000.00, 'Sold', '2026-01-15'),
('8 Prenzlauer Allee', 'Berlin', '10405', 'House', 4, 2, 780000.00, 'Available', '2026-02-01'),
('27 Alexanderplatz', 'Berlin', '10178', 'Commercial', 0, 2, 950000.00, 'Under Offer', '2026-02-12'),
('91 Sonnenallee', 'Berlin', '12045', 'Apartment', 2, 1, 310000.00, 'Rented', '2026-02-20'),
('33 Invalidenstrasse', 'Berlin', '10115', 'Studio', 1, 1, 245000.00, 'Available', '2026-03-05'),
('16 Kantstrasse', 'Berlin', '10623', 'Apartment', 3, 2, 610000.00, 'Available', '2026-03-12'),
('72 Schonhauser Allee', 'Berlin', '10437', 'House', 5, 3, 890000.00, 'Sold', '2026-03-18'),
('54 Oranienstrasse', 'Berlin', '10999', 'Apartment', 2, 1, 420000.00, 'Available', '2026-04-02'),
('101 Leipziger Strasse', 'Berlin', '10117', 'Commercial', 0, 1, 670000.00, 'Available', '2026-04-10');

INSERT INTO `Transaction`
(property_id, client_id, agent_id, transaction_type, transaction_date, amount, status)
VALUES
(2, 1, 1, 'Sale', '2026-02-05', 515000.00, 'Completed'),
(5, 4, 2, 'Rental', '2026-03-01', 18000.00, 'Completed'),
(8, 5, 3, 'Sale', '2026-03-25', 875000.00, 'Completed'),
(4, 6, 4, 'Sale', '2026-04-15', 930000.00, 'Pending'),
(9, 7, 1, 'Sale', '2026-04-22', 410000.00, 'Completed'),
(1, 2, 5, 'Sale', '2026-05-10', 380000.00, 'Completed'),
(7, 3, 2, 'Sale', '2026-05-18', 600000.00, 'Completed'),
(3, 8, 3, 'Rental', '2026-06-02', 24000.00, 'Completed');

INSERT INTO Viewing
(property_id, client_id, agent_id, viewing_date, viewing_status)
VALUES
(1, 1, 1, '2026-01-20 10:00:00', 'Completed'),
(3, 2, 2, '2026-02-10 14:30:00', 'Completed'),
(6, 4, 3, '2026-03-08 11:00:00', 'Completed'),
(7, 5, 2, '2026-03-20 15:00:00', 'Completed'),
(9, 7, 1, '2026-04-10 13:00:00', 'Completed'),
(10, 6, 4, '2026-04-18 09:30:00', 'Scheduled'),
(3, 8, 3, '2026-05-05 16:00:00', 'Completed'),
(1, 2, 5, '2026-05-15 12:00:00', 'Scheduled');


-- Data insertion verification
SELECT * FROM Agent;

SELECT * FROM Client;

SELECT * FROM Property;

SELECT * FROM Transaction;

SELECT * FROM Viewing;






-- Query 1: Display all available properties
SELECT *
FROM Property
WHERE status = 'Available';



-- Query 2: Properties above €500,000
SELECT
    property_id,
    address,
    property_type,
    price,
    status
FROM Property
WHERE price > 500000
ORDER BY price DESC;



-- Query 3: Apartments in Berlin
SELECT
    property_id,
    address,
    postcode,
    bedrooms,
    bathrooms,
    price
FROM Property
WHERE property_type = 'Apartment'
AND city = 'Berlin';



-- Query 4: Buyers
SELECT
    client_id,
    first_name,
    last_name,
    email
FROM Client
WHERE client_type = 'Buyer';


-- JOIN 1 — Transactions + Property
SELECT
    t.transaction_id,
    p.address,
    p.property_type,
    t.transaction_type,
    t.transaction_date,
    t.amount,
    t.status
FROM Transaction t
INNER JOIN Property p
    ON t.property_id = p.property_id
ORDER BY t.transaction_date;

-- JOIN 2 — Transactions + Clients
SELECT
    t.transaction_id,
    c.first_name,
    c.last_name,
    c.client_type,
    t.transaction_type,
    t.amount,
    t.transaction_date
FROM Transaction t
INNER JOIN Client c
    ON t.client_id = c.client_id
ORDER BY t.transaction_date;


-- JOIN 3 — Transactions + Agents
SELECT
    t.transaction_id,
    a.first_name,
    a.last_name,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status
FROM Transaction t
INNER JOIN Agent a
    ON t.agent_id = a.agent_id
ORDER BY t.transaction_date;


-- JOIN 4 — All major entities
SELECT
    t.transaction_id,
    p.address,
    c.first_name AS client_first_name,
    c.last_name AS client_last_name,
    a.first_name AS agent_first_name,
    a.last_name AS agent_last_name,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status
FROM Transaction t
INNER JOIN Property p
    ON t.property_id = p.property_id
INNER JOIN Client c
    ON t.client_id = c.client_id
INNER JOIN Agent a
    ON t.agent_id = a.agent_id
ORDER BY t.transaction_date;


-- Transactions by each agent
SELECT
    a.agent_id,
    a.first_name,
    a.last_name,
    COUNT(t.transaction_id) AS transaction_count
FROM Agent a
LEFT JOIN Transaction t
    ON a.agent_id = t.agent_id
GROUP BY
    a.agent_id,
    a.first_name,
    a.last_name
ORDER BY transaction_count DESC;



-- Aggregation and business analysis
SELECT
    AVG(price) AS average_property_price
FROM Property;

SELECT
    property_type,
    COUNT(*) AS number_of_properties,
    AVG(price) AS average_price
FROM Property
GROUP BY property_type
ORDER BY number_of_properties DESC;

SELECT
    SUM(amount) AS total_transaction_value
FROM Transaction
WHERE status = 'Completed';

SELECT
    a.agent_id,
    a.first_name,
    a.last_name,
    COUNT(t.transaction_id) AS total_transactions,
    COALESCE(SUM(t.amount), 0) AS total_transaction_value
FROM Agent a
LEFT JOIN Transaction t
    ON a.agent_id = t.agent_id
    AND t.status = 'Completed'
GROUP BY
    a.agent_id,
    a.first_name,
    a.last_name
ORDER BY total_transaction_value DESC;




-- Subquery 1 — Above average property price
SELECT
    property_id,
    address,
    property_type,
    price
FROM Property
WHERE price > (
    SELECT AVG(price)
    FROM Property
)
ORDER BY price DESC;


-- Subquery 2 — Agents with above-average transaction counts
SELECT
    a.agent_id,
    a.first_name,
    a.last_name,
    COUNT(t.transaction_id) AS transaction_count
FROM Agent a
INNER JOIN Transaction t
    ON a.agent_id = t.agent_id
GROUP BY
    a.agent_id,
    a.first_name,
    a.last_name
HAVING COUNT(t.transaction_id) > (
    SELECT AVG(transaction_count)
    FROM (
        SELECT COUNT(*) AS transaction_count
        FROM Transaction
        GROUP BY agent_id
    ) AS agent_counts
);


-- Monthly Transaction Report
SELECT
    YEAR(transaction_date) AS transaction_year,
    MONTH(transaction_date) AS transaction_month,
    COUNT(*) AS number_of_transactions,
    SUM(amount) AS total_transaction_value
FROM Transaction
WHERE status = 'Completed'
GROUP BY
    YEAR(transaction_date),
    MONTH(transaction_date)
ORDER BY
    transaction_year,
    transaction_month;


-- Quarterly Transaction Report
    SELECT
    YEAR(transaction_date) AS transaction_year,
    QUARTER(transaction_date) AS quarter,
    COUNT(*) AS number_of_transactions,
    SUM(amount) AS total_transaction_value
FROM Transaction
WHERE status = 'Completed'
GROUP BY
    YEAR(transaction_date),
    QUARTER(transaction_date)
ORDER BY
    transaction_year,
    quarter;


-- Yearly Transaction Report
    SELECT
    YEAR(transaction_date) AS transaction_year,
    COUNT(*) AS number_of_transactions,
    SUM(amount) AS total_transaction_value,
    AVG(amount) AS average_transaction_value
FROM Transaction
WHERE status = 'Completed'
GROUP BY YEAR(transaction_date)
ORDER BY transaction_year;



-- Transaction History
SELECT
    p.address,
    p.property_type,
    t.transaction_type,
    t.transaction_date,
    t.amount,
    t.status,
    c.first_name AS client_first_name,
    c.last_name AS client_last_name,
    a.first_name AS agent_first_name,
    a.last_name AS agent_last_name
FROM Transaction t
INNER JOIN Property p
    ON t.property_id = p.property_id
INNER JOIN Client c
    ON t.client_id = c.client_id
INNER JOIN Agent a
    ON t.agent_id = a.agent_id
ORDER BY
    p.property_id,
    t.transaction_date;


  -- Property Viewing Report
    SELECT
    v.viewing_id,
    p.address,
    c.first_name AS client_first_name,
    c.last_name AS client_last_name,
    a.first_name AS agent_first_name,
    a.last_name AS agent_last_name,
    v.viewing_date,
    v.viewing_status
FROM Viewing v
INNER JOIN Property p
    ON v.property_id = p.property_id
INNER JOIN Client c
    ON v.client_id = c.client_id
INNER JOIN Agent a
    ON v.agent_id = a.agent_id
ORDER BY v.viewing_date;



-- Trigger creation and Property status before trigger execution
DELIMITER //

CREATE TRIGGER trg_transaction_completed
AFTER UPDATE ON Transaction
FOR EACH ROW
BEGIN
    IF NEW.status = 'Completed'
       AND OLD.status <> 'Completed' THEN

        IF NEW.transaction_type = 'Sale' THEN
            UPDATE Property
            SET status = 'Sold'
            WHERE property_id = NEW.property_id;
        ELSEIF NEW.transaction_type = 'Rental' THEN
            UPDATE Property
            SET status = 'Rented'
            WHERE property_id = NEW.property_id;
        END IF;

    END IF;
END //

DELIMITER ;


SELECT
    property_id,
    address,
    status
FROM Property
WHERE property_id = 4;

-- Trigger testing and Property status after transaction completion trigger
UPDATE Transaction
SET status = 'Completed'
WHERE transaction_id = 4;


SELECT
    property_id,
    address,
    status
FROM Property
WHERE property_id = 4;



-- Final database verification
SELECT 'Agents' AS table_name, COUNT(*) AS record_count
FROM Agent

UNION ALL

SELECT 'Clients', COUNT(*)
FROM Client

UNION ALL

SELECT 'Properties', COUNT(*)
FROM Property

UNION ALL

SELECT 'Transactions', COUNT(*)
FROM Transaction

UNION ALL

SELECT 'Viewings', COUNT(*)
FROM Viewing;





