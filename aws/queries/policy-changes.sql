select max(eventTime) lastEventTime, eventName, eventSource, count(*) count,
countIf(errorCode <> '' AND errorCode IS NOT NULL) errorCount from cloudtrail_logs
where lower(eventName) like '%policy%'
 and readOnly = false
and eventTime >= subtractMinutes(now('UTC'), 15)
GROUP BY eventName, eventSource
ORDER BY lastEventTime desc