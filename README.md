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

2.  **Build and run all services using Docker Compose:**
    Open a terminal or PowerShell in the project's root directory (where `docker-compose.yml` is located) and run:
    ```bash
    docker-compose up --build
    ```
    This command will build the Docker images (the first time or if changes were made) and start all defined services: the Data Science Environment (with Jupyter Notebook running automatically), PostgreSQL, and Superset. Subsequent runs can omit `--build` if no changes to `Dockerfile` or related files were made.

3.  **Accessing Services:**
    Once the containers are running (you'll see logs in your terminal), you can access the services:

    *   **Jupyter Notebook**:
        *   URL: `http://localhost:8888`
        *   The Jupyter Notebook server starts automatically and is configured to run without a token for simplicity.
        *   **Note on Notebooks**: Your notebooks should be created or placed in the root directory of this project (or subdirectories like a `notebooks/` folder you create) to be accessible and persisted, as this directory is mounted into the `/app` directory in the container.

    *   **Superset**:
        *   URL: `http://localhost:8088`
        *   You may need to set up an admin account the first time you run Superset.
        *   Default credentials (if created by an init script): `admin` / `admin`.
        *   To initialize Superset manually (if needed, after `docker-compose up` is running):
            ```bash
            # Find your superset container name/ID
            docker ps
            # Execute the init commands in the superset container
            docker exec -it <superset_container_name_or_id> superset fab create-admin --username admin --firstname Superset --lastname Admin --email admin@superset.com --password admin
            docker exec -it <superset_container_name_or_id> superset db upgrade
            docker exec -it <superset_container_name_or_id> superset init
            ```

    *   **PostgreSQL**:
        *   Host port mapping: `localhost:5432` (for connecting with external tools like pgAdmin).
        *   Service name for internal Docker network: `postgres_db:5432` (e.g., for Superset or your Python code).
        *   User: `user`
        *   Password: `password`
        *   Database name: `mydatabase`

    *   **FastAPI**:
        *   URL: `http://localhost:8000`
        *   This port is exposed from the `datascience-env` container. If you run a FastAPI application (e.g., using `uvicorn main:app --host 0.0.0.0 --port 8000`) inside that container, it will be accessible here.

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
