# Full Stack Open: FullStackOpen-Part-12-containerised-dev-bloglist

## Exercise-22 - Containerised Development Environment

The FullStackOpen-Part-12-containerised-dev-bloglist repository now implements a complete containerised application comprising backend, frontend and Nginx reverse proxy service (single point of entry). The app relies on a remote MongoDb database, hosted in a MongoDB Atlas cluster. The implementation is in fulfilment of Module-12, Exercise-22.

### Tasks and Challenges

- We orchestrated our frontend (Vite), backend (Express), and proxy (nginx:alpine) inside a functional Docker Compose development environment.

- Resolved container communication, path mapping, environment variable injection (MONGODB_URI and SECRET), and database seeding.

- Validated live backend API routes successfully using the VS Code REST Client.

- Cleanly initialised our git repository, structuring our .gitignore and .dockerignore files, and commited our code to GitHub.

### Prerequisites:

To run this project locally, you will need:

- [Docker](https://www.docker.com/) and Docker Compose installed on your machine.
- A MongoDB database instance (e.g., a free cluster on [MongoDB Atlas](https://www.mongodb.com/atlas/database)).

### Installation & Setup:

- Clone the repository:

```bash
  git clone https://github.com/paulmayer-fullstacker/FullStackOpen-Part-12-container-dev-bloglist.git
  cd FullStackOpen-Part-12-container-dev-bloglist
```

- Create a .env file in the root directory:

```env
  PORT=3003
  MONGODB_URI=your_mongodb_connection_string_here
  SECRET=your_jwt_secret_key_here
```

Note: Dependencies are installed automatically inside the Docker containers during the build process. Thus, we do not need to run npm install on your host machine to run the application. However, should we wish to inspect the code (using IntelliSense), or run the application locally, we should run `npm install` inside `./frontend` and `./backend`.

### Running the App:

- Clean up old containers:

```bash
  docker compose -f docker-compose.dev.yml down
```

- Build and run:

```bash
  docker compose -f docker-compose.dev.yml up --build
```

- Test with browser:

```
  http://localhost:8080
```

- Test with REST Client:

```
  backend/request.rest
```

---

## Exercise-23 - Production Deployment & Containerization

In fulfillment of Exercise 23, the repository has been extended to include a production-ready, multi-stage containerised environment. Unlike the development setup which relies on volume mounts and live-reload development servers, the production setup optimises images for performance, security, and minimal footprint.

### How It Works (Architecture & Optimizations):

- Frontend Multi-Stage Build (frontend/Dockerfile): The frontend service utilises a multi-stage Node build to install dependencies (npm ci with --chown=node:node ownership layer caching) and compile static production assets (npm run build), then copies only the compiled /dist output into a lean nginx:alpine release image.

- Backend Production Build (backend/Dockerfile): The backend service leverages non-root user security (USER: node), layer caching, and reproducible production dependency installation.

- Nginx Gateway (nginx.conf): The Nginx production gateway serves as the single point of entry on host port 8080, routing static file requests to the frontend service and cleanly proxying /api/ traffic directly to the Express backend container.

- Environment Isolation: The production environment consumes secure production configuration parameters via a root .env file injected dynamically via Docker Compose.

### Running the Production Environment:

- Clean up existing containers:

```bash
  docker compose down -v
```

- Reseed the Database:

  Optional, but recommended, to reset and reseed the remote MongoDB Atlas database before testing.

```bash
  cd backend
  npm run seed
  cd ..
```

- Build and run the production stack:

  Build the multi-stage images and spin up the production services in detached mode:

```bash
  docker compose up --build -d
```

- Verify Running Containers:

  Check that the production proxy, backend, and frontend containers are all running.

```bash
  docker ps
```

- Test the Application:
  - Frontend UI (React App): Open http://localhost:8080 in the browser.

  - Backend API (Proxied via Nginx): Open http://localhost:8080/api/blogs to verify raw JSON data from MongoDB Atlas.

---

<br/>

<hr style="height: 5px; background-color: black; border: none;">
