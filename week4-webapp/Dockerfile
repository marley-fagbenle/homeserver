# User the official Python image as a base
From python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages as specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside of container
EXPOSE 5000

# Run app.py when container launches
CMD ["python", "app.py"]
