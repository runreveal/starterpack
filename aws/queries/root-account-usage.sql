select eventName, count(*) count, max(eventTime) lastAccessTime, groupUniqArray(srcASCountryCode) accessCountries
from cloudtrail_logs
where userIdentity.type = 'Root'
and eventTime >= subtractMinutes(now('UTC'), 15)
group by eventName
order by lastAccessTime desc