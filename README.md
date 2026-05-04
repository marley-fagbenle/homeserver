# Continuous Deployment Web Server

**Author:** Marley Fagbenle  
**Course:** Unix Programming  

## Project Overview
This repository contains a fully automated Continuous Deployment (CD) pipeline that I built from scratch. The project features a Python Flask web application that is containerized with Docker, version-controlled via a self-hosted Gitea server, and automatically deployed using custom Git server hooks.

The primary goal of this project was to eliminate the need for manual server updates. Instead of manually stopping, rebuilding, and restarting the web server for every code change, I configured the server to automatically handle the deployment process the moment new code is pushed.

## Technologies Used
* **Application:** Python, Flask
* **Containerization:** Docker, Docker Compose
* **Version Control:** Git, Self-Hosted Gitea
* **Automation:** Bash Scripting (Git Server Hooks)
* **Environment:** WSL (Ubuntu), Alpine Linux
* **Database:** PostgreSQL

## System Architecture
My project infrastructure is divided into three main components that work together:

1. **Local Workspace (WSL):** The development environment where I write and test the application code and Docker configurations.
2. **Version Control (Gitea Server):** A private, containerized Git server that stores the codebase and acts as the trigger for deployments.
3. **Production Server (Docker):** The live environment where the web application is hosted and served to users.

## The Automation Pipeline
To achieve continuous deployment, I wrote a custom Bash script (`post-receive` hook) that runs directly on the Gitea server. When I push new code to the `main` branch, the following automated sequence occurs:

1. **Environment Prep:** The script unsets hidden Git environment variables to prevent deployment conflicts.
2. **Code Extraction:** The latest code is extracted directly from the internal Gitea database into a fresh, temporary build directory.
3. **Image Build:** The host machine's Docker engine builds a new Docker image based on the updated `Dockerfile`.
4. **Container Swap:** The outdated production container is safely stopped and removed.
5. **Deployment:** A new container is launched with the updated application, exposed on port 5000.
6. **Cleanup:** Temporary build directories are deleted to free up server memory.

## How to Run Locally
If you would like to run this infrastructure locally, ensure you have Docker and Docker Compose installed on your machine.

**1. Clone the repository:**
`git clone https://github.com/Omarleymo/homeserver-project.git`
`cd homeserver-project`

**2. Start the infrastructure (Gitea & Postgres):**
`docker-compose up -d`

**3. Run the Web App independently:**
`docker build -t my-web-app:latest .`
`docker run -d -p 5000:5000 --name webapp-prod my-web-app:latest`

**4. View the App:**
Open a web browser and navigate to `http://localhost:5000`

## Project Reflection
Building this project provided hands-on experience navigating strict Linux permissions, troubleshooting lightweight package managers, and managing complex Docker networking. It served as a practical demonstration of how to integrate standard Unix tools to build a professional, automated development workflow.
