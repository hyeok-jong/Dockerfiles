docker run -d --name=hyeokjong_vscode_web_8887 --gpus all \
-it --shm-size=1024g --ulimit memlock=-1 --ulimit stack=67108864 \
-p 8887:8887 \
--mount type=bind,source=/home/,target=/home/ \
--mount type=bind,source=/jbod,target=/jbod \
hyeokjong_vscode_web_8887
