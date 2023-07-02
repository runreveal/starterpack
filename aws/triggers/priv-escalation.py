def trigger(event):
    e = event.get("log")
    return (e.get("eventName") == "CreateGroup" or
        e.get("eventName") == "CreateRole" or
        e.get("eventName") == "UpdateAccessKey" or
        e.get("eventName") == "PutGroupPolicy" or
        e.get("eventName") == "PutGroupPolicy" or
        e.get("eventName") == "PutUserPolicy" or
        e.get("eventName") == "AddRoleToInstanceProfile" or
        e.get("eventName") == "AttachUserToGroup")
