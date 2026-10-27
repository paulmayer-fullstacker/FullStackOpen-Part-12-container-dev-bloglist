# Dockerfile

# Set the base for the image as node:24.
FROM node:24
# Set /usr/src/app as working directory. If the directory doesn't exist in the base image, it will be created.
WORKDIR /usr/src/app
# --chown=node:node: Changes file ownership of everything being copied to belong to User named 'node' and Group named 'node' inside the container.
# package*.json ./: Copy dependency definitions first, to enable layered caching.
COPY --chown=node:node package*.json ./
# Install dependencies using npm ci for reproducible production builds.
RUN npm ci
# Copy the remaining source code with ownership as 'node'.
COPY --chown=node:node . .
# Switch user context inside the container from the default root user to the built-in (unprivileged), 'node' user.
USER node
# CMD specifies default command that runs when we start a container with docker run (can be overwritten).
# ["npm", "start"]: # Start the app, per the package.json script 'start'.
CMD ["npm", "start"]

#
# Build image: docker build -t backend .
# Run as container: docker run -p 3000:3000 backend
#