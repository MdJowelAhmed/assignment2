-- Active: 1747499093717@@127.0.0.1@7589@conservation_db
CREATE DATABASE conservation_db

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,  
    name VARCHAR(255) NOT NULL,
    region VARCHAR(255) NOT NULL
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(255) NOT NULL,
    scientific_name VARCHAR(255) NOT NULL,
    conservation_status VARCHAR(50) NOT NULL,
    discovered_date DATE NOT NULL
);

DROP TABLE IF EXISTS species;

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT NOT NULL REFERENCES species(species_id) ON DELETE CASCADE,
    ranger_id INT NOT NULL REFERENCES rangers(ranger_id) ON DELETE CASCADE,
    sighting_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    location VARCHAR(255) NOT NULL,
    notes TEXT
);

DROP TABLE IF EXISTS sightings;
SELECT * FROM rangers;

DROP TABLE IF EXISTS rangers;
DROP TABLE IF EXISTS species;

DROP TABLE IF EXISTS sightings;


--problem 1
INSERT INTO rangers (name, region) VALUES
('John Doe', 'Amazon Rainforest'),
('Jane Smith', 'Serengeti National Park'),
('Ali Hossain', 'Great Barrier Reef'),
('Mehedi Hasan', 'Yellowstone National Park'),
('Sara Ali', 'Galapagos Islands');
SELECT * FROM rangers;


--problem 2
INSERT INTO species (common_name, scientific_name, conservation_status, discovered_date) VALUES
('Jaguar', 'Panthera onca', 'Endangered', '2010-05-15'),
('African Elephant', 'Loxodonta africana', 'Vulnerable', '2005-08-20'),
('Green Sea Turtle', 'Chelonia mydas', 'Endangered', '2012-03-10'),
('Snow Leopard', 'Panthera uncia', 'Vulnerable', '2008-11-25'),
('Giant Panda', 'Ailuropoda melanoleuca', 'Endangered', '2015-07-30');

SELECT * FROM species;

INSERT INTO sightings (species_id, ranger_id, sighting_time, location, notes) VALUES
(1, 1, '2023-10-01 10:00:00', 'Amazon Rainforest - Brazil', 'Spotted near the riverbank'),
(2, 2, '2023-10-02 14:30:00', 'Serengeti National Park - Tanzania', 'Herd of elephants seen grazing'),
(3, 3, '2023-10-03 09:15:00', 'Great Barrier Reef - Australia', 'Turtle nesting observed'),
(4, 4, '2023-10-04 16:45:00', 'Yellowstone National Park - USA', 'Snow leopard tracks found'),
(1, 2, '2023-10-01 12:00:00', 'Serengeti National Snowfall Pass  - Tanzania', 'Jaguar resting in the shade'),
(2, 3, '2023-10-02 13:00:00', 'Great Barrier Reef - Australia', 'Elephant swimming near the reef'),
(3, 4, '2023-10-03 15:30:00', 'Yellowstone National Snowfall Pass - USA', 'Green sea turtle basking on the shore');

SELECT * FROM sightings;
SELECT COUNT(DISTINCT species_id) FROM sightings;

DROP TABLE IF EXISTS sightings;

--problem 3
SELECT * FROM sightings WHERE LOCATION like '%Pass%'

--problem 4
SELECT 
  rangers.name AS ranger_name,
  COUNT(*) AS total_sightings
FROM sightings
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
GROUP BY rangers.name

--problem 5
SELECT *
FROM species
WHERE species_id NOT IN (
  SELECT DISTINCT species_id
  FROM sightings
);

--problem 6

SELECT * FROM sightings

SELECT 
  sightings.sighting_id,
  species.common_name,
  rangers.name AS ranger_name,
  sightings.sighting_time
FROM sightings
JOIN species ON sightings.species_id = species.species_id
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 2;


--problem 7
UPDATE species
SET conservation_status = 'Historic'
WHERE discovered_date > '1800-01-01';

SELECT *
FROM species