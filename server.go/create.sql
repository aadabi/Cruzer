DROP SCHEMA test1schema CASCADE;
CREATE SCHEMA test1schema;
ALTER ROLE nick SET SEARCH_PATH to test1schema;

-- json object of users
CREATE TABLE users (
    data jsonb
);
