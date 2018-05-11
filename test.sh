docker kill base  
sleep 1
docker run -it -d  --rm  -v /root/dockers/proxy:/var/www/html -p 8000:80 --name  base    xnet.base
