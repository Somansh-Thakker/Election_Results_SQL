SELECT s.state AS State_name,
COUNT(cr.parliament_constituency) AS Total_Seats
FROM
constituencywise_results cr
INNER JOIN statewise_results sr ON cr.Parliament_Constituency=sr.Parliament_Constituency
INNER JOIN states s ON sr.State_ID=s.State_ID
GROUP BY s.state