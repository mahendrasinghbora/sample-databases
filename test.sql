CREATE DATABASE test;

USE test;

CREATE TABLE IF NOT EXISTS salesman
(
    salesman_id   DECIMAL(4, 0) PRIMARY KEY,
    salesman_name VARCHAR(50) NOT NULL,
    city          VARCHAR(20),
    commission    DECIMAL(3, 2)
);

DESCRIBE salesman;

INSERT INTO salesman
VALUES (5001, 'Jame Hoog', 'New York', 0.15),
       (5002, 'Nail Knite', 'Paris', 0.13),
       (5005, 'Pit Alex', 'London', 0.11),
       (5006, 'Mc Lyon', 'Paris', 0.14),
       (5007, 'Paul Adam', 'Rome', 0.13),
       (5003, 'Lauson Hen', 'San Jose', 0.12);

SELECT *
FROM salesman;

CREATE TABLE IF NOT EXISTS customer
(
    customer_id   DECIMAL(4, 0) PRIMARY KEY,
    customer_name VARCHAR(50)   NOT NULL,
    city          VARCHAR(20),
    grade         DECIMAL(3, 0),
    salesman_id   DECIMAL(4, 0) NOT NULL,
    FOREIGN KEY (salesman_id) REFERENCES salesman (salesman_id)
);

DESCRIBE customer;

INSERT INTO customer
VALUES (3002, 'Nick Rimando', 'New York', 100, 5001),
       (3007, 'Brad Davis', 'New York', 200, 5001),
       (3005, 'Graham Zusi', 'California', 200, 5002),
       (3008, 'Julian Green', 'London', 300, 5002),
       (3004, 'Fabian Johnson', 'Paris', 300, 5006),
       (3009, 'Geoff Cameron', 'Berlin', 100, 5003),
       (3003, 'Jozv Altidor', 'Moscow', 200, 5007);

SELECT *
FROM customer;

CREATE TABLE IF NOT EXISTS customer_order
(
    order_number    DECIMAL(5, 0) PRIMARY KEY,
    purchase_amount DECIMAL(10, 2),
    order_date      DATE,
    customer_id     DECIMAL(4, 0) NOT NULL,
    salesman_id     DECIMAL(4, 0) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman (salesman_id)
);

DESCRIBE customer_order;

INSERT INTO customer_order
VALUES (70001, 150.5, '2012-10-05', 3005, 5002),
       (70009, 270.65, '2012-09-10', 3008, 5005),
       (70002, 65.26, '2012-10-05', 3002, 5001),
       (70004, 110.5, '2012-08-17', 3009, 5003),
       (70007, 948.5, '2012-09-10', 3005, 5002),
       (70005, 2400.6, '2012-07-27', 3007, 5001),
       (70008, 5760, '2012-09-10', 3002, 5001);

SELECT *
FROM customer_order;

SELECT *
FROM customer
WHERE customer_id IN (3007, 3008, 3009);

SELECT *
FROM salesman
WHERE commission BETWEEN 0.12 AND 0.14;

SELECT *
FROM customer_order
WHERE (purchase_amount BETWEEN 500 AND 4000)
  AND purchase_amount NOT IN (948.50, 1983.43);

SELECT *
FROM salesman
WHERE salesman_name BETWEEN 'A' AND 'K';

SELECT *
FROM customer
WHERE customer_name LIKE '%N';

SELECT *
FROM salesman
WHERE salesman_name LIKE 'N__L%';

SELECT *
FROM scratch.employee
WHERE last_name LIKE 'D%';

SELECT salesman_name, customer_name, salesman.city
FROM salesman,
     customer
WHERE salesman.city = customer.city;

SELECT order_number, purchase_amount, customer_name, city
FROM customer_order,
     customer
WHERE customer.customer_id = customer_order.customer_id
  AND purchase_amount BETWEEN 500 AND 2000;

SELECT customer_name, salesman_name
FROM customer,
     salesman
