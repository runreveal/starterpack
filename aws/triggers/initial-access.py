def trigger(event):
    e = event.get("log")
    return (e.get("eventName") == "ConsoleLogin" or
        e.get("eventName") == "PasswordRecoveryRequest")
