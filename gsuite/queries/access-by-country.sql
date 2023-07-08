-- View events from certain countries. 
-- Use '--param country=<country>' and '--param hour=<hour>' to run the query with parameters
select *
from runreveal_logs where sourceType = 'gsuite'
and srcASCountryCode = @country and
eventTime >= subtractHours(now('UTC'), toInt32(@hour))
ORDER BY eventTime desc