WHERE customer.salesman_id = salesman.salesman_id;

SELECT customer_name
FROM customer
WHERE salesman_id IN (SELECT salesman_id FROM salesman WHERE commission > 0.12);

SELECT customer_name
FROM customer,
     salesman
WHERE customer.salesman_id = salesman.salesman_id
  AND salesman.commission > 0.12
  AND customer.city <> salesman.city;

SELECT order_number, order_date, purchase_amount, customer_name, salesman_name, commission
FROM customer_order,
     customer,
     salesman
WHERE customer_order.customer_id = customer.customer_id
  AND customer.salesman_id = salesman.salesman_id;

SELECT customer_name, salesman_name
FROM customer
         LEFT JOIN salesman ON salesman.salesman_id = customer.salesman_id
ORDER BY customer_id;

SELECT customer_name, grade, salesman_name
FROM customer
         LEFT JOIN salesman ON salesman.salesman_id = customer.salesman_id
WHERE grade < 300
ORDER BY customer_id;

SELECT salesman_name, customer_name
FROM salesman
         LEFT JOIN customer ON salesman.salesman_id = customer.salesman_id
ORDER BY salesman.salesman_id;

CREATE TABLE IF NOT EXISTS actor
(
    actor_id   DECIMAL(3, 0) PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name  VARCHAR(20),
    gender     CHAR
);

DESCRIBE actor;

INSERT INTO actor
VALUES (101, 'James', 'Stewart', 'M'),
       (102, 'Deborah', 'Kerr', 'F'),
       (103, 'Peter', 'OToole', 'M'),
       (104, 'Robert', 'De Niro', 'M'),
       (105, 'F.Murray', 'Abraham', 'M'),
       (106, 'Harrison', 'Ford', 'M'),
       (107, 'Nicole', 'Kidman', 'F'),
       (108, 'Stephen', 'Baldwin', 'M'),
       (109, 'Jack', 'Nicholson', 'M'),
       (110, 'Mark', 'Wahlberg', 'M'),
       (111, 'Woody', 'Allen', 'M'),
       (112, 'Claire', 'Danes', 'F'),
       (113, 'Tim', 'Robbins', 'M'),
       (114, 'Kevin', 'Spacey', 'M'),
       (115, 'Kate', 'Winslet', 'F'),
       (116, 'Robin', 'Williams', 'M'),
       (117, 'Jon', 'Voight', 'M'),
       (118, 'Ewan', 'McGregor', 'M'),
       (119, 'Christian', 'Bale', 'M'),
       (120, 'Maggie', 'Gyllenhaal', 'F'),
       (121, 'Dev', 'Patel', 'M'),
       (122, 'Sigourney', 'Weaver', 'F'),
       (123, 'David', 'Aston', 'M'),
       (124, 'Ali', 'Astin', 'F');

SELECT *
FROM actor;

CREATE TABLE IF NOT EXISTS movie
(
    movie_id           DECIMAL(3, 0) PRIMARY KEY,
    movie_title        VARCHAR(50) NOT NULL,
    movie_year         DECIMAL(4, 0),
    movie_time         DECIMAL(3, 0),
    language           VARCHAR(20),
    release_date       DATE,
    country_of_release VARCHAR(5)
);

DESCRIBE movie;

