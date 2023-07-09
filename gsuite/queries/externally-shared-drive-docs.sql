-- Gets the user, what country the user is in, and the number of drive documents the user is sharing publicly
SELECT actor['email'] email, srcASCountryCode, count(DISTINCT rawLog) cnt from runreveal_logs
    WHERE sourceType = 'gsuite' AND (eventName = 'edit' OR eventName = 'publish_change')
AND (has(arrayFilter(x -> x.2 = 'change_document_visibility',
    JSONExtract(JSON_QUERY(rawLog, '$.events[*]'),
    'Array(Tuple(type String, name String, parameters Array(Tuple(name String, value String))))')).3[1],
    tuple('visibility_change', 'external')) OR
     has(arrayFilter(x -> x.2 = 'publish_change',
    JSONExtract(JSON_QUERY(rawLog, '$.events[*]'),
    'Array(Tuple(type String, name String, parameters Array(Tuple(name String, value String))))')).3[1],
    tuple('new_publish_visibility', 'public_on_the_web')))
GROUP BY email, srcASCountryCode
ORDER BY email
