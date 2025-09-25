# Use a newer Python base image with latest security patches
FROM python:3.12-slim-bookworm

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements first (for better Docker caching)
COPY src/requirements.txt .

RUN pip install --upgrade pip==25.2

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire `src` directory
COPY src /app/src

# Set Python path so the `api` module can be found
ENV PYTHONPATH=/app/src

# Expose the FastAPI port
EXPOSE 8000

# Start the FastAPI app
CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]