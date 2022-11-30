# Deploy
docker stack deploy -c docker-compose.yml sister
docker service ls

## Backup
docker exec -it $(docker ps -f name=sister_dbclient -q) find /data/

## Populate some data
$ docker exec -it $(docker ps -f name=sister_dbclient -q) mysql -uroot -ppassword -h dblb
MySQL [(none)]> create table mydb.foo (name varchar(10));
MySQL [(none)]> insert into mydb.foo values('ruan');
MySQL [(none)]> exit

## Scale cluster
docker service scale sister_dbcluster=3

## Verify Scaled
docker service ls

## Test Reading
docker exec -it $(docker ps -f name=sister_dbclient -q) mysql -uroot -ppassword -h dblb -e'select * from mydb.foo;'

# Simulate failure
docker kill [container_id]

## Verify 
docker service ls


