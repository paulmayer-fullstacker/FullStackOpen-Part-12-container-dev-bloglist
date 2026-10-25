# Use lightweight Node.js image built on Alpine Linux (keep image size small).
FROM node:20-alpine
# Set working directory to be used inside the container (for all subsequent commands).
WORKDIR /usr/src/app
# Copy package configuration files first, to leverage Docker layer caching.
COPY package*.json ./
# Install all dependencies (including devDependencies like nodemon), defined in the package.json.
RUN npm install
# Copy the remaining backend source code into the container.
COPY . .
# Document the port the backend listens on internally. Defined by ports: mapping in our docker-compose.dev.yml file.
EXPOSE 3003
# Run the app using the 'dev' script (which uses Node's native --watch flag for automatic reloads on development updates).
CMD ["npm", "run", "dev"]