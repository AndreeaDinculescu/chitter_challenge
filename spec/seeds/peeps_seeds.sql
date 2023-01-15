CREATE TABLE peeps (
    id SERIAL PRIMARY KEY,
    message text,
    time timestamp,
    user_id text
);

TRUNCATE TABLE peeps RESTART IDENTITY CASCADE;
INSERT INTO peeps (message, time, user_id) VALUES ('Welcome to Chitter!', '2022-01-13 17:19:23', '1');
INSERT INTO peeps (message, time, user_id) VALUES ('This is my first comment', '2020-07-09 14:04:45', '2');
