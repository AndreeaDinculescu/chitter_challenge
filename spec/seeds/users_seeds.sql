CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name text,
    email_address text,
    username text,
    password text
);

TRUNCATE TABLE users RESTART IDENTITY CASCADE;

INSERT INTO users (name, email_address, username, password) VALUES ('Andreea', 'andreea@mail.com', 'andre', 'ABC123def$');
INSERT INTO users (name, email_address, username, password) VALUES ('Adrian', 'adrian@mail.com', 'adi', '$fed321CBA');
