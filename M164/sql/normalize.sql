-- psql -h aws-0-eu-central-2.pooler.supabase.com -U postgres.vceberzqpcutgbhcwvaq -p 6543 -d postgres -f ./normalize.sql

\c smartphones

DROP TABLE IF EXISTS brand, model, selling_platform, processor CASCADE;

-- brand
CREATE TABLE brand (
    brand_id	SERIAL PRIMARY KEY,
    brand		VARCHAR(50) UNIQUE
);

INSERT INTO brand(brand)
SELECT DISTINCT brand FROM smartphones;

ALTER TABLE smartphones ADD COLUMN fk_brand_id INT REFERENCES brand(brand_id);

UPDATE smartphones s
SET fk_brand_id = brand_id
    FROM brand b WHERE b.brand = s.brand;

ALTER TABLE smartphones DROP COLUMN brand;

SELECT brand, model, selling_platform, price_usd, rating FROM smartphones s
    JOIN brand b ON b.brand_id = s.fk_brand_id LIMIT 10;


-- model
CREATE TABLE model (
    model_id	SERIAL PRIMARY KEY,
    model		VARCHAR(50) UNIQUE
);

INSERT INTO model(model)
SELECT DISTINCT model FROM smartphones;

ALTER TABLE smartphones ADD COLUMN fk_model_id INT REFERENCES model(model_id);

UPDATE smartphones s
SET fk_model_id = model_id
    FROM model m WHERE m.model = s.model;

ALTER TABLE smartphones DROP COLUMN model;

SELECT brand, model, selling_platform, price_usd, rating FROM smartphones s
    JOIN brand b ON b.brand_id = s.fk_brand_id
    JOIN model m ON m.model_id = s.fk_model_id
LIMIT 10;

-- selling platform
CREATE TABLE selling_platform (
    selling_platform_id	SERIAL PRIMARY KEY,
    selling_platform	VARCHAR(50) UNIQUE
);

INSERT INTO selling_platform (selling_platform)
SELECT DISTINCT selling_platform FROM smartphones;

ALTER TABLE smartphones ADD COLUMN fk_selling_platform_id INT REFERENCES selling_platform(selling_platform_id);

UPDATE smartphones s
SET fk_selling_platform_id = selling_platform_id
    FROM selling_platform sp WHERE sp.selling_platform = s.selling_platform;

ALTER TABLE smartphones DROP COLUMN selling_platform;

SELECT brand, model, selling_platform, price_usd, rating FROM smartphones s
    JOIN brand b ON b.brand_id = s.fk_brand_id
    JOIN model m ON m.model_id = s.fk_model_id
    JOIN selling_platform sp ON sp.selling_platform_id = s.fk_selling_platform_id LIMIT 10;
--processor

CREATE TABLE processor (
    processor_id	SERIAL PRIMARY KEY,
    processor		VARCHAR(50) UNIQUE
);

INSERT INTO processor(processor)
SELECT DISTINCT processor FROM smartphones;

ALTER TABLE smartphones ADD COLUMN fk_processor_id INT REFERENCES processor(processor_id);

UPDATE smartphones s
SET fk_processor_id = processor_id
    FROM processor p WHERE p.processor = s.processor;

ALTER TABLE smartphones DROP COLUMN processor;

SELECT brand, model, selling_platform, price_usd, rating FROM smartphones s
    JOIN brand b ON b.brand_id = s.fk_brand_id
    JOIN model m ON m.model_id = s.fk_model_id
    JOIN selling_platform sp ON sp.selling_platform_id = s.fk_selling_platform_id
    JOIN processor p ON p.processor_id = s.fk_processor_id LIMIT 10;