INSERT INTO movie
VALUES (901, 'Vertigo', 1958, 128, 'English', '1958-08-24', 'UK'),
       (902, 'The Innocents', 1961, 100, 'English', '1962-02-19', 'SW'),
       (903, 'Lawrence of Arabia', 1962, 216, 'English', '1962-12-11', 'UK'),
       (904, 'The Deer Hunter', 1978, 183, 'English', '1979-03-08', 'UK'),
       (905, 'Amadeus', 1984, 160, 'English', '1985-01-07', 'UK'),
       (906, 'Blade Runner', 1982, 117, 'English', '1982-09-09', 'UK'),
       (907, 'Eyes Wide Shut', 1999, 159, 'English', NULL, 'UK'),
       (908, 'The Usual Suspects', 1995, 106, 'English', '1995-08-25', 'UK'),
       (909, 'Chinatown', 1974, 130, 'English', '1974-08-09', 'UK'),
       (910, 'Boogie Nights', 1997, 155, 'English', '1998-02-16', 'UK'),
       (911, 'Annie Hall', 1977, 93, 'English', '1977-04-20', 'USA'),
       (912, 'Princess Mononoke', 1997, 134, 'Japanese', '2001-10-19', 'UK'),
       (913, 'The Shawshank Redemption', 1994, 142, 'English', '1995-02-17', 'UK'),
       (914, 'American Beauty', 1999, 122, 'English', NULL, 'UK'),
       (915, 'Titanic', 1997, 194, 'English', '1998-01-23', 'UK'),
       (916, 'Good Will Hunting', 1997, 126, 'English', '1998-06-03', 'UK'),
       (917, 'Deliverance', 1972, 109, 'English', '1982-10-05', 'UK'),
       (918, 'Trainspotting', 1996, 94, 'English', '1996-02-23', 'UK'),
       (919, 'The Prestige', 2006, 130, 'English', '2006-11-10', 'UK'),
       (920, 'Donnie Darko', 2001, 113, 'English', NULL, 'UK'),
       (921, 'Slumdog Millionaire', 2008, 120, 'English', '2009-01-09', 'UK'),
       (922, 'Aliens', 1986, 137, 'English', '1986-08-29', 'UK'),
       (923, 'Beyond the Sea', 2004, 118, 'English', '2004-11-26', 'UK'),
       (924, 'Avatar', 2009, 162, 'English', '2009-12-17', 'UK'),
       (926, 'Seven Samurai', 1954, 207, 'Japanese', '1954-04-26', 'JP'),
       (927, 'Spirited Away', 2001, 125, 'Japanese', '2003-09-12', 'UK'),
       (928, 'Back to the Future', 1985, 116, 'English', '1985-12-04', 'UK'),
       (925, 'Braveheart', 1995, 178, 'English', '1995-09-08', 'UK');

SELECT *
FROM movie;

CREATE TABLE IF NOT EXISTS movie_cast
(
    actor_id DECIMAL(3, 0) NOT NULL,
    movie_id DECIMAL(3, 0) NOT NULL,
    role     VARCHAR(30),
    FOREIGN KEY (actor_id) REFERENCES actor (actor_id),
    FOREIGN KEY (movie_id) REFERENCES movie (movie_id)
);

DESCRIBE movie_cast;

INSERT INTO movie_cast
VALUES (101, 901, 'John Scottie Ferguson'),
       (102, 902, 'Miss Giddens'),
       (103, 903, 'T.E. Lawrence'),
       (104, 904, 'Michael'),
       (105, 905, 'Antonio Salieri'),
       (106, 906, 'Rick Deckard'),
       (107, 907, 'Alice Harford'),
       (108, 908, 'McManus'),
       (110, 910, 'Eddie Adams'),
       (111, 911, 'Alvy Singer'),
       (112, 912, 'San'),
       (113, 913, 'Andy Dufresne'),
       (114, 914, 'Lester Burnham'),
       (115, 915, 'Rose DeWitt Bukater'),
       (116, 916, 'Sean Maguire'),
       (117, 917, 'Ed'),
       (118, 918, 'Renton'),
       (120, 920, 'Elizabeth Darko'),
       (121, 921, 'Older Jamal'),
       (122, 922, 'Ripley'),
       (114, 923, 'Bobby Darin'),
       (109, 909, 'J.J. Gittes'),
       (119, 919, 'Alfred Borden');

SELECT *
FROM movie_cast;

CREATE TABLE IF NOT EXISTS director
(
    director_id DECIMAL(3, 0) PRIMARY KEY,
    first_name  VARCHAR(20) NOT NULL,
    last_name   VARCHAR(20)
);

DESCRIBE director;

