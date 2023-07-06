-- Gets a list of triggers whose count today is higher than the daily average from the previous 7 days
SELECT cur.triggerName, cur.ct Count, avgs.avg average_count
FROM
(SELECT triggerName, count(*) ct from event_trigger_history
 WHERE triggeredAt >= toDate(now('UTC')) GROUP BY triggerName) cur
INNER JOIN (
SELECT triggerName, avg(ct) avg FROM (SELECT triggerName, COUNT(*) ct
from event_trigger_history
WHERE triggeredAt BETWEEN subtractDays(toStartOfInterval(now('UTC'), INTERVAL 1 DAY), 8)
    AND toStartOfInterval(now('UTC'), INTERVAL 1 DAY)
GROUP BY triggerName, toDate(triggeredAt)) GROUP BY triggerName) avgs
ON cur.triggerName = avgs.triggerName
WHERE cur.ct > avgs.avg