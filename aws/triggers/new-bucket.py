def trigger(event):
    e = event.get("log")
    return e.get("eventName") == "CreateBucket"