INSERT INTO director
VALUES (201, 'Alfred', 'Hitchcock'),
       (202, 'Jack', 'Clayton'),
       (203, 'David', 'Lean'),
       (204, 'Michael', 'Cimino'),
       (205, 'Milos', 'Forman'),
       (206, 'Ridley', 'Scott'),
       (207, 'Stanley', 'Kubrick'),
       (208, 'Bryan', 'Singer'),
       (209, 'Roman', 'Polanski'),
       (210, 'Paul', 'Thomas Anderson'),
       (211, 'Woody', 'Allen'),
       (212, 'Hayao', 'Miyazaki'),
       (213, 'Frank', 'Darabont'),
       (214, 'Sam', 'Mendes'),
       (215, 'James', 'Cameron'),
       (216, 'Gus', 'Van Sant'),
       (217, 'John', 'Boorman'),
       (218, 'Danny', 'Boyle'),
       (219, 'Christopher', 'Nolan'),
       (220, 'Richard', 'Kelly'),
       (221, 'Kevin', 'Spacey'),
       (222, 'Andrei', 'Tarkovsky'),
       (223, 'Peter', 'Jackson');

SELECT *
FROM director;

CREATE TABLE IF NOT EXISTS movie_direction
(
    director_id DECIMAL(3, 0) NOT NULL,
    movie_id    DECIMAL(3, 0) NOT NULL,
    FOREIGN KEY (director_id) REFERENCES director (director_id),
    FOREIGN KEY (movie_id) REFERENCES movie (movie_id)
);

DESCRIBE movie_direction;

INSERT INTO movie_direction
VALUES (201, 901),
       (202, 902),
       (203, 903),
       (204, 904),
       (205, 905),
       (206, 906),
       (207, 907),
       (208, 908),
       (209, 909),
       (210, 910),
       (211, 911),
       (212, 912),
       (213, 913),
       (214, 914),
       (215, 915),
       (216, 916),
       (217, 917),
       (218, 918),
       (219, 919),
       (220, 920),
       (218, 921),
       (215, 922),
       (221, 923);

SELECT *
FROM movie_direction;

CREATE TABLE IF NOT EXISTS reviewer
(
    reviewer_id   DECIMAL(4, 0) PRIMARY KEY,
    reviewer_name VARCHAR(40)
);

DESCRIBE reviewer;

INSERT INTO reviewer
VALUES (9001, 'Righty Sock'),
       (9002, 'Jack Malvern'),
       (9003, 'Flagrant Baronessa'),
       (9004, 'Alec Shaw'),
       (9005, ''),
       (9006, 'Victor Woeltjen'),
       (9007, 'Simon Wright'),
       (9008, 'Neal Wruck'),
       (9009, 'Paul Monks'),
       (9010, 'Mike Salvati'),
       (9011, ''),
       (9012, 'Wesley S. Walker'),
       (9013, 'Sasha Goldshtein'),
       (9014, 'Josh Cates'),
       (9015, 'Krug Stillo'),
       (9016, 'Scott LeBrun'),
       (9017, 'Hannah Steele'),
       (9018, 'Vincent Cadena'),
       (9019, 'Brandt Sponseller'),
       (9020, 'Richard Adams');


SELECT *
FROM reviewer;

CREATE TABLE IF NOT EXISTS rating
(
    movie_id          DECIMAL(3, 0) NOT NULL,
    reviewer_id       DECIMAL(4, 0) NOT NULL,
    stars             DECIMAL(4, 2),
    number_of_ratings DECIMAL(10, 0),
    FOREIGN KEY (movie_id) REFERENCES movie (movie_id),
    FOREIGN KEY (reviewer_id) REFERENCES reviewer (reviewer_id)
);

DESCRIBE rating;

