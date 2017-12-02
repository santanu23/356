USE yelp_db;
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS Review_Count;

CREATE TEMPORARY TABLE Review_Count
(
 SELECT user_id, COUNT(user_id) count
	FROM Review
	GROUP BY user_id
);	

DROP TABLE IF EXISTS deleteTable;

CREATE TEMPORARY TABLE deleteTable
(
	SELECT u.id
	FROM User u 
	LEFT JOIN Review_Count rc ON u.id = rc.user_id
	WHERE u.review_count != rc.count
);

DELETE review 
FROM review
INNER JOIN deleteTable ON review.user_id = deleteTable.id;



DELETE user 
FROM user
INNER JOIN deleteTable ON user.id = deleteTable.id;
