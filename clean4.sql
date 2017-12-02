USE yelp_db;

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS Business_Average;

CREATE TEMPORARY TABLE Business_Average
(
	SELECT r.business_id, AVG(stars) average
	FROM Review r
	GROUP BY r.business_id
);

DROP TABLE IF EXISTS deleteTable;
	
CREATE TEMPORARY TABLE deleteTable(
	SELECT b.id, b.stars, ba.average
	FROM Business b 
	LEFT JOIN  Business_Average ba ON b.id = ba.business_id
	WHERE ABS(b.stars - ba.average) > 0.5
	ORDER BY ABS(b.stars - ba.average) DESC 
);

DELETE review 
FROM review
INNER JOIN deleteTable ON review.user_id = deleteTable.id;

DELETE Business 
FROM Business
INNER JOIN deleteTable ON Business.id = deleteTable.id;



