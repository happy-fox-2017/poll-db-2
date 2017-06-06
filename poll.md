1.
SELECT voters.first_name, voters.last_name, voters.gender, votes.politician_id, tabX.total_votes FROM voters JOIN votes ON voters.id = votes.voter_id JOIN (SELECT COUNT(politician_id) AS total_votes, politician_id FROM votes GROUP BY politician_id ORDER BY total_votes DESC) tabX ON votes.politician_id = tabX.politician_id ORDER BY tabX.politician_id;

2.
SELECT votes.politician_id, congress_members.name, congress_members.location, congress_members.grade_current, COUNT(politician_id) AS total_votes FROM votes JOIN congress_members ON votes.politician_id = congress_members.id WHERE congress_members.grade_current < 9 GROUP BY votes.politician_id, congress_members.name, congress_members.location, congress_members.grade_current ORDER BY congress_members.grade_current DESC;

3.
SELECT congress_members.location, COUNT(votes.id) FROM congress_members JOIN votes ON votes.politician_id = congress_members.id GROUP BY congress_members.location ORDER BY COUNT(votes.id) DESC LIMIT 10; SELECT congress_members.location, COUNT(votes.id) FROM congress_members JOIN votes ON votes.politician_id = congress_members.id GROUP BY congress_members.location ORDER BY COUNT(votes.id) DESC LIMIT 10;

4.
SELECT voters.first_name, voters.last_name, voters.gender, more.total_votes, congress_members.name FROM voters JOIN (SELECT COUNT(politician_id) AS total_votes, voter_id, politician_id FROM votes GROUP BY voter_id, politician_id HAVING total_votes = 2 ) AS more ON more.voter_id = voters.id JOIN congress_members ON congress_members.id = more.politician_id WHERE total_votes > 1
