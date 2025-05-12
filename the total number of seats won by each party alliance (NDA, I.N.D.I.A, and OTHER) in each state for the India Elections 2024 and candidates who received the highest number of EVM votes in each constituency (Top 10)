SELECT s.State as state_name,
SUM( CASE WHEN p.party_alliance='NDA' THEN 1 ELSE 0 END) AS NDA_SEATS,
SUM( CASE WHEN p.party_alliance='I.N.D.I.A' THEN 1 ELSE 0 END) AS NDA_SEATS,
SUM( CASE WHEN p.party_alliance='OTHER' THEN 1 ELSE 0 END) AS NDA_SEATS
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    states s ON sr.State_ID = s.State_ID
  
GROUP BY 
    s.State
ORDER BY 
    s.State;


SELECT TOP 10
cr.Constituency_name,
cd.Constituency_ID,
cd.Candidate,
cd.EVM_Votes
FROM
constituencywise_details cd
INNER JOIN
constituencywise_results cr ON cr.Constituency_ID=cd.Constituency_ID
WHERE
cd.EVM_Votes=(
SELECT MAX(cd1.EVM_Votes)
FROM constituencywise_details cd1
WHERE cd1.Constituency_ID = cd.Constituency_ID
)
ORDER BY cd.EVM_Votes DESC;

WITH RankedCandidates AS (
    SELECT 
        cd.Constituency_ID,
        cd.Candidate,
        cd.Party,
        cd.EVM_Votes,
        cd.Postal_Votes,
        cd.EVM_Votes + cd.Postal_Votes AS Total_Votes,
		ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID ORDER BY cd.EVM_Votes+ cd.Postal_Votes DESC) AS Vote_Rank
	FROM 
        constituencywise_details cd
    JOIN 
        constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
    JOIN 
        statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
    JOIN 
        states s ON sr.State_ID = s.State_ID
    WHERE 
        s.State = 'Maharashtra'
)
SELECT 
    cr.Constituency_Name,
    MAX(CASE WHEN rc.Vote_Rank = 1 THEN rc.Candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.Vote_Rank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
    RankedCandidates rc
JOIN 
    constituencywise_results cr ON rc.Constituency_ID = cr.Constituency_ID
GROUP BY 
    cr.Constituency_Name
ORDER BY 
    cr.Constituency_Name;

