CREATE DATABASE ESportsManagement;
USE ESportsManagement;
CREATE TABLE Teams (
team_id INT AUTO_INCREMENT PRIMARY KEY,
team_name VARCHAR(50) NOT NULL,
team_founded INT NOT NULL,
team_owner VARCHAR(50),
team_national VARCHAR(50) NOT NULL
);
CREATE TABLE Players (
player_id INT AUTO_INCREMENT PRIMARY KEY,
player_name VARCHAR(50) NOT NULL,
player_NickName VARCHAR(50) NOT NULL UNIQUE,
player_position VARCHAR(50) NOT NULL,
player_salary DECIMAL(15,2) NOT NULL CHECK ( player_salary > 0 ),
team_id INT,
FOREIGN KEY (team_id) REFERENCES Teams (team_id)
);
CREATE TABLE Matchs (
match_id VARCHAR(15) PRIMARY KEY,
match_date DATETIME DEFAULT ( CURRENT_TIMESTAMP),
match_result INT NOT NULL
);
CREATE TABLE Match_Statistic (
MStatistic_id INT AUTO_INCREMENT PRIMARY KEY,
MStatistic_kills INT NOT NULL,
MStatistic_deaths INT NOT NULL,
MStatistic_assists INT NOT NULL,
player_id INT,
match_id VARCHAR(15),
FOREIGN KEY (player_id) REFERENCES Players (player_id),
FOREIGN KEY (match_id) REFERENCES Matchs (match_id)
);
ALTER TABLE Matchs
ADD COLUMN match_prize INT NOT NULL;
ALTER TABLE Teams
RENAME COLUMN team_national TO team_area;
-- DROP TABLE Match_Statistic;
-- DROP TABLE Matchs;
INSERT INTO Teams 
VALUES 
(NULL,'T1', 2004, 'Joe Marsh', 'Korea'),
(NULL,'Gen.G', 2017, 'Kevin Chou', 'Korea'),
(NULL,'JDG', 2017, NULL, 'China'),
(NULL,'GAM Esports', 2017, 'TK Nguyen', 'Vietnam'),
(NULL,'G2 Esports', 2015, NULL, 'Europe');

INSERT INTO Players
VALUES 
(NULL,'Lee Sang-hyeok', 'Faker', 'Mid', 150000000, 1),
(NULL,'Mun Hyeon-jun', 'Oner', 'Jungler', 60000000, 1),
(NULL,'Jeong Ji-hoon', 'Chovy', 'Mid', 140000000, 2),
(NULL,'Kim Geon-bu', 'Canyon', 'Jungler', 110000000, 2),
(NULL,'Đỗ Duy Khánh', 'Levi', 'Jungler', 80000000, 4);

INSERT INTO Matchs 
VALUES 
('MS_001', '2024-03-01 18:00:00', 1, 5000),
('MS_002', '2024-03-02 19:00:00', 0, 2000),
('MS_007', '2024-03-05 20:00:00', 1, 10000),
('MS_008', '2024-03-10 15:00:00', 1, 3000),
('MS_009', '2024-03-15 17:00:00', 0, 1500);

INSERT INTO Match_Statistic
VALUES 
(NULL,5, 1, 10, 1, 'MS_007'), 
(NULL,8, 2, 5, 2, 'MS_007'),  
(NULL,3, 0, 12, 3, 'MS_001'), 
(NULL,10, 3, 4, 5, 'MS_002'), 
(NULL,4, 4, 8, 4, 'MS_008'); 

SET SQL_SAFE_UPDATES = 0;
UPDATE Players
SET player_salary = player_salary * 1.2
WHERE player_position = 'Jungler' ;

DELETE FROM Teams
WHERE team_owner IS NULL;

SELECT * 
FROM Players 
WHERE player_salary BETWEEN 50000000 AND 150000000;

SELECT *
FROM Matchs
WHERE match_id = 'MS_007';

SELECT player_NickName, player_position
FROM Players as p, Teams as t
WHERE p.team_id = t.team_id  AND t.team_area = 'Vietnam' ;
