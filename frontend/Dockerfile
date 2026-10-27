# Dockerfile (multi-stage):

# Build Stage: Build the static assets using Node.js.
FROM node:24 AS build-stage
# Set /usr/src/app as working directory.
WORKDIR /usr/src/app
# --chown=node:node: Changes file ownership of everything being copied to belong to User named 'node' and Group named 'node' inside the container.
# package*.json ./: Copy dependency definitions first, to enable layered caching.
COPY --chown=node:node package*.json ./
# Install dependencies using npm ci for reproducible production builds.
RUN npm ci
# Copy the remaining source code with ownership as 'node'.
COPY --chown=node:node . .
# Capture build arg for API endpoint (defaults to relative /api for proxy routing)
ARG VITE_BACKEND_URL=/api
ENV VITE_BACKEND_URL=$VITE_BACKEND_URL
# Compile the application into static production files inside the /dist directory.
RUN npm run build

# Release Stage: Serve the static files using an Nginx server.
FROM nginx:1.29-alpine AS release-stage
# COPY the directory dist from the build-stage into Nginx's public folder (/usr/share/nginx/html)
COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html