def trigger(event):
    e = event.get("log")
    return (e.get("eventName") == "PutBucketVersioning" or
            e.get("eventName") == "RunInstances" or
            e.get("eventName") == "DeleteAccountPublicAccessBlock")
