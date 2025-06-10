# Data Science Docker Environment

This project provides a Dockerized environment for data science tasks, including support for NLP, data visualization, and database interaction with PostgreSQL and pgvector.

## Included Services

*   **Jupyter Notebook**: For interactive coding and notebooks.
*   **PostgreSQL with pgvector**: SQL database with support for vector similarity search.
*   **Superset**: For data exploration and visualization.
*   **FastAPI**: For building fast APIs (template, can be run within the main container).

## Prerequisites

*   Docker Desktop installed on your Windows machine.

## Setup and Running

1.  **Clone the repository (if you haven't already):**
    ```bash
    git clone <repository_url>
    cd <repository_directory>
    ```

2.  **Build and run the services using Docker Compose:**
    Open a terminal or PowerShell in the project's root directory (where `docker-compose.yml` is located) and run:
    ```bash
    docker-compose up --build
    ```
    The `--build` flag ensures images are built (or rebuilt if changes were made). Subsequent runs can omit `--build` if no changes to `Dockerfile` or related files were made.

3.  **Accessing Services:**
    *   **Jupyter Notebook**: Open your web browser and go to `http://localhost:8888`
        *   The Jupyter Notebook server is configured to run without a token for simplicity in this environment.
    *   **Superset**: Open your web browser and go to `http://localhost:8088`
        *   You may need to set up an admin account the first time you run Superset if it doesn't create one automatically.
        *   Default credentials (if created by an init script, which is commented out in the current `docker-compose.yml`): `admin` / `admin`. You might need to run the Superset initialization commands manually in the Superset container or uncomment the init command in `docker-compose.yml` if you want a pre-configured admin user.
        *   To initialize Superset manually (after `docker-compose up` is running):
            ```bash
            # Find your superset container name
            docker ps
            # Execute the init commands in the superset container
            docker exec -it <superset_container_name_or_id> superset fab create-admin --username admin --firstname Superset --lastname Admin --email admin@superset.com --password admin
            docker exec -it <superset_container_name_or_id> superset db upgrade
            docker exec -it <superset_container_name_or_id> superset init
            ```
    *   **PostgreSQL**: The database is accessible to other services within the Docker network at `postgres_db:5432`.
        *   Host port mapping: `localhost:5432`
        *   User: `user`
        *   Password: `password`
        *   Database name: `mydatabase`
    *   **FastAPI**: If you run a FastAPI application within the `datascience-env` container on port 8000, it will be accessible at `http://localhost:8000`.

4.  **Stopping the services:**
    Press `Ctrl+C` in the terminal where `docker-compose up` is running. To stop and remove the containers, you can run:
    ```bash
    docker-compose down
    ```

## Project Structure

*   `Dockerfile`: Defines the main data science environment.
*   `docker-compose.yml`: Orchestrates the services (datascience environment, PostgreSQL, Superset).
*   `requirements.txt`: Lists Python packages for the data science environment.
*   `superset_config.py`: Custom configurations for Superset.
*   `notebooks/`: (Recommended) Create this directory to store your Jupyter notebooks.
*   `src/`: (Recommended) Create this directory for your Python/FastAPI code.

## Notes

*   **Secrets**: The `docker-compose.yml` and `superset_config.py` contain default passwords and secret keys. **CHANGE THESE** for any sensitive or production-like environment.
*   **pgvector**: The `pgvector/pgvector:pg16` image is used for PostgreSQL, which comes with the `pgvector` extension pre-installed. You should be able to `CREATE EXTENSION vector;` in your database if it's not enabled by default.
*   **Superset Database Configuration**:
    *   After starting Superset, you'll need to configure a database connection to your PostgreSQL instance.
    *   Go to "Data" -> "Databases" in the Superset UI.
    *   Click the `+ Database` button.
    *   For SQLAlchemy URI, use: `postgresql://user:password@postgres_db:5432/mydatabase`
    *   Test the connection and save.

## Troubleshooting

*   **Port Conflicts**: If you have other services running on ports 8888, 8088, 8000, or 5432, you might need to change the port mappings in `docker-compose.yml` (e.g., `"8889:8888"`).
*   **Docker Issues**: Ensure Docker Desktop is running and has sufficient resources allocated.
```
