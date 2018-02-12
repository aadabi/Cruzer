DROP SCHEMA sampletestschm CASCADE;
CREATE SCHEMA sampletestschm;
ALTER ROLE nick SET SEARCH_PATH to sampletestschm;

-- json object of users
-- jsonb is faster to parse than json
CREATE TABLE IF NOT EXISTS users (
    data jsonb
);
