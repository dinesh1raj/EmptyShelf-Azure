# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory to /app
WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    python3-dev build-essential gcc ffmpeg libsm6 libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements.txt into the container at /app
COPY requirements.txt /app/requirements.txt

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . /app

# Make port 8001 available to the world outside this container
EXPOSE 8003

# Define environment variable for log location
# ENV LOG_LOCATION /logs

# Make sure the log directory exists
# RUN mkdir -p $LOG_LOCATION

# Define environment variable
ENV NAME IDCardDetection

# Run app.py when the container launches
RUN chmod +x /app/entrypoint.sh
CMD ["sh", "entrypoint.sh"]
