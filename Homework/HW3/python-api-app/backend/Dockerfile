# --- Build Stage ---
# Use official Python image
FROM python:3.11-slim as builder

# Set the working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --user --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY backend_app.py .

# --- Runtime Stage ---
FROM python:3.11-slim

WORKDIR /app

COPY --from=builder /root/.local /root/.local
COPY backend_app.py .

# Set environment variables
ENV PATH=/root/.local/bin:$PATH

# Expose the port the app runs on
EXPOSE 5000

# Run the application
CMD ["python", "backend_app.py"]