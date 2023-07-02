def trigger(event):
    e = event.get("log")
    return (e.get("eventName") == "GetSecretValue" or
            e.get("eventName") == "GetPasswordData" or
            e.get("eventName") == "UpdateAssumeRolePolicy" or
            e.get("eventName") == "RequestCertificate")
