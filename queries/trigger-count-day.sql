-- User '--param trig=<triggerName>' to run the query with parameters
SELECT triggerName, count(*) Count
from event_trigger_history
WHERE triggeredAt >= toDate(now('UTC'))
AND triggerName = @trig
GROUP BY triggerName