USE yelp_db;

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS Review_Average;

CREATE TEMPORARY TABLE Review_Average
(
	SELECT r.user_id, AVG(stars) average
	FROM Review r
	GROUP BY r.user_id
);

DROP TABLE IF EXISTS deleteTable;
	
CREATE TEMPORARY TABLE deleteTable
(
	SELECT u.id
	FROM User u
	LEFT JOIN Review_Average ra on u.id = ra.user_id
	WHERE ABS(u.average_stars - ra.average) > 0.5
	ORDER BY ABS(u.average_stars - ra.average) DESC 
);

DELETE review 
FROM review
INNER JOIN deleteTable ON review.user_id = deleteTable.id;

DELETE user 
FROM user
INNER JOIN deleteTable ON user.id = deleteTable.id;


