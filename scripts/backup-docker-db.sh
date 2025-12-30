docker exec fablabsio-db-1 pg_dumpall -c -U postgres | gzip > backup/dump_`date +%Y-%m-%d"_"%H_%M_%S`.sql.gz
