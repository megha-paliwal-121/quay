# Use a Python base image to install dependencies
FROM python:3.9-slim as builder

# Set the working directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY app.py .

# Use a distroless base image
FROM gcr.io/distroless/python3

# Copy the installed packages and application code from the builder stage
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /app/app.py /app/app.py

# Specify the command to run the application
CMD ["app.py"]
