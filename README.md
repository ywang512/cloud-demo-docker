# cloud-demo-docker

*A simple demo of docker*

### Docker 101

- [Brief intro](https://docs.docker.com/v17.09/get-started/#a-brief-explanation-of-containers)

- [Containers vs. virtual machines](https://docs.docker.com/v17.09/get-started/#containers-vs-virtual-machines)

- [Image layers](https://docs.docker.com/v17.09/engine/userguide/storagedriver/imagesandcontainers/#images-and-layers) and [container layers](https://docs.docker.com/v17.09/engine/userguide/storagedriver/imagesandcontainers/#container-and-layers)

### Get Started with `Dockerfile`

`Dockerfile` will define what goes on in the environment inside your container. Access to resources like networking interfaces and disk drives is virtualized inside this environment, which is isolated from the rest of your system, so you have to map ports to the outside world, and be specific about what files you want to “copy in” to that environment. Because of this, the build of your app defined in this `Dockerfile` will behave exactly the same wherever it runs.

Here is an example of what a typical `Dockerfile` might looks like,

```Dockerfile
# Use an official Python runtime as a parent image
FROM python:3.7-stretch

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
# ADD can also do this, plus sourcing from URLs or unpacking local tar files 
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
# This provides defaults for an executing container
CMD ["python", "app.py"]
```

### App itself

Then you will create some files related to our app itself. `app.py` is the app script. `requirements.txt` provides the necessary dependencies for our app. `Makefile` defines a set of tasks for easily execution. 

### Build the app

To start with, you need to build our app by running

```bash
docker build -t docker-demo .
```

This build up an image specified by `Dockerfile` in current directory `.` and use `-t` to add a tag to this image. We can use `docker image ls` or `docker images` to list all the images. The result should look like

```bash
ec2-user:~/environment/cloud-demo-docker (master) $ docker image ls

REPOSITORY                   TAG                 IMAGE ID            CREATED                  SIZE
docker-demo                  latest              83e1dffdad6e        About a minute ago       954MB
```

### Run the app

Then you need to use `docker` to run our app in the image, by

```bash
docker run docker-demo
```

You can also use 

```bash
docker run -it docker-demo bash
```

to run a `bash` command line inside the container. You can also add `-d` option to activate the detached mode, and use `docker container ls` or `docker ps` to show a list of active containers.

### Share your image

First, you need to login your Docker account using your docker id and password.

```bash
docker login
```

Then, you should tag your image with your docker username, repository and tag names.

```bash
docker tag docker-demo ywang512/cloud-demo-docker
```

Finally, you could upload the tagged image to your repository.

```bash
docker push ywang/cloud-demo-docker
```

From now on, you can run your app on any machine from your remote repository.

```bash
docker run ywang/cloud-demo-docker
```

### Cheat sheet

A list of basic Docker commands for future review.

```bash
docker build -t docker-demo .             # Create image using this directory's Dockerfile
docker run -it docker-demo bash                        # Run "docker-demo" with a bash CLI
docker run -d -it docker-demo                           # Same thing, but in detached mode
docker container ls                                          # List all running containers
docker ps                                                                     # Same thing
docker container ls -a                       # List all containers, even those not running
docker container stop <hash>                     # Gracefully stop the specified container
docker container kill <hash>                   # Force shutdown of the specified container
docker container rm <hash>                  # Remove specified container from this machine
docker container rm $(docker container ls -a -q)                   # Remove all containers
docker container prune                                     # Remove all stopped containers
docker image ls -a                                       # List all images on this machine
docker images -a                                                              # Same thing
docker image rm <image id>                      # Remove specified image from this machine
docker image rm $(docker image ls -a -q)             # Remove all images from this machine
docker login                       # Log in this CLI session using your Docker credentials
docker tag <image> username/repository:tag            # Tag <image> for upload to registry
docker push username/repository:tag                      # Upload tagged image to registry
docker run username/repository:tag                             # Run image from a registry
```

### Useful links

- [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)

- [How to choose a docker base](https://pythonspeed.com/articles/base-image-python-docker-images/)




Mores to come ......
