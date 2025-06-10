# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
# - postgresql-client for psql and other PostgreSQL utilities
# - build-essential for compiling some Python packages if needed from source
RUN apt-get update && apt-get install -y --no-install-recommends     postgresql-client     build-essential     && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container at /app
COPY requirements.txt ./

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8888 available to the world outside this container for Jupyter
EXPOSE 8888
# Make port 8088 available for Superset
EXPOSE 8088
# Make port 8000 available for FastAPI
EXPOSE 8000

# Define environment variable for Jupyter
ENV JUPYTER_ENABLE_LAB=yes

# Run jupyter notebook when the container launches
# Allow connections from any IP address and run on port 8888
# --allow-root is used because the default user in the container is root
# --NotebookApp.token='' and --NotebookApp.password='' disable token authentication for simplicity in this environment.
# For a production environment, you should configure proper authentication.
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
