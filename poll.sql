<!-- 1. Siapa anggota Congress yang mendapatkan vote terbanyak? List nama mereka dan jumlah vote-nya. Siapa saja yang memilih politisi tersebut? List nama mereka, dan jenis kelamin mereka. -->
<!-- 2. Berapa banyak vote yang diterima anggota Congress yang memiliki grade di bawah 9 (gunakan field `grade_current`)? Ambil nama, lokasi, grade_current dan jumlah vote. -->
<!-- 3. Apa saja 10 negara bagian yang memiliki voters terbanyak? List semua orang yang melakukan vote di negara bagian yang paling populer. (Akan menjadi daftar yang panjang, kamu bisa gunakan hasil dari query pertama untuk menyederhanakan query berikut ini.) -->
<!-- 4. List orang-orang yang vote lebih dari dua kali. Harusnya mereka hanya bisa vote untuk posisi Senator dan satu lagi untuk wakil. Wow, kita dapat si tukang curang! Segera laporkan ke KPK!! -->
<!-- 5. Apakah ada orang yang melakukan vote kepada politisi yang sama dua kali? Siapa namanya dan siapa nama politisinya? -->

--1
/*terbanyak: Rep. Dan Benishek, count 32*/
SELECT voters.first_name,
       voters.last_name,
       voters.gender
FROM voters
LEFT JOIN votes ON voters.id = votes.voter_id
WHERE votes.politician_id = 224;


--2
SELECT congress_members.id,
       congress_members.name,
  	   congress_members.location,
  	   congress_members.grade_current,
  	   COUNT(votes.id) AS votes_count
FROM congress_members
LEFT JOIN votes ON congress_members.id = votes.politician_id
WHERE congress_members.grade_current < 9
GROUP BY congress_members.id;


--3
SELECT voters.id,
       voters.first_name||' '||voters.last_name,
       congress_members.location
FROM voters
INNER JOIN votes ON voters.id = votes.voter_id
INNER JOIN congress_members ON congress_members.id = votes.politician_id
WHERE congress_members.location =
    (SELECT congress_members.location
     FROM congress_members
     INNER JOIN votes ON congress_members.id = votes.politician_id
     GROUP BY congress_members.location
     ORDER BY COUNT(votes.id) DESC
     LIMIT 10)
ORDER BY voters.first_name;


--4
SELECT voters.id,
       voters.first_name||' '||voters.last_name AS voters_name,
       COUNT (votes.voter_id) AS vote_count
FROM voters
INNER JOIN votes ON voters.id = votes.voter_id
GROUP BY voters_name
HAVING vote_count > 2
ORDER BY voters.id ASC;


--5
/*output: 20 rows*/
SELECT votes.voter_id,
       voters.first_name||' '||voters.last_name AS voters_name,
       COUNT(votes.politician_id) AS vote_count,
       congress_members.name
FROM votes
INNER JOIN voters ON voters.id = votes.voter_id
INNER JOIN congress_members ON votes.politician_id = congress_members.id
GROUP BY votes.voter_id, votes.politician_id
HAVING vote_count > 1
ORDER BY votes.voter_id ASC;