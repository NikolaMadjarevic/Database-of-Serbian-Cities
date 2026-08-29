-- ============================================
-- SERBIAN CITIES GIS & SPATIAL ANALYSIS
-- SQL QUERY COLLECTION
-- ============================================

-- ============================================
-- 1. ATTRIBUTE & DEMOGRAPHIC ANALYSIS
-- ============================================

-- Query 1: Top 10 most populated cities
SELECT name, population
FROM cities
ORDER BY population DESC
LIMIT 10;

-- Query 2: Cities with population density above 100 people/km²
SELECT name, population_density
FROM cities
WHERE population_density > 100
ORDER BY population_density;

-- Query 3: Cities ordered by area
SELECT name, area_km2
FROM cities
ORDER BY area_km2 ASC;

-- Query 4: Average population across all cities
SELECT AVG(population) AS average_population
FROM cities;

-- Query 5: Cities with above-average population
SELECT name, population
FROM cities
WHERE population > (
SELECT AVG(population)
FROM cities)
ORDER BY population;

-- Query 6: Number of cities per district
SELECT district, COUNT(district) AS number_of_cities
FROM cities
GROUP BY district
ORDER BY number_of_cities DESC;

-- Query 7: Population density classification using CASE
SELECT name, population_density,
CASE
WHEN population_density < 100 THEN 'Low density'
WHEN population_density <= 200 THEN 'Medium density'
ELSE 'High density'
END AS density_category
FROM cities
ORDER BY population_density;

-- ============================================
-- 2. SPATIAL ANALYSIS (POSTGIS)
-- ============================================

-- PostGIS Query 1: Geodesic distance between two cities
SELECT a.name AS city_1,
b.name AS city_2,
ST_Distance(a.geom::geography,b.geom::geography) / 1000 AS distance_km
FROM cities a, cities b
WHERE a.name = 'ZAJEČAR' AND b.name = 'NIŠ';

-- PostGIS Query 2: Distance between the northernmost and southernmost cities
SELECT north.name AS northern_city,south.name AS southern_city,
ST_Distance(north.geom::geography,south.geom::geography) / 1000 AS distance_km
FROM (SELECT name, geom
FROM cities
ORDER BY ST_Y(geom) DESC
LIMIT 1) AS north,
(SELECT name, geom
FROM cities
ORDER BY ST_Y(geom) ASC
LIMIT 1) AS south;

-- PostGIS Query 3: Cities within 100 km of Belgrade
SELECT name,
ST_Distance(geom::geography,
(SELECT geom
FROM cities
WHERE name = 'BEOGRAD')::geography) / 1000 AS distance_km
FROM cities
WHERE ST_DWithin(geom::geography,
(SELECT geom
FROM cities
WHERE name = 'BEOGRAD')::geography,100000)
AND name <> 'BEOGRAD'
ORDER BY distance_km;

-- PostGIS Query 4: Generate a line between two cities
SELECT ST_MakeLine(a.geom, b.geom) AS route
FROM cities a, cities b
WHERE a.name = 'LOZNICA' AND b.name = 'JAGODINA';

-- PostGIS Query 5: Reproject coordinates to UTM Zone 34N
SELECT name,
ST_AsText(ST_Transform(geom, 32634)) AS coordinates_utm
FROM cities
ORDER BY name;

-- PostGIS Query 6: Check whether two city points intersect
SELECT a.name AS city_1, b.name AS city_2,
ST_Intersects(a.geom, b.geom) AS intersects
FROM cities a, cities b
WHERE a.name = 'PROKUPLJE' AND b.name = 'PIROT';

-- PostGIS Query 7: Find the nearest city to Novi Sad
SELECT name,
ST_Distance(geom::geography,
(SELECT geom
FROM cities
WHERE name = 'NOVI SAD')::geography) / 1000 AS distance_km
FROM cities
WHERE name <> 'NOVI SAD'
ORDER BY distance_km
LIMIT 1;

-- PostGIS Query 8: Order cities from west to east
SELECT name,
ST_X(geom) AS longitude, ST_Y(geom) AS latitude
FROM cities
ORDER BY longitude;