ETAPE 3 : 

1. temps d'execution : 
		Planning Time : 0.972 ms
		Execution Time : 243.667 ms

2. Seq Scans :
		Seq Scan on participation_defi pd  (cost=0.00..3606.89 rows=249989 width=8) (actual time=0.008..14.268 rows=249989 loops=1)
	  	Seq Scan on stream st  (cost=0.00..2137.00 rows=100000 width=24) (actual time=0.007..6.242 rows=100000 loops=1)
	  	Seq Scan on streamer s  (cost=0.00..1218.00 rows=16667 width=16) (actual time=0.008..3.621 rows=4999 loops=1)
	  	Seq Scan on defi d  (cost=0.00..851.00 rows=50000 width=14) (actual time=0.013..5.094 rows=50000 loops=1)

3. Les operations lourdes : 
		Seq Scan on participation_defi pd  (.... rows=249989 loops=1)
		Seq Scan on stream st  (.... rows=100000 loops=1)
		Seq Scan on defi d  (.... rows=50000 loops=1)
		Hash Join  (.... rows=52991 loops=1)
		HashAggregate  (.... rows=24735 loops=1)

4. la requête présente des performances élevées car elle repose sur des lectures complètes des tables (Seq Scan), 
ce qui oblige la base de données à parcourir l’ensemble des lignes sans utiliser d’index. 
Les jointures entre les différentes tables génèrent un volume important de données intermédiaires, et les opérations de regroupement et de tri augmentent encore le coût de traitement. 
Ainsi, plusieurs centaines de milliers de lignes sont manipulées, ce qui entraîne un temps d’exécution élevé et une charge importante sur le système
