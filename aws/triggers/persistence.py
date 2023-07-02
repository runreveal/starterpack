def trigger(event):
    e = event.get("log")
    return (e.get("eventName") == "CreateAccessKey" or
        e.get("eventName") == "CreateUser" or
        e.get("eventName") == "CreateNetworkAclEntry" or
        e.get("eventName") == "CreateRoute" or
        e.get("eventName") == "CreateLoginProfile" or
        e.get("eventName") == "AuthorizeSecurityGroupIngress" or
        e.get("eventName") == "AuthorizeSecurityGroupEgress" or
        e.get("eventName") == "CreateVirtualMFADevice" or
        e.get("eventName") == "CreateConnection" or
        e.get("eventName") == "ApplySecurityGroupsToLoadBalancer" or
        e.get("eventName") == "SetSecurityGroups" or
        e.get("eventName") == "AuthorizeDBSecurityGroupIngress" or
        e.get("eventName") == "CreateDBSecurityGroup" or
        e.get("eventName") == "ChangePassword")
