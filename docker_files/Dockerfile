Here's a sample Dockerfile that uses best practices to create a Node.js container:

```dockerfile
# Use an official Node.js 14 image as our base
FROM node:14

# Set the working directory in the container to /app
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./

RUN npm ci --only=production

# Copy the current directory contents into the container at /app
COPY . .

# Run npm commands to build your application
RUN npm run build

# Expose port 3000
EXPOSE 3000

# Use a non-interactive shell for production environment
USER node

CMD ["node", "index.js"]
```

Here's a brief explanation of the best practices used in this Dockerfile:

1. **Use an official Node.js image**: Instead of using a generic Linux distribution, we use an official Node.js 14 image as our base. This ensures that we have all the necessary dependencies and tools for building and running Node.js applications.

2. **Set the working directory to /app**: We set the working directory in the container to `/app`. This allows us to organize our files more efficiently and avoid polluting the root directory with unnecessary files.

3. **Copy package.json and install dependencies**: We copy `package.json` into the container and then use `npm ci --only=production` to install all the necessary dependencies. The `--only=production` flag ensures that we only install production dependencies, which is best practice for a Dockerized application.

4. **Copy the current directory contents into the container at /app**: After installing dependencies, we copy the current directory contents (i.e., our source code) into the container at `/app`. This allows us to easily switch between different environments and not worry about polluting the root directory with unnecessary files.

5. **Run npm commands to build your application**: We use `npm run build` to run any necessary commands for building our application. This command should be defined in our `package.json` file under the "scripts" key.

6. **Expose port 3000**: We expose port 3000, which is a common port for web servers. This allows other containers or services to communicate with this container using that port.

7. **Use a non-interactive shell for production environment**: In our production environment, we use a non-interactive shell (i.e., the `node` user) instead of the default `root` user. This is best practice as it reduces the risk of privilege escalation attacks and ensures that our application runs with minimal privileges.

8. **CMD ["node", "index.js"]**: Finally, we set the default command to run when the container starts. In this case, we run `node index.js`, which should be defined in our `package.json` file under the "scripts" key or in a separate script file. This ensures that our application runs correctly when the container starts.

This Dockerfile uses best practices for building and running Node.js applications and provides a solid foundation for your project.