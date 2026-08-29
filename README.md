# Serbian Cities GIS & Spatial Analysis Database

A spatial database project analyzing major cities in the Republic of Serbia, their demographics, geographical features, and administrative divisions. Built using **PostgreSQL** with the **PostGIS** extension for spatial data management and spatial queries, modeled with **pgModeler**, and visualized using **QGIS**.

---

## 📌 Project Overview

This project stores, manages, and analyzes demographic and geographical data for cities across Serbia. By integrating spatial point features (`geometry(Point, 4326)`) with demographic attributes, the database allows for complex spatial calculations, proximity analysis, spatial transformations, and geographic data classification.

### Features & Key Capabilities:
- Demographic analysis (population counts, area, density metrics).
- Administrative grouping by Serbian districts (`district`).
- Spatial computations using **PostGIS** (geodesic distance calculations, proximity filtering, line creation between city points, spatial coordinate transformation).
- GIS data visualization and cartographic output generated using **QGIS**.

---

## 🛠️ Tech Stack & Tools

- **Database Management System:** PostgreSQL
- **Spatial Extension:** PostGIS
- **Data Modeling / ERD Design:** pgModeler (v1.2.3)
- **GIS Visualization & Mapping:** QGIS
- **Primary Spatial Reference System (SRID):** `EPSG:4326` (WGS 84 - Longitude/Latitude)
- **Target Projection SRID:** `EPSG:32634` (UTM Zone 34N)

---

## 🗄️ Database Schema & Data Structure

### Database Name: `Serbia_cities`
### Table: `public.cities`

| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | `text` | `PRIMARY KEY`, `NOT NULL` | Unique identifier for each city |
| `name` | `text` | — | City name (e.g., 'BEOGRAD', 'NIŠ', 'NOVI SAD') |
| `area_km2` | `numeric` | — | Total area of the municipality/city in km² |
| `population` | `integer` | `NOT NULL` | Total population count |
| `population_density` | `numeric` | — | Population density (people per km²) |
| `district` | `text` | — | Administrative district name |
| `geom` | `geometry(Point, 4326)` | `NOT NULL` | Spatial point location (WGS 84) |

---

## 📊 SQL Queries & Spatial Analysis

The project contains two main sets of SQL queries: standard relational analytical queries and advanced spatial PostGIS queries.

The project includes **15 SQL queries** covering both standard relational analysis and spatial analysis using PostGIS.

### Attribute & Demographic Analysis
The first 7 queries cover:
- Population analysis
- Population density
- City area
- Average population
- Subqueries
- District grouping
- Data classification using `CASE`

### Spatial Analysis (PostGIS)
The remaining 8 queries demonstrate:
- Geodesic distance calculations
- Northernmost and southernmost city analysis
- Proximity analysis using `ST_DWithin`
- Line creation using `ST_MakeLine`
- Coordinate transformation using `ST_Transform`
- Spatial intersection using `ST_Intersects`
- Nearest-city analysis
- Longitude-based spatial ordering

The complete collection of SQL queries is available in **[`queries.sql`](queries.sql)**.

---

## 🗺️ Visualizations & Cartography
Visualization and spatial rendering were carried out in QGIS.

The generated thematic map displays:

- **City symbols:** Point markers sized according to population.
- **Administrative Context:** Boundary layer of the Republic of Serbia sourced from GeoSrbija.
- **Cartographic Elements:** Legend, Scale Bar, North Arrow, and Author Metadata.

The QGIS project file (`serbia_cities.qgz`) is included in the repository and contains the configured layers and cartographic layout used to produce the final map.

---

## 🚀 How to Run / Setup

### Prerequisites

- Install PostgreSQL and activate the PostGIS extension.
- Install QGIS for visualizing the database layers.

### Database Setup

```sql
CREATE DATABASE "Serbia_cities";
\c Serbia_cities
CREATE EXTENSION postgis;
```
Schema Creation & Data Import:

Execute the table creation script or model layout from cities_srb.dbm / pgModeler.

Load dataset records into the cities table (using cities_data.csv).

Connect QGIS:

Open QGIS -> Add Layer -> Add PostGIS Layers.

Enter your PostgreSQL connection settings and add the cities geometry table to the canvas.

### 👨‍💻 Author

Nikola Mađarević
