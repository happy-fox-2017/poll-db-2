<!-- Release 2  -->

<!-- 1. Siapa anggota Congress yang mendapatkan vote terbanyak? List nama mereka dan jumlah vote-nya. Siapa saja yang memilih politisi tersebut? List nama mereka, dan jenis kelamin mereka. -->

```SQL
SELECT voters.first_name, voters.last_name, voters.gender, votes.politician_id, tabX.total_votes FROM voters JOIN votes ON voters.id = votes.voter_id JOIN (SELECT COUNT(politician_id) AS total_votes, politician_id FROM votes GROUP BY politician_id ORDER BY total_votes DESC) tabX ON votes.politician_id = tabX.politician_id ORDER BY tabX.politician_id;
```

<!-- 2. Berapa banyak vote yang diterima anggota Congress yang memiliki grade di bawah 9 (gunakan field `grade_current`)? Ambil nama, lokasi, grade_current dan jumlah vote. -->

```SQL
SELECT votes.politician_id, congress_members.name, congress_members.location, congress_members.grade_current, COUNT(politician_id) AS total_votes FROM votes JOIN congress_members ON votes.politician_id = congress_members.id WHERE congress_members.grade_current < 9 GROUP BY votes.politician_id, congress_members.name, congress_members.location, congress_members.grade_current ORDER BY congress_members.grade_current DESC;
```

<!-- 3. Apa saja 10 negara bagian yang memiliki voters terbanyak? List semua orang yang melakukan vote di negara bagian yang paling populer. (Akan menjadi daftar yang panjang, kamu bisa gunakan hasil dari query pertama untuk menyederhanakan query berikut ini.) -->

```SQL
SELECT congress_members.location, COUNT(votes.id) FROM congress_members JOIN votes ON votes.politician_id = congress_members.id GROUP BY congress_members.location ORDER BY COUNT(votes.id) DESC LIMIT 10; SELECT congress_members.location, COUNT(votes.id) FROM congress_members JOIN votes ON votes.politician_id = congress_members.id GROUP BY congress_members.location ORDER BY COUNT(votes.id) DESC LIMIT 10;
```

<!-- 4. List orang-orang yang vote lebih dari dua kali. Harusnya mereka hanya bisa vote untuk posisi Senator dan satu lagi untuk wakil. Wow, kita dapat si tukang curang! Segera laporkan ke KPK!! -->

```SQL
SELECT voters.first_name, voters.last_name, voters.gender, more.total_votes, congress_members.name FROM voters JOIN (SELECT COUNT(politician_id) AS total_votes, voter_id, politician_id FROM votes GROUP BY voter_id, politician_id HAVING total_votes = 2 ) AS more ON more.voter_id = voters.id JOIN congress_members ON congress_members.id = more.politician_id WHERE total_votes > 1
```

<!-- 5. Apakah ada orang yang melakukan vote kepada politisi yang sama dua kali? Siapa namanya dan siapa nama politisinya? -->
