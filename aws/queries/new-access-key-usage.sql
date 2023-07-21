-- Shows access keys that performed an event in the past 5 minutes that has not been done in the past 30 days.
WITH oldAccess as (SELECT DISTINCT eventName, `userIdentity.accessKeyId`
FROM cloudtrail_logs
where eventTime
between subtractDays(subtractMinutes(now('UTC'), 15), 30) and subtractMinutes(now('UTC'), 5)
AND userIdentity.accessKeyId <> '' AND userIdentity.userName <> '')
SELECT lastAccessTime, event, userName, accessKeyId, accessCounts
    FROM
 (
     SELECT eventTime lastAccessTime, 'NewAccessKeyCreated' event,
            JSON_VALUE(responseElements, '$.accessKey.userName') userName,
            JSON_VALUE(responseElements, '$.accessKey.accessKeyId') accessKeyId,
            1 accessCounts FROM cloudtrail_logs WHERE eventName = 'CreateAccessKey'
            AND eventTime BETWEEN subtractMinutes(now('UTC'), 5) AND now('UTC')
            AND userName <> '' AND accessKeyId <> ''
     UNION ALL
     select max(eventTime) lastEventTime, eventName, userIdentity.userName,
       userIdentity.accessKeyId, count(*) accessCounts
        from cloudtrail_logs
        where
            eventTime BETWEEN subtractMinutes(now('UTC'), 15) AND now('UTC') AND
            userIdentity.accessKeyId <> '' AND userIdentity.userName <> ''
        group by eventName, `userIdentity.userName`, `userIdentity.accessKeyId`
 ) where (event, accessKeyId) NOT IN oldAccess;