INSERT INTO rating
VALUES (901, 9001, 8.40, 263575),
       (902, 9002, 7.90, 20207),
       (903, 9003, 8.30, 202778),
       (906, 9005, 8.20, 484746),
       (924, 9006, 7.30, NULL),
       (908, 9007, 8.60, 779489),
       (909, 9008, NULL, 227235),
       (910, 9009, 3.00, 195961),
       (911, 9010, 8.10, 203875),
       (912, 9011, 8.40, NULL),
       (914, 9013, 7.00, 862618),
       (915, 9001, 7.70, 830095),
       (916, 9014, 4.00, 642132),
       (925, 9015, 7.70, 81328),
       (918, 9016, NULL, 580301),
       (920, 9017, 8.10, 609451),
       (921, 9018, 8.00, 667758),
       (922, 9019, 8.40, 511613),
       (923, 9020, 6.70, 13091);

SELECT *
FROM rating;

SELECT actor.actor_id, first_name, last_name, gender
FROM actor
WHERE actor.actor_id IN (SELECT actor_id
                         FROM movie_cast
                         WHERE movie_id = (SELECT movie.movie_id FROM movie WHERE movie_title = 'Annie Hall'));

SELECT *
FROM movie
WHERE country_of_release <> 'UK';


SELECT movie_title
FROM movie
WHERE movie_id IN (SELECT movie_id
                   FROM movie_direction
                   WHERE director_id =
                         (SELECT director_id FROM director WHERE first_name = 'Woody' AND last_name = 'Allen'));

SELECT movie_title
FROM movie
WHERE movie_id NOT IN (SELECT movie_id FROM rating);

SELECT movie_title
FROM movie
WHERE movie_id NOT IN (SELECT movie_id FROM rating)
   OR movie_id IN (SELECT movie_id FROM rating WHERE stars IS NULL);

CREATE TABLE IF NOT EXISTS soccer_team
(
    team_id         DECIMAL(4, 0) PRIMARY KEY,
    team_group      CHAR NOT NULL,
    matches_played  DECIMAL(2, 0),
    won             DECIMAL(2, 0),
    draw            DECIMAL(2, 0),
    lost            DECIMAL(2, 0),
    goals_for       DECIMAL(3, 0),
    goals_against   DECIMAL(3, 0),
    goal_difference DECIMAL(3, 0),
    points          DECIMAL(3, 0),
    group_position  DECIMAL(2, 0)
);

DESCRIBE soccer_team;

INSERT INTO soccer_team
VALUES (1201, 'A', 3, 1, 0, 2, 1, 3, -2, 3, 3),
       (1202, 'F', 3, 0, 1, 2, 1, 4, -3, 1, 4),
       (1203, 'E', 3, 2, 0, 1, 4, 2, 2, 6, 2),
       (1204, 'D', 3, 2, 1, 0, 5, 3, 2, 7, 1),
       (1205, 'D', 3, 0, 1, 2, 2, 5, -3, 1, 4),
       (1206, 'B', 3, 1, 2, 0, 3, 2, 1, 5, 2),
       (1207, 'A', 3, 2, 1, 0, 4, 1, 3, 7, 1),
       (1208, 'C', 3, 2, 1, 0, 3, 0, 3, 7, 1),
       (1209, 'F', 3, 1, 2, 0, 6, 4, 2, 5, 1),
       (1210, 'F', 3, 1, 2, 0, 4, 3, 1, 5, 2),
       (1211, 'E', 3, 2, 0, 1, 3, 1, 2, 6, 1),
       (1212, 'C', 3, 1, 0, 2, 2, 2, 0, 3, 3),
       (1213, 'C', 3, 2, 1, 0, 2, 0, 2, 7, 2),
       (1214, 'F', 3, 0, 3, 0, 4, 4, 0, 3, 3),
       (1215, 'E', 3, 1, 1, 1, 2, 4, -2, 4, 3),
       (1216, 'A', 3, 0, 1, 2, 2, 4, -2, 1, 4),
       (1217, 'B', 3, 0, 1, 2, 2, 6, -4, 1, 4),
       (1218, 'B', 3, 1, 1, 1, 3, 3, 0, 4, 3),
       (1219, 'D', 3, 2, 0, 1, 5, 2, 3, 6, 2),
       (1220, 'E', 3, 0, 1, 2, 1, 3, -2, 1, 4),
       (1221, 'A', 3, 1, 2, 0, 2, 1, 1, 5, 2),
       (1222, 'D', 3, 1, 0, 2, 2, 4, -2, 3, 3),
       (1223, 'C', 3, 0, 0, 3, 0, 5, -5, 0, 4),
       (1224, 'B', 3, 2, 0, 1, 6, 3, 3, 6, 1);

