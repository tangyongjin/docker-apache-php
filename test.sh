docker kill boss
sleep 1
docker run -it -d  --rm  -v /tang/nanx:/var/www/html -p 8090:80 --name  boss    xnet.base
