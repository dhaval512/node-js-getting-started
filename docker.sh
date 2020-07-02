#/bin/bash
docker stop heroku
docker rm heroku
docker rmi heroku
docker build -t heroku .
docker run -d --name heroku -p 3000:5000 heroku
