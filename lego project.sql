CREATE SCHEMA TIL_PORTFOLIO_PROJECTS.SCHEMA_LYON_ABIDO; // Creates a schema, lyon_abido, which will contain all of my tables for this Lego project

--SHOW tables IN til_portfolio_projects.staging; // Returns a list of tables in the staging schema from the til_portfolio_projects database

--DESCRIBE TABLE lego_colors; // Returns the metadata for the lego_colors table from the staging schema
--DESCRIBE TABLE lego_inventories;
--DESCRIBE TABLE lego_inventory_parts;
--DESCRIBE TABLE lego_inventory_sets;
--DESCRIBE TABLE lego_parts;
--DESCRIBE TABLE lego_part_categories;
--DESCRIBE TABLE lego_sets;
--DESCRIBE TABLE lego_themes;

CREATE TABLE til_portfolio_projects.schema_lyon_abido.colors 
(
    id NUMBER, 
    name VARCHAR(255), 
    rgb VARCHAR(255),
    is_trans VARCHAR(255)
); // -- Creates an empty table

INSERT INTO schema_lyon_abido.colors 
(
    SELECT *
    FROM staging.LEGO_COLORS
); // -- Populates an empty table using data from an existing table

----------------------------------------------------------------------

CREATE TABLE til_portfolio_projects.schema_lyon_abido.inventories
(
    id NUMBER, 
    version VARCHAR(255), 
    set_num VARCHAR(255)
); 

INSERT INTO schema_lyon_abido.inventories 
(
    SELECT *
    FROM staging.LEGO_INVENTORIES
); 

----------------------------------------------------------------------

CREATE TABLE til_portfolio_projects.schema_lyon_abido.inventory_parts
(
    inventory_id NUMBER, 
    part_num VARCHAR(255), 
    color_id NUMBER,
    quantity NUMBER,
    is_spare VARCHAR(255)
); 

INSERT INTO schema_lyon_abido.inventory_parts 
(
    SELECT *
    FROM staging.LEGO_INVENTORY_PARTS
); 

----------------------------------------------------------------------

CREATE TABLE til_portfolio_projects.schema_lyon_abido.inventory_sets
(
    inventory_id NUMBER, 
    set_num VARCHAR(255),
    quantity NUMBER
); 

INSERT INTO schema_lyon_abido.inventory_sets
(
    SELECT *
    FROM staging.LEGO_INVENTORY_SETS
); 

----------------------------------------------------------------------

CREATE TABLE til_portfolio_projects.schema_lyon_abido.parts
(
    part_num VARCHAR(255), 
    name VARCHAR(255), 
    part_cat_id NUMBER
); 

INSERT INTO schema_lyon_abido.parts 
(
    SELECT *
    FROM staging.LEGO_PARTS
); 

----------------------------------------------------------------------

CREATE TABLE til_portfolio_projects.schema_lyon_abido.part_categories
(
    id NUMBER, 
    name VARCHAR(255)
); 

INSERT INTO schema_lyon_abido.part_categories
(
    SELECT *
    FROM staging.LEGO_PART_CATEGORIES
); 

----------------------------------------------------------------------

CREATE TABLE til_portfolio_projects.schema_lyon_abido.sets
(
    set_num VARCHAR(255),
    name VARCHAR(255),
    year NUMBER,
    theme_id NUMBER,
    num_parts NUMBER
); 

INSERT INTO schema_lyon_abido.sets
(
    SELECT *
    FROM staging.LEGO_SETS
); 

----------------------------------------------------------------------

CREATE TABLE til_portfolio_projects.schema_lyon_abido.themes
(
    id NUMBER, 
    name VARCHAR(255),
    parent_id NUMBER
); 

INSERT INTO schema_lyon_abido.themes
(
    SELECT *
    FROM staging.LEGO_THEMES
);

----------------------------------------------------------------------

--DESCRIBE SCHEMA lyon_abido;
--SHOW TABLES IN lyon_abido;

ALTER TABLE schema_lyon_abido.colors ADD PRIMARY KEY (id); // -- Sets the id field in the colors table to be a primary key

ALTER TABLE schema_lyon_abido.inventories ADD PRIMARY KEY (id); 

ALTER TABLE schema_lyon_abido.parts ADD PRIMARY KEY (part_num);

ALTER TABLE schema_lyon_abido.part_categories ADD PRIMARY KEY (id);

ALTER TABLE schema_lyon_abido.sets ADD PRIMARY KEY (set_num);

ALTER TABLE schema_lyon_abido.themes ADD PRIMARY KEY (id);

----------------------------------------------------------------------

ALTER TABLE schema_lyon_abido.inventory_sets ADD FOREIGN KEY (set_num) REFERENCES schema_lyon_abido.sets(set_num);

ALTER TABLE schema_lyon_abido.inventory_sets ADD FOREIGN KEY (inventory_id) REFERENCES schema_lyon_abido.inventories(id);

ALTER TABLE schema_lyon_abido.inventory_parts ADD FOREIGN KEY (inventory_id) REFERENCES schema_lyon_abido.inventories(id);

ALTER TABLE schema_lyon_abido.inventory_parts ADD FOREIGN KEY (part_num) REFERENCES schema_lyon_abido.parts(part_num);

ALTER TABLE schema_lyon_abido.inventory_parts ADD FOREIGN KEY (color_id) REFERENCES schema_lyon_abido.colors(id);

ALTER TABLE schema_lyon_abido.parts ADD FOREIGN KEY (part_cat_id) REFERENCES schema_lyon_abido.part_categories(id);

ALTER TABLE schema_lyon_abido.sets ADD FOREIGN KEY (theme_id) REFERENCES schema_lyon_abido.themes(id);

ALTER TABLE schema_lyon_abido.inventories ADD FOREIGN KEY (set_num) REFERENCES schema_lyon_abido.sets(set_num);