SELECT *
FROM soccer_team;

CREATE TABLE IF NOT EXISTS player
(
    player_id     DECIMAL(6, 0) PRIMARY KEY,
    team_id       DECIMAL(4, 0) NOT NULL,
    jersey_number DECIMAL(3, 0),
    player_name   VARCHAR(50),
    position      VARCHAR(2),
    date_of_birth DATE,
    age           DECIMAL(3, 0),
    club          VARCHAR(20),
    FOREIGN KEY (team_id) REFERENCES soccer_team (team_id)
);

DESCRIBE player;

INSERT INTO player
VALUES (160001, 1201, 1, 'Etrit Berisha', 'GK', '1989-03-10', 27, 'Lazio'),
       (160008, 1201, 2, 'Andi Lila', 'DF', '1986-02-12', 30, 'Giannina'),
       (160016, 1201, 3, 'Ermir Lenjani', 'MF', '1989-08-05', 26, 'Nantes'),
       (160007, 1201, 4, 'Elseid Hysaj', 'DF', '1994-02-20', 22, 'Napoli'),
       (160013, 1201, 5, 'Lorik Cana', 'MF', '1983-07-27', 32, 'Nantes'),
       (160010, 1201, 6, 'Frederic Veseli', 'DF', '1992-11-20', 23, 'Lugano'),
       (160004, 1201, 7, 'Ansi Agolli', 'DF', '1982-10-11', 33, 'Qarabag'),
       (160012, 1201, 8, 'Migjen Basha', 'MF', '1987-01-05', 29, 'Como'),
       (160017, 1201, 9, 'Ledian Memushaj', 'MF', '1986-12-17', 29, 'Pescara'),
       (160023, 1201, 10, 'Armando Sadiku', 'FD', '1991-05-27', 25, 'Vaduz'),
       (160022, 1201, 11, 'Shkelzen Gashi', 'FD', '1988-07-15', 27, 'Colorado'),
       (160003, 1201, 12, 'Orges Shehi', 'GK', '1977-09-25', 38, 'Skenderbeu'),
       (160015, 1201, 13, 'Burim Kukeli', 'MF', '1984-01-16', 32, 'Zurich'),
       (160019, 1201, 14, 'Taulant Xhaka', 'MF', '1991-03-28', 25, 'Basel'),
       (160009, 1201, 15, 'Mergim Mavraj', 'DF', '1986-06-09', 30, 'Koln'),
       (160021, 1201, 16, 'Sokol Cikalleshi', 'FD', '1990-07-27', 25, 'Istanbul Basaksehir'),
       (160006, 1201, 17, 'Naser Aliji', 'DF', '1993-12-27', 22, 'Basel'),
       (160005, 1201, 18, 'Arlind Ajeti', 'DF', '1993-09-25', 22, 'Frosinone'),
       (160020, 1201, 19, 'Bekim Balaj', 'FD', '1991-01-11', 25, 'Rijeka'),
       (160014, 1201, 20, 'Ergys Kace', 'MF', '1993-07-08', 22, 'PAOK'),
       (160018, 1201, 21, 'Odise Roshi', 'MF', '1991-05-22', 25, 'Rijeka'),
       (160011, 1201, 22, 'Amir Abrashi', 'MF', '1990-03-27', 26, 'Freiburg'),
       (160002, 1201, 23, 'Alban Hoxha', 'GK', '1987-11-23', 28, 'Partizani'),
       (160024, 1202, 1, 'Robert Almer', 'GK', '1984-03-20', 32, 'Austria Wien'),
       (160036, 1202, 2, 'Gyorgy Garics', 'MF', '1984-03-08', 32, 'Darmstadt'),
       (160027, 1202, 3, 'Aleksandar Dragovic', 'DF', '1991-03-06', 25, 'Dynamo Kyiv'),
       (160029, 1202, 4, 'Martin Hinteregger', 'DF', '1992-09-07', 23, 'Monchengladbach'),
       (160028, 1202, 5, 'Christian Fuchs', 'DF', '1986-04-07', 30, 'Leicester'),
       (160038, 1202, 6, 'Stefan Ilsanker', 'MF', '1989-05-18', 27, 'Leipzig'),
       (160043, 1202, 7, 'Marko Arnautovic', 'FD', '1989-04-19', 27, 'Stoke');

