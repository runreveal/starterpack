select 
  eventName,
  userIdentity.userName,
  sourceIPAddress,
  srcASCountryCode,
  readOnly,
  eventTime
from cloudtrail_logs
where
  eventTime >= subtractHours(now('UTC'), toInt32(@hour))
  AND
  userIdentity.accessKeyId=@key
order by eventTime desc;
