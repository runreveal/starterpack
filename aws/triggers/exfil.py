def trigger(event):
    e = event.get("log")
    return (e.get("eventName") == "CreateSnapShot" or
            e.get("eventName") == "CreateSnapshot" or
            e.get("eventName") == "ModifySnapshotAttributes" or
            e.get("eventName") == "ModifyImageAttribute" or
            e.get("eventName") == "SharedSnapshotCopyInitiated" or
            e.get("eventName") == "SharedSnapshotVolumeCreated" or
            e.get("eventName") == "ModifyDBSnapshotAttribute" or
            e.get("eventName") == "PutBucketPolicy" or
            e.get("eventName") == "PutBucketAcl")
