ETAPE 6 : 

1. temps d'execution :
		Planning Time : 1.231 ms
		Execution Time : 172.644 ms

2. Seq Scans :
		Parallel Seq Scan on participation_defi pd  (cost=0.00..2577.52 rows=147052 width=8) (actual time=0.006..8.231 rows=124994 loops=2)
		Seq Scan on streamer s  (cost=0.00..1218.00 rows=16667 width=16) (actual time=0.040..4.438 rows=4999 loops=2)
		Seq Scan on defi d  (cost=0.00..851.00 rows=50000 width=14) (actual time=0.032..5.830 rows=50000 loops=2)
		Index Scan using idx_stream_id_streamer on stream st  (cost=0.29..6876.28 rows=100000 width=24) (actual time=0.058..7.858 rows=10019 loops=1)

3. Nombre de lignes traités :
		Parallel Seq Scan → 124994 rows × 2 loops ≈ 249 988 lignes
		Seq Scan → 50000 rows × 2 loops ≈ 100 000 lignes
		Seq Scan → 4999 rows × 2 loops ≈ 9 998 lignes lues (mais 50 000 filtrées au total)
		Index Scan → 10019 rows
		Materialize → 49808 rows
		Index Scan → 10019 rows
		Materialize → 49808 rows
	Environ 450000 lignes brute

4. Le gain en performance : 
		Gain (%) = (Ancien temps - Nouveau temps) / Ancien temps × 100
			   = (243.667 - 172.644) / 243.667 × 100
			   = 71.023 / 243.667 × 100
			   ≈ 29.14 %
