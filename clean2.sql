USE yelp_db;

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS Business_Count;

CREATE TEMPORARY TABLE Business_Count
(
	SELECT business_id, COUNT(business_id) count
	FROM Review
	GROUP BY business_id
);	

DROP TABLE IF EXISTS deleteTable;
	
CREATE TEMPORARY TABLE deleteTable
(
	SELECT  b.id
	FROM Business b LEFT JOIN Business_Count bc ON b.id = bc.business_id
	WHERE b.review_count != bc.count
);

DELETE review 
FROM review
INNER JOIN deleteTable ON review.business_id = deleteTable.id;

DELETE Business 
FROM Business
INNER JOIN deleteTable ON Business.id = deleteTable.id;
