# Superset specific configurations
# You can extend this file with more configurations as needed.

# Example: Make Superset use a specific SECRET_KEY if not set by environment variable
# import os
# SECRET_KEY = os.environ.get('SUPERSET_SECRET_KEY', 'this_is_a_default_secret_key_change_it')

# Example: Configure the rate limit for CsvToDatabaseView
# CSV_TO_DATABASE_MAX_ROWS = 200000

# Example: Enable template processing for SQL Lab
# ENABLE_TEMPLATE_PROCESSING = True

# If you want Superset to store its metadata in the PostgreSQL database:
# SQLALCHEMY_DATABASE_URI = 'postgresql://user:password@postgres_db:5432/mydatabase'
# Note: Ensure 'mydatabase' is also used by Superset for its own tables, or use a separate one like 'superset_metadata'

print("Custom superset_config.py loaded")
