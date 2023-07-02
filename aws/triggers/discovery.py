def trigger(event):
    e = event.get("log")
    return (e.get("eventName") == "ListUsers" or
            e.get("eventName") == "ListRoles" or
            e.get("eventName") == "ListIdentities" or
            e.get("eventName") == "ListAccessKeys" or
            e.get("eventName") == "ListServiceQuotas" or
            e.get("eventName") == "ListInstanceProfiles" or
            e.get("eventName") == "ListBuckets" or
            e.get("eventName") == "ListGroups" or
            e.get("eventName") == "GetCallerIdentity" or
            e.get("eventName") == "DescribeInstances" or
            e.get("eventName") == "GetBucketAcl" or
            e.get("eventName") == "GetBucketVersioning" or
            e.get("eventName") == "GetSendQuota" or
            e.get("eventName") == "GetAccountAuthorizationDetails")
