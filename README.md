# Dockerfiles  

This repository provide two examples of dockerfile.  
1. Dockerfile for Jupyterlab.
2. Dockerfile for vscode-server (vscoder for web).  

# 0. Things to Know  
- Check Ubuntu version: `lsb_release -a`  
- Check currently listening ports: `netstat -tuln | grep LISTEN`  
- Get NVIDIA CUDA Image: [NVIDIA CUDA Documentation](https://docs.nvidia.com/deeplearning/frameworks/pytorch-release-notes/rel_22-01.html)  
  If you need a CUDA image for training models (not for deployment), get the development (devel) version.  
- Basic tmux commands (or use nohup) for background training:  
```bash
tmux new -s session_name  
# To detach from the tmux session, press: Ctrl + b, then d  
tmux ls  
tmux attach -t session_name  
tmux kill-session -t session_name  
```  
- It is possible to run two different Docker containers from the same Docker image with different ports. The Docker containers can have different environments. For example, if you install different pip packages in each, they will not be shared.

Enter a Docker container in the terminal: `docker exec -it container_name /bin/bash`  

# 1. Basic Concept of Docker  
Docker can set up environments more deeply than conda.  
Here's the order:  
1. Docker Image  
2. Docker Container  

# 2. Docker Image (docker build)  
Dockerfile -> Docker Image  
Navigate to the directory where the Dockerfile is located.  
Use: `docker build -t image_name .` or `docker build -t image_name --no-cache .`  
This command creates a Docker image based on the Dockerfile.  
After building, you can check the available images with: `docker images | head -n 100`  

# 3. Docker Container  
Once you have built the Docker image, create a Docker container:  
Use: `docker create --name container_name image_name`  
After creating the Docker container, you can view it with: `docker container ls -a`  
Start the container with: `docker start container_name`  
Alternatively, you can create and start a container in one command with: `docker run --name container_name image_name`  
Check running containers with: `docker ps`  

# 4. After Running  
For debugging, use: `docker logs container_name`  
To stop and remove a container, use:  
- `docker stop container_name`  
- `docker rm container_name`  
- `docker rmi image_name` (to remove the image if needed)  

```python
from jupyter_server.auth import passwd
pw = 'pw'
passwd(pw, algorithm='sha1')
# Output: 'sha1:94511993bf59:49abb59252abccdf02693b3bc2ad15526254d3a0'
```
