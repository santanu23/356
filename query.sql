USE yelp_db;

SELECT 	u.review_count AS user_review, 
		u.useful AS user_useful,
		u.funny AS user_funny,
		u.cool AS user_cool,
		u.fans  AS user_fans,
		u.average_stars AS user_avg_stars,
		b.stars AS business_stars,
        b.review_count AS business_review_count,
		r.useful AS review_useful,
		r.funny AS review_funny,
		r.cool AS review_cool,
		r.stars AS review_stars
			
FROM review r
left JOIN business b ON r.business_id = b.id
LEFT JOIN user u ON r.user_id = u.id;
