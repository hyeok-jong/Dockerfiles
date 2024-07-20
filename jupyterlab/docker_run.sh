docker build -t IMAGENAME .


docker run -d --name=IMAGENAME --gpus all \
-it --shm-size=1024g --ulimit memlock=-1 --ulimit stack=67108864 \
-p 8887:8887 \
--mount type=bind,source=/home/,target=/home/ \
--mount type=bind,source=/jbod,target=/jbod \
CONTAINERNAME \
jupyter lab --no-browser --port=8887 --ip=0.0.0.0 --allow-root \
--certfile=/home/cert/mycert.pem --keyfile=/home/cert/mykey.key
