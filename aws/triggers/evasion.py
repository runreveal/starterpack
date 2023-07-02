def trigger(event):
    e = event.get("log")
    return (e.get("eventName") == "StopLogging" or
            e.get("eventName") == "DeleteTrail" or
            e.get("eventName") == "UpdateTrail" or
            e.get("eventName") == "PutEventSelectors" or
            e.get("eventName") == "DeleteFlowLogs" or
            e.get("eventName") == "DeleteDetector" or
            e.get("eventName") == "DeleteMembers" or
            e.get("eventName") == "DeleteSnapshot" or
            e.get("eventName") == "DeactivateMFADevice" or
            e.get("eventName") == "DeleteCertificate" or
            e.get("eventName") == "DeleteConfigRule" or
            e.get("eventName") == "DeleteAccessKey" or
            e.get("eventName") == "LeaveOrganization" or
            e.get("eventName") == "DisassociateFromMasterAccount" or
            e.get("eventName") == "DisassociateMembers" or
            e.get("eventName") == "StopMonitoringMembers")
