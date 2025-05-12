# Homework 3 - Build and Run Commands

# Build Commands

#### docker build -t backend ./backend

docker build: This command builds a Docker image from a Dockerfile.

-t frontend: The -t flag tags the image with the name backend.

./backend: This specifies the build context, the directory containing the Dockerfile and any other necessary files for the image. In this case, it means the Docker build context is the frontend subdirectory of your current location.

#### docker build -t frontend ./frontend

docker build: This command builds a Docker image from a Dockerfile.

-t frontend: The -t flag tags the image with the name frontend.

./frontend: This specifies the build context, the directory containing the Dockerfile and any other necessary files for the image. In this case, it means the Docker build context is the frontend subdirectory of your current location.

# Run Commands

#### docker run -d --name backend --network testnet backend

-d: Runs the container in detached mode (in the background).

--name backend: Names the container backend.

--network testnet: Connects the container to the testnet network.

backend: This is the name of the image being run.

#### docker run -d --name frontend --network apinet -p 5001:5001 frontend

-d: Run the container in detached mode.

--name frontend: Names the container frontend.

--network apinet: Connects the container to the apinet network.

-p 5001:5001: Maps port 5001 of the host to port 5001 of the container.

frontend: Refers to the Docker image built earlier using docker build.