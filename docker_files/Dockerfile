Here is an ideal Dockerfile for a Node.js application that follows best practices:

```
# Use an official Node.js 14.x image as our base image
FROM node:14.17.0-alpine

# Set the working directory in the container to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install dependencies specified in package.json
RUN npm install

# Make port 3000 available to the world outside this container
EXPOSE 3000

# Run app.js using node when the container launches
CMD ["node", "app.js"]

# Multi-stage build for a faster and smaller image
FROM node:14.17.0-alpine as builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:14.17.0-alpine

WORKDIR /app

COPY --from=builder /app/dist/ .

CMD ["node", "dist/app.js"]
```

Let me explain the different parts:

1. `FROM node:14.17.0-alpine`: We're using an official Node.js 14.x image as our base image.
2. `WORKDIR /app`: We set the working directory in the container to `/app`.
3. `COPY . /app`: We copy the current directory contents into the container at `/app`. This includes your source code, package.json file, and any other files you want to include.
4. `RUN npm install`: We run the command `npm install` to install all dependencies specified in package.json.
5. `EXPOSE 3000`: We make port 3000 available to the world outside this container. This means that if you run a container from this image and map port 3000 on your host machine, you'll be able to access your application at http://localhost:3000.
6. `CMD ["node", "app.js"]`: We set the default command to run when the container launches. In this case, we're running `node app.js`, which means that your Node.js application will start automatically when you run a container from this image.

The multi-stage build:

1. The first stage (`FROM node:14.17.0-alpine`) is for building the application.
2. We copy the package*.json files to get the dependencies and install them with `npm install`.
3. We copy our source code into the builder container.
4. We run `npm run build` to compile or bundle our application (if necessary).
5. The second stage (`FROM node:14.17.0-alpine`) is for running the application.
6. We copy the compiled code from the builder container into this new container.
7. We set the default command to run when the container launches, which is `node dist/app.js`. This means that your Node.js application will start automatically when you run a container from this image.

By using a multi-stage build, we can reduce the size of our final Docker image by only including the necessary files and not installing development dependencies.