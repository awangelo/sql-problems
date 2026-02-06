SELECT c.name,
    ROUND( (s.math*2 + s.specific*3 + s.project_plan*5) / 10 , 2 ) AS avg_score
FROM candidate c
JOIN score s
ON c.id = s.candidate_id
ORDER BY avg_score DESC;