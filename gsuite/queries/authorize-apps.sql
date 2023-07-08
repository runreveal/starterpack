-- Shows the list of users and the amount of times an app was authorized from a specific country
select
max(eventTime) eventTime,
arrayFirst(x -> x.1 = 'app_name',
arrayFirst(x -> x.2 = 'authorize', JSONExtract(JSON_QUERY(rawLog, '$.events[*]'),
    'Array(Tuple(type String, name String, parameters Array(Tuple(name String, value String))))')).3).2 app,
actor['email'] email,
srcASCountryCode, count(*) cnt
from runreveal_logs where sourceType = 'gsuite'
and eventName = 'authorize'
GROUP BY app, email, srcASCountryCode
order by eventTime desc