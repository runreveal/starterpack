-- User '--param email=<email> --param hour=<hour>' to run the query with parameters

SELECT eventName, COUNT(*) cnt FROM runreveal_logs
WHERE actor['email'] = @email
AND eventTime > subtractHours(now(), toInt32(@hour))
GROUP BY eventName ORDER BY cnt desc