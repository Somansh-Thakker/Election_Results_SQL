SELECT
p.party_alliance,
COUNT(cr.Constituency_ID) as seats_won
FROM
constituencywise_results cr
JOIN
partywise_results p ON cr.Party_ID=p.Party_ID
WHERE 
    p.party_alliance IN ('NDA', 'I.N.D.I.A', 'OTHER')
GROUP BY 
    p.party_alliance
ORDER BY 
    Seats_Won DESC;
