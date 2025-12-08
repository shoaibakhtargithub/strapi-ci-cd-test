
### **day1 Work**
- Cloned the provided Strapi project from GitHub
- Installed dependencies and ran Strapi locally
- Created "Article" collection type in Strapi
- Verified that MySQL tables were created
- Pushed initial Strapi setup to the `shoaib` branch

# **day2 – Strapi Backend**

- Strapi API with MySQL
- Dockerfile added
- .dockerignore for smaller image size
- Todos collection added
- Works with local MySQL via host.docker.internal
- then created docker image 
- after created i am running this image to create container 
- and successfully created container and run application

# **day3 - work**

- Created Docker setup with a user-defined network strapi-net.
- Added PostgreSQL container with credentials via environment variables.
- Built Strapi container (Dockerfile) and configured it to use Postgres via environment variables.
- Added Nginx reverse proxy container exposing host port 80 to Strapi on port 1337.
- Tested locally: Strapi Admin available at http://localhost/admin.

**day4 - work**
1. Problem Docker Solves
- Docker is a platform that lets you run applications inside lightweight containers. These containers include everything the app needs—settings, libraries, and dependencies—so the application runs the same on any system, without setup issues or conflicts.

Software used to run differently on different machines. Developers often faced issues like
- Heavy virtual machine usage that consumed large resources
- "It works on my machine" problems
- Complex setup and dependency conflicts

Docker solves this by:
- Packaging applications with all dependencies
- Making the environment consistent everywhere
- Ensuring lightweight and fast deployments
- Allowing isolated application containers

2. Virtual Machines vs Docker
Virtual Machines (VMs)
- Each VM includes a full OS, applications, and binaries
- Heavy and slow to boot
- Uses large system resources
- Hypervisor required

Docker Containers
- Share the host OS kernel
- Very lightweight
- Fast startup (seconds)
- Uses less RAM and CPU

3. Architecture of Docker 

All components of docker
1. Docker Client (CLI)
- You interact with Docker using the CLI (docker run, docker build)
- Sends commands to Docker Daemon through REST API

2. Docker Daemon (dockerd)
- Runs in the background
- Manages images, containers, networks, and volumes

3. Docker Images & Containers
- Images = blueprints which is used to create container 
- Containers = running instances of images

4. Docker Registry
- Default: Docker Hub it is used to store images 
- Stores and pulls images

4. Everythings about dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
- FROM node:18-alpine – Selects the base image; here it's Node.js lightweight Alpine Linux
- WORKDIR /app – Sets the working directory inside the container
- COPY package.json ./* – Copies dependency files first for caching
- RUN npm install – Installs project dependencies
- COPY . . – Copies the entire codebase into the container
- EXPOSE 3000 – Specifies the app will run on port 3000
- CMD ["npm", "start"] – Default command that runs when container starts

5. Key Docker Commands
Images
- docker pull image-name – Download image
- docker images-name – List images
- docker rmi image-name – Remove image

Containers
- docker run image-name – Run a new container
- docker ps – List running containers
- docker ps -a – All containers
- docker stop container-id – Stop container
- docker rm container-id – Remove container

Build
- docker build -t myapp . – Build image from Dockerfile

6. Everythings about Docker Networking

Command used to create custom network
- docker network create mynetwork

1. Bridge Network (default)
- Containers communicate with each other using internal IPs
- Most commonly used network in docker
2. Host Network
- Removes isolation
- Container shares host network stack
- less secure than the bridge network
3. None
- No network assigned

7. Volumes & Persistence
- Containers are temporary. If a container is deleted, data inside it is lost.
- Volumes solve this problem by storing data outside the container.

Types of Storage:
- Volumes → Managed by Docker 
- Bind Mounts → Maps a local system directory
Command used to create volume
- docker volume create mydata

8. Docker Compose
- Docker Compose is a tool to run multi-container applications.
Benefits:
- One command deployment
- Easy multi-container networking
- Environment management

Example of docker compose file
version: "3.8"
services:
  postgres:
    image: postgres:15
    container_name: strapi-postgres
    restart: unless-stopped
    env_file: .env
    environment:
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
      - POSTGRES_DB=${POSTGRES_DB}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - strapi-net

  strapi:
    image: shoaib-strapi-app:latest
    container_name: strapi-app
    restart: unless-stopped
    env_file: .env
    environment:
      - DATABASE_CLIENT=postgres
      - DATABASE_HOST=postgres
      - DATABASE_PORT=5432
      - DATABASE_NAME=${POSTGRES_DB}
      - DATABASE_USERNAME=${POSTGRES_USER}
      - DATABASE_PASSWORD=${POSTGRES_PASSWORD}
    depends_on:
      - postgres
    ports:
      - "1337:1337"
    networks:
      - strapi-net

  nginx:
    image: nginx:stable-alpine
    container_name: strapi-nginx
    restart: unless-stopped
    ports:
      - "80:80"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - strapi
    networks:
      - strapi-net

volumes:
  postgres_data:

networks:
  strapi-net:
    external: true



