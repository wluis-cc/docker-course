# --- Build Stage ---
# Use official Python image
FROM python:3.11-slim as builder

# Set the working directory
WORKDIR /app

# Copy requirements file
COPY front-end_requirements.txt .

# Install dependencies
RUN pip install --user --no-cache-dir -r front-end_requirements.txt

# Copy the rest of the application code
COPY frontend_app.py .

# --- Runtime Stage ---
FROM python:3.11-slim

WORKDIR /app

COPY --from=builder /root/.local /root/.local
COPY frontend_app.py .

# Set environment variables
ENV PATH=/root/.local/bin:$PATH

# Expose the port the app runs on
EXPOSE 5001

# Run the application
CMD ["python", "frontend_app.py"]