SELECT *
FROM player;

CREATE TABLE IF NOT EXISTS soccer_country
(
    country_id           DECIMAL(4, 0) PRIMARY KEY,
    country_abbreviation VARCHAR(3),
    country_name         VARCHAR(20)
);

DESCRIBE soccer_country;

INSERT INTO soccer_country
VALUES (1201, 'ALB', 'Albania'),
       (1202, 'AUT', 'Austria'),
       (1203, 'BEL', 'Belgium'),
       (1204, 'CRO', 'Croatia'),
       (1205, 'CZE', 'Czech Republic'),
       (1206, 'ENG', 'England'),
       (1207, 'FRA', 'France'),
       (1208, 'GER', 'Germany'),
       (1209, 'HUN', 'Hungary'),
       (1210, 'ISL', 'Iceland'),
       (1211, 'ITA', 'Italy'),
       (1212, 'NIR', 'Northern Ireland'),
       (1213, 'POL', 'Poland'),
       (1214, 'POR', 'Portugal'),
       (1215, 'IRL', 'Republic of Ireland'),
       (1216, 'ROU', 'Romania'),
       (1217, 'RUS', 'Russia'),
       (1218, 'SVK', 'Slovakia'),
       (1219, 'ESP', 'Spain'),
       (1220, 'SWE', 'Sweden'),
       (1221, 'SUI', 'Switzerland'),
       (1222, 'TUR', 'Turkey'),
       (1223, 'UKR', 'Ukraine'),
       (1224, 'WAL', 'Wales'),
       (1225, 'SLO', 'Slovenia'),
       (1226, 'NED', 'Netherlands'),
       (1227, 'SRB', 'Serbia'),
       (1228, 'SCO', 'Scotland'),
       (1229, 'NOR', 'Norway');

SELECT *
FROM soccer_country;

CREATE TABLE IF NOT EXISTS assistant_referee
(
    assistant_referee_id   DECIMAL(5, 0) PRIMARY KEY,
    assistant_referee_name VARCHAR(50),
    country_id             DECIMAL(4, 0) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES soccer_country (country_id)
);

DESCRIBE assistant_referee;

INSERT INTO assistant_referee
VALUES (80034, 'Tomas Mokrusch', 1205),
       (80038, 'Martin Wilczek', 1205),
       (80004, 'Simon Beck', 1206),
       (80006, 'Stephen Child', 1206),
       (80007, 'Jake Collin', 1206),
       (80014, 'Mike Mullarkey', 1206),
       (80026, 'Frederic Cano', 1207),
       (80028, 'Nicolas Danos', 1207),
       (80005, 'Mark Borsch', 1208),
       (80013, 'Stefan Lupp', 1208),
       (80016, 'Gyorgy Ring', 1209),
       (80020, 'Vencel Toth', 1209),
       (80033, 'Damien McGraith', 1215),
       (80008, 'Elenito Di Liberatore', 1211),
       (80019, 'Mauro Tonolini', 1211),
       (80021, 'Sander van Roekel', 1226),
       (80024, 'Erwin Zeinstra', 1226),
       (80025, 'Frank Andas', 1229),
       (80031, 'Kim Haglund', 1229),
       (80012, 'Tomasz Listkiewicz', 1213),
       (80018, 'Pawel Sokolnicki', 1213),
       (80029, 'Sebastian Gheorghe', 1216),
       (80036, 'Octavian Sovre', 1216),
       (80030, 'Nikolay Golubev', 1217),
       (80032, 'Tikhon Kalugin', 1217),
       (80037, 'Anton Averyanov', 1217),
       (80027, 'Frank Connor', 1228),
       (80010, 'Dalibor Durdevic', 1227),
       (80017, 'Milovan Ristic', 1227),
       (80035, 'Roman Slysko', 1218),
       (80001, 'Jure Praprotnik', 1225),
       (80002, 'Robert Vukan', 1225),
       (80003, 'Roberto Alonso Fernandez', 1219),
       (80023, 'Juan Yuste Jimenez', 1219),
       (80011, 'Mathias Klasenius', 1220),
       (80022, 'Daniel Warnmark', 1220),
       (80009, 'Bahattin Duran', 1222),
       (80015, 'Tarik Ongun', 1222);

SELECT *
FROM assistant_referee;

CREATE TABLE IF NOT EXISTS match_details
(
    match_number         DECIMAL(2, 0),
    play_stage           CHARACTER,
    team_id              DECIMAL(4, 0) NOT NULL,
    result               CHARACTER,
    decided_by           CHARACTER,
    goals_scored         DECIMAL(2, 0),
    penalty_score        DECIMAL(2, 0),
    assistant_referee_id DECIMAL(5, 0) NOT NULL,
    goalkeeper_id        DECIMAL(6, 0) NOT NULL,
    FOREIGN KEY (assistant_referee_id) REFERENCES assistant_referee (assistant_referee_id),
    FOREIGN KEY (goalkeeper_id) REFERENCES player (player_id)
);

DESCRIBE match_details;

INSERT INTO match_details
VALUES (1, 'G', 1207, 'W', 'N', 2, NULL, 80016, 160024),
       (1, 'G', 1216, 'L', 'N', 1, NULL, 80020, 160001),
       (2, 'G', 1201, 'L', 'N', 0, NULL, 80003, 160002),
       (2, 'G', 1221, 'W', 'N', 1, NULL, 80023, 160003);

SELECT *
FROM match_details;

CREATE TABLE IF NOT EXISTS goal_details
(
    goal_id       DECIMAL(3, 0) PRIMARY KEY,
    match_number  DECIMAL(2, 0) NOT NULL,
    player_id     DECIMAL(6, 0) NOT NULL,
    team_id       DECIMAL(4, 0) NOT NULL,
    goal_time     DECIMAL(3, 0),
    goal_type     CHARACTER,
    play_stage    CHARACTER,
    goal_schedule VARCHAR(2),
    goal_half     DECIMAL(1, 0),
    FOREIGN KEY (player_id) REFERENCES player (player_id),
    FOREIGN KEY (team_id) REFERENCES soccer_team (team_id)
);

DESCRIBE goal_details;

INSERT INTO goal_details
VALUES (1, 1, 160020, 1207, 57, 'N', 'G', 'NT', 2),
       (2, 1, 160043, 1216, 65, 'P', 'G', 'NT', 2),
       (3, 1, 160020, 1207, 89, 'N', 'G', 'NT', 2),
       (4, 2, 160043, 1221, 5, 'N', 'G', 'NT', 1);

SELECT *
FROM goal_details;

SELECT match_number, country_name
FROM match_details,
     soccer_country
WHERE team_id = country_id
  AND match_number = 1;

SELECT match_number, country_name, player_name, COUNT(match_number)
FROM goal_details,
     soccer_country,
     player
WHERE goal_details.team_id = soccer_country.country_id
  AND goal_details.player_id = player.player_id
GROUP BY match_number, country_name, player_name
ORDER BY match_number;
