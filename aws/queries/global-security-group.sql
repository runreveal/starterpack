-- Shows security group rule changes allowing global ingress to resource
select eventTime, eventName,
    coalesce(nullIf(JSON_VALUE(requestParameters, '$.ModifySecurityGroupRulesRequest.GroupId'), ''),
        nullIf(JSON_VALUE(requestParameters, '$.UpdateSecurityGroupRuleDescriptionsIngressRequest.GroupId'), ''),
        JSONExtractString(requestParameters, 'groupId')) groupId,
    coalesce(nullIf(CASE WHEN userIdentity.type = 'Root' THEN `userIdentity.arn`
        WHEN userIdentity.type = 'IAMUser' THEN userIdentity.userName
        WHEN userIdentity.type = 'AssumedRole' AND
             startsWith(userIdentity.sessionContext.sessionIssuer.userName, 'AWSReservedSSO_') THEN `userIdentity.principalId`
        WHEN userIdentity.type = 'AssumedRole' THEN `userIdentity.sessionContext.sessionIssuer.userName` END, ''), `userIdentity.arn`) identity,
    arrayDistinct(JSONExtract(coalesce(nullIf(JSON_QUERY(requestParameters,
    '$.ipPermissions.items[*].ipRanges.items[*].cidrIp'), ''),
    nullIf(JSON_QUERY(requestParameters,
    '$.ModifySecurityGroupRulesRequest.SecurityGroupRule.SecurityGroupRule.CidrIpv4'), ''),
    nullIf(JSON_QUERY(requestParameters,
    '$.UpdateSecurityGroupRuleDescriptionsIngressRequest.IpPermissions.IpRanges.CidrIp'), ''), '[]'), 'Array(String)')) ipAddresses,
        JSONExtract(lower(coalesce(nullIf(JSON_QUERY(requestParameters, '$.ModifySecurityGroupRulesRequest.SecurityGroupRule.SecurityGroupRule'), ''),
        nullIf(JSON_QUERY(requestParameters, '$.UpdateSecurityGroupRuleDescriptionsIngressRequest.IpPermissions'), ''),
        nullIf(JSON_QUERY(requestParameters, '$.ipPermissions.items[*]'), ''), '[]')), 'Array(Tuple(fromport String, toport String))') portRanges
from cloudtrail_logs
where readOnly = false AND eventName IN ('AuthorizeSecurityGroupIngress', 'UpdateSecurityGroupRuleDescriptionsIngress', 'ModifySecurityGroupRules')
AND nullIf(errorCode, '') IS NULL
AND has(ipAddresses, '0.0.0.0/0')
AND eventTime >= subtractMinutes(now('UTC'), 15)
ORDER BY eventTime desc;