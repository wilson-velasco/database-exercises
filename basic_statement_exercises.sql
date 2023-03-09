-- Question 1
USE albums_db;

-- Question 2
SHOW CREATE TABLE albums;
/* PRIMARY KEY is the 'id' column based on the below:
CREATE TABLE `albums` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `artist` varchar(240) DEFAULT NULL,
  `name` varchar(240) NOT NULL,
  `release_date` int DEFAULT NULL,
  `sales` float DEFAULT NULL,
  `genre` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1
*/

-- Question 3
SELECT name FROM albums;
/* 'name' is the name of the album itself, not a person */

-- Question 4
SELECT sales FROM albums;
/* 'sales' is probably the amount made in sales in millions of dollars */
-- I was wrong. It was sales of records in millions of records

-- Question 5
SELECT name FROM albums WHERE artist = 'Pink Floyd';
/* The Dark Side of the Moon and The Wall */

-- Question 6
SELECT release_date FROM albums WHERE name LIKE '%Sgt%';
/* 1967 */


-- Question 7
SELECT genre FROM albums WHERE name = 'Nevermind';
/* Grunge, Alternative Rock */

-- Question 8
SELECT name, release_date FROM albums WHERE release_date BETWEEN 1990 AND 1999;
/* 
The Bodyguard
Jagged Little Pill
Come On Over
Falling Into You
Let's Talk About Love
Dangerous
The Immaculate Collection
Titanic: Music From the Motion Picture
Metallica
Nevermind
Supernatural
*/

-- Question 9
SELECT name, sales FROM albums WHERE sales < 20;
/*
Grease: The Original Soundtrack from the Motion Picture
Bad
Sgt. Pepper's Lonely Hearts Club Band
Dirty Dancing
Let's Talk About Love
Dangerous
The Immaculate Collection
Abbey Road
Born in the U.S.A.
Brothers in Arms
Titanic: Music from the Motion Picture
Nevermind
The Wall
*/

SELECT * FROM albums;