select eventName, userIdentity.userName,
       userIdentity.accessKeyId, count(*) accessCounts
from cloudtrail_logs
where eventTime BETWEEN subtractMinutes(now('UTC'), 5) AND now('UTC')
AND userIdentity.accessKeyId <> '' AND userIdentity.userName <> ''
group by eventName, `userIdentity.userName`, `userIdentity.accessKeyId`
order by accessCounts desc