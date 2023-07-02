def trigger(event):
    e = event.get("log")
    return (e.get("eventName") == "SendCommand" or
        e.get("eventName") == "StartInstance" or
        e.get("eventName") == "StartInstances" or
        e.get("eventName") == "Invoke")
