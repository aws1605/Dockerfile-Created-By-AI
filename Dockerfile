```
# Use the official Node.js 14 image as our base, which is slightly newer than the latest version in stable at the time of writing.
FROM node:14-alpine

# Set the working directory to /app. This is where we'll place our source code and application data.
WORKDIR /app

# Copy the contents of our current directory into the container at the specified path.
COPY package*.json ./

# Install dependencies.
RUN npm install --production

# Copy the rest of the application code (everything except for package*.json).
COPY . .

# Expose port 3000, in case we need it for debugging or other reasons.
EXPOSE 3000

# Run the command to start the development server. We're using multi-stage builds here,
# so this container doesn't have our production artifacts installed.
CMD ["npm", "start"]

# Multi-stage build: use a separate image for building the application, which includes all dependencies and build tools.
FROM node:14-alpine AS build

WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .
RUN npm run build

# Use another stage to create the production-ready image. This one only needs Node.js installed,
# as our application code is already copied over in the previous step.
FROM node:14-alpine

WORKDIR /app
COPY --from=build /app/dist ./dist/
CMD ["node", "dist/index.js"]
```