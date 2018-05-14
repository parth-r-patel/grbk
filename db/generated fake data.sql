#
# TABLE STRUCTURE FOR: courses
#

DROP TABLE IF EXISTS `courses`;

CREATE TABLE `courses` (
  `courseID` int(11) NOT NULL AUTO_INCREMENT,
  `courseCode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`courseID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `courses` (`courseID`, `courseCode`) VALUES (1, 'tdj3m1');
INSERT INTO `courses` (`courseID`, `courseCode`) VALUES (2, 'tdj4m1');
INSERT INTO `courses` (`courseID`, `courseCode`) VALUES (3, 'ics3u1');
INSERT INTO `courses` (`courseID`, `courseCode`) VALUES (4, 'ics4u1');


#
# TABLE STRUCTURE FOR: sections
#

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `sectionID` int(11) NOT NULL AUTO_INCREMENT,
  `courseID` int(11) DEFAULT NULL,
  `sectionNum` int(11) DEFAULT 1,
  PRIMARY KEY (`sectionID`),
  KEY `course2_idx` (`courseID`),
  CONSTRAINT `courseSection` FOREIGN KEY (`courseID`) REFERENCES `courses` (`courseID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `sections` (`sectionID`, `courseID`, `sectionNum`) VALUES (1, 1, 1);
INSERT INTO `sections` (`sectionID`, `courseID`, `sectionNum`) VALUES (2, 2, 1);
INSERT INTO `sections` (`sectionID`, `courseID`, `sectionNum`) VALUES (3, 3, 1);
INSERT INTO `sections` (`sectionID`, `courseID`, `sectionNum`) VALUES (4, 3, 2);
INSERT INTO `sections` (`sectionID`, `courseID`, `sectionNum`) VALUES (5, 4, 1);


#
# TABLE STRUCTURE FOR: categories
#

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `categoryID` int(11) NOT NULL AUTO_INCREMENT,
  `sectionID` int(11) DEFAULT NULL,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weight` double DEFAULT 0.0,
  `isPercentile` bit(1) DEFAULT 1,
  PRIMARY KEY (`categoryID`),
  KEY `categorySetsion_idx` (`sectionID`),
  CONSTRAINT `categorySetsion` FOREIGN KEY (`sectionID`) REFERENCES `sections` (`sectionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (1, 3, 'assignments and tests', 50, 1);
INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (2, 3, 'final project', 20, 1);
INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (3, 3, 'final exam', 30, 1);

INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (4, 4, 'assignments and tests', 40, 0);
INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (5, 4, 'final project', 30, 1);
INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (6, 4, 'final exam', 30, 1);

INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (7, 5, 'assignments and tests', 40, 1);
INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (8, 5, 'quizzes', 10, 1);
INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (9, 5, 'final project', 20, 1);
INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (10, 5, 'final exam', 30, 1);

INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (11, 1, 'formative work', 0, 1);
INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (12, 1, 'term work', 70, 1);
INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (13, 1, 'final summative challenge', 30, 1);

INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (14, 2, 'term work', 70, 0);
INSERT INTO `categories` (`categoryID`, `sectionID`, `name`, `weight`, `isPercentile`) VALUES (15, 2, 'final summative', 30, 1);



#
# TABLE STRUCTURE FOR: metadata
#

DROP TABLE IF EXISTS `metadata`;

CREATE TABLE `metadata` (
  `metaID` int(11) NOT NULL AUTO_INCREMENT,
  `categoryID` int(11) DEFAULT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `maxMarks` int(11) DEFAULT NULL,
  `weight` double DEFAULT 0.0,
  `due` date DEFAULT NULL,
  PRIMARY KEY (`metaID`),
  KEY `metaCategory_idx` (`categoryID`),
  CONSTRAINT `metaCategory` FOREIGN KEY (`categoryID`) REFERENCES `categories` (`categoryID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (1, 1, 'eos', 'Sequi est hic architecto.', 61, 2, '1972-07-18');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (2, 5, 'quae', 'Quo sed omnis sunt nihil.', 100, 4, '1972-09-24');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (3, 14, 'deserunt', 'Eligendi et sed omnis et.', 61, 3, '2005-02-22');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (4, 2, 'et', 'Omnis sed sit velit ut.', 53, 3, '2016-02-29');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (5, 9, 'labore', 'Libero harum corrupti ad cum.', 65, 5, '1978-06-15');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (6, 11, 'ducimus', 'Nihil voluptas minima ex.', 80, 3, '1974-11-25');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (7, 3, 'omnis', 'Et quos et nisi et sed.', 55, 3, '2012-08-23');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (8, 4, 'magni', 'Est harum dolorum et et.', 57, 2, '1970-11-17');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (9, 2, 'facilis', 'Magnam dolorem sed quas.', 64, 4, '1974-09-14');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (10, 12, 'officiis', 'Voluptatem cumque et et.', 39, 3, '1970-04-10');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (11, 15, 'fuga', 'Ipsum porro ad incidunt.', 96, 5, '2002-01-02');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (12, 13, 'qui', 'Laborum totam est quae.', 100, 4, '1997-07-06');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (13, 11, 'voluptatem', 'Magni esse eos esse.', 87, 4, '1971-04-22');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (14, 13, 'quam', 'Aut delectus pariatur dolor.', 47, 1, '1983-04-12');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (15, 9, 'cupiditate', 'Inventore fuga a et.', 72, 1, '1989-05-28');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (16, 7, 'inventore', 'Ab est natus sapiente magnam.', 94, 1, '1975-12-07');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (17, 10, 'ut', 'Ipsam animi numquam aut qui.', 37, 5, '1995-06-03');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (18, 7, 'et', 'Eveniet ad beatae velit.', 83, 3, '2004-12-08');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (19, 10, 'est', 'Ducimus quos quia qui.', 37, 5, '1988-07-06');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (20, 10, 'aspernatur', 'Maiores accusamus non et.', 87, 4, '1985-09-05');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (21, 10, 'autem', 'Maxime autem dolores ut quia.', 59, 1, '1980-06-16');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (22, 12, 'voluptatum', 'Ad vel facilis molestias.', 89, 3, '1993-02-26');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (23, 1, 'autem', 'Qui error nihil qui cumque.', 94, 3, '2010-04-18');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (24, 15, 'dolorem', 'Aut omnis velit ratione quam.', 97, 5, '1978-02-04');
INSERT INTO `metadata` (`metaID`, `categoryID`, `name`, `description`, `maxMarks`, `weight`, `due`) VALUES (25, 13, 'unde', 'Qui quidem et deleniti.', 42, 2, '2013-09-01');



#
# TABLE STRUCTURE FOR: students
#

DROP TABLE IF EXISTS `students`;

CREATE TABLE `students` (
  `studentID` int(11) NOT NULL AUTO_INCREMENT,
  `sectionID` int(11) DEFAULT NULL,
  `firstName` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastName` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`studentID`),
  KEY `studentSection_idx` (`sectionID`),
  CONSTRAINT `studentSection` FOREIGN KEY (`sectionID`) REFERENCES `sections` (`sectionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (1, 1, 'Arnold', 'Shanahan');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (2, 4, 'London', 'Halvorson');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (3, 2, 'Kale', 'Hilpert');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (4, 2, 'Leopoldo', 'Cormier');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (5, 3, 'Gregory', 'Gulgowski');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (6, 1, 'Jalen', 'Berge');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (7, 3, 'Samson', 'Mayer');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (8, 2, 'Garrison', 'Sipes');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (9, 3, 'Rollin', 'Nolan');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (10, 1, 'Liam', 'Schmidt');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (11, 3, 'Jeffery', 'Tremblay');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (12, 2, 'Darrel', 'Tremblay');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (13, 5, 'Brain', 'Rowe');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (14, 1, 'Eli', 'Lakin');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (15, 1, 'Edwardo', 'Sporer');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (16, 4, 'Crawford', 'Bosco');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (17, 2, 'Winfield', 'Wintheiser');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (18, 1, 'Finn', 'Keebler');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (19, 1, 'Mikel', 'Rodriguez');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (20, 5, 'Bo', 'Beahan');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (21, 3, 'Bennett', 'Herzog');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (22, 2, 'Berry', 'Morar');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (23, 1, 'Myrl', 'Gerhold');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (24, 5, 'Richmond', 'Schaden');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (25, 2, 'Selmer', 'Dickinson');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (26, 3, 'Kenneth', 'Legros');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (27, 3, 'Kenyon', 'Prosacco');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (28, 1, 'Coby', 'Runte');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (29, 1, 'Cory', 'Rau');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (30, 2, 'Taylor', 'Wilderman');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (31, 5, 'Raymundo', 'Hudson');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (32, 5, 'Jovani', 'Bode');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (33, 2, 'Dangelo', 'Jacobi');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (34, 3, 'Morgan', 'Kassulke');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (35, 3, 'Sanford', 'Stanton');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (36, 1, 'Mason', 'Ratke');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (37, 3, 'Douglas', 'Morissette');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (38, 2, 'Obie', 'Hermiston');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (39, 3, 'Einar', 'Doyle');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (40, 2, 'Rick', 'Jenkins');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (41, 3, 'Sidney', 'Pouros');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (42, 2, 'Verner', 'Boyer');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (43, 4, 'Isaias', 'Feil');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (44, 4, 'Abe', 'Crist');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (45, 3, 'Tyrel', 'Murazik');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (46, 1, 'Josiah', 'Kling');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (47, 4, 'August', 'Mayer');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (48, 5, 'Adrian', 'Flatley');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (49, 5, 'Earnest', 'Haley');
INSERT INTO `students` (`studentID`, `sectionID`, `firstName`, `lastName`) VALUES (50, 1, 'Clifton', 'Wiza');



#
# TABLE STRUCTURE FOR: assessments
#

DROP TABLE IF EXISTS `assessments`;

CREATE TABLE `assessments` (
  `assessmentID` int(11) NOT NULL AUTO_INCREMENT,
  `metaID` int(11) DEFAULT NULL,
  `studentID` int(11) DEFAULT NULL,
  `score` double DEFAULT -1,
  `percentScore` double DEFAULT -1,
  `active` bit(1) DEFAULT 1,
  PRIMARY KEY (`assessmentID`),
  KEY `assessmentMeta_idx` (`metaID`),
  KEY `assessmentStudent_idx` (`studentID`),
  CONSTRAINT `assessmentMeta` FOREIGN KEY (`metaID`) REFERENCES `metadata` (`metaID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assessmentStudent` FOREIGN KEY (`studentID`) REFERENCES `students` (`studentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (1, 18, 22, 43, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (2, 25, 28, 26, NULL, 0);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (3, 11, 32, 45, NULL, 0);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (4, 2, 11, 42, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (5, 22, 23, 52, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (6, 12, 48, 38, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (7, 22, 2, 55, NULL, 0);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (8, 21, 4, 36, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (9, 21, 48, 52, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (10, 8, 31, 57, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (11, 15, 39, 54, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (12, 2, 20, 54, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (13, 21, 36, 30, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (14, 7, 40, 55, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (15, 16, 39, 92, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (16, 16, 8, 67, NULL, 0);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (17, 4, 15, 0, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (18, 19, 49, 30, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (19, 23, 39, 70, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (20, 21, 41, 56, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (21, 3, 8, 31, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (22, 22, 11, 89, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (23, 23, 46, 91, NULL, 0);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (24, 3, 26, 60, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (25, 7, 14, 5, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (26, 20, 11, 87, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (27, 14, 43, 46, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (28, 11, 12, 94, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (29, 1, 27, 49, NULL, 1);
INSERT INTO `assessments` (`assessmentID`, `metaID`, `studentID`, `score`, `percentScore`, `active`) VALUES (30, 24, 17, 77, NULL, 1);


