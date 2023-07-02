def trigger(event):
    e = event.get("log")
    return (e.get("eventName") == "AssumeRole" or
            e.get("eventName") == "SwitchRole")
