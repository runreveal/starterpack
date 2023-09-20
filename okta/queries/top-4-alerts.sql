SELECT *
FROM okta_logs
WHERE 
(eventType IN (
    'user.account.update_password',
    'user.account.unlock_by_admin',
    'user.account.lock.limit',
    'user.account.report_suspicious_activity_by_enduser'
) OR eventType IN (
    'security.threat.detected',
    'security.attack.start',
    'security.attack.end',
    'debugContext.debugData.threatSuspected'
) OR eventType IN (
    'system.email.mfa_reset_notification.sent_message',
    'user.mfa.factor.deactivate',
    'user.mfa.factor.activate',
    'user.mfa.attempt_bypass'
) OR eventType IN (
    'user.session.access_admin_app',
    'user.session.impersonation.initiate',
    'app.oauth2.admin.consent.grant'
)) AND eventTime >= now() - INTERVAL 15 MINUTE;
