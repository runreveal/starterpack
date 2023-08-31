SELECT * FROM cloudtrail_logs WHERE
(
  (userIdentity.type='Root' and userAgent!='AWS Internal') OR
  (eventName in (
    'CreateBucket',
    'DeleteBucket')) OR
  (eventName in (
    'UpdateAccessKey',
    'CreateAccessKey',
    'DeleteAccessKey')) OR
  (eventName in (
    'DeleteTrail',
    'UpdateTrail',
    'StopMonitoringMembers',
    'DeleteDetector',
    'DisableSecurityHub',
    'DeactivateMFADevice',
    'DeleteVirtualMFADevice')) OR
  (eventName in 
    ('AuthorizeSecurityGroupIngress',
     'PutKeyPolicy',
     'PutBucketPolicy',
     'UpdateAssumeRolePolicy',
     'AttachUserPolicy',
     'PutRolePolicy',
     'PutGroupPolicy')
   )
)
AND receivedAt >= now() - INTERVAL 15 MINUTE;
