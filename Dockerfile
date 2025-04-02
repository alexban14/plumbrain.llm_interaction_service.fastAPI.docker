FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install system dependencies required for building Python packages and running the app
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    libgl1-mesa-glx \
    libpq-dev \
    autoconf \
    gcc \
    make && \
    apt-get -y install tesseract-ocr && \
    rm -rf /var/lib/apt/lists/*

# Install Poetry globally
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    export PATH="/root/.local/bin:$PATH" && \
    poetry config virtualenvs.create false

# Install Uvicorn and Gunicorn globally
RUN pip install --no-cache-dir uvicorn gunicorn

# Remove unnecessary build dependencies for smaller images
RUN apt-get purge -y build-essential && apt-get autoremove -y
