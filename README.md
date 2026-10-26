# Full Stack Open: FullStackOpen-Part-12-containerised-dev-bloglist

## The Solution:

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

<br/>

<hr style="height: 5px; background-color: black; border: none;">
