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
# Document the default Vite development server port. Defined by ports: mapping in our docker-compose.dev.yml file.
EXPOSE 5173
# Start the Vite development server and bind it to 0.0.0.0 (--host) so it can accept traffic outside the container network.
CMD ["npm", "run", "dev", "--", "--host"]