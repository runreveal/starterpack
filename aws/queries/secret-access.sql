select eventTime,
   coalesce(nullIf(userIdentity.userName, ''), userIdentity.sessionContext.sessionIssuer.userName) actor,
    JSONExtractString(requestParameters, 'secretId') secretName,
    eventID
from cloudtrail_logs
where
    eventTime BETWEEN subtractHours(now('UTC'), 2) AND now('UTC')
    AND eventSource = 'secretsmanager.amazonaws.com'
    and eventName = 'GetSecretValue'
order by eventTime desc