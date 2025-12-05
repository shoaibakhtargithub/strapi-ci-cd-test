
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
