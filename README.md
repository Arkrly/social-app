# Social App

A Java web application with user authentication, posts, and messaging functionality.

## 🐳 Quick Start with Docker

### Prerequisites
- [Docker](https://www.docker.com/get-started) (20.10+)
- [Docker Compose](https://docs.docker.com/compose/install/) (2.0+)

### Run the Application

```bash
# Clone and navigate to the project directory
cd SocialApp

# Start all services (MySQL + Tomcat)
docker-compose up --build

# Or run in detached mode
docker-compose up -d --build
```

Access the application at: **http://localhost:8080/app/**

### Stop the Application

```bash
# Stop and remove containers
docker-compose down

# Stop and remove containers + volumes (deletes database data)
docker-compose down -v
```

## ⚙️ Configuration

### Environment Variables

Create a `.env` file from the example:

```bash
cp .env.example .env
```

| Variable | Description | Default |
|----------|-------------|---------|
| `DB_ROOT_PASSWORD` | MySQL root password | `rootpassword` |
| `DB_NAME` | Database name | `social_db` |
| `DB_USER` | Application database user | `socialuser` |
| `DB_PASSWORD` | Application database password | `socialpassword` |

## 🛠️ Development Setup

### Without Docker (Local Development)

1. **Install Prerequisites**
   - Java 21+
   - Maven 3.9+
   - MySQL 8.0+

2. **Set up MySQL**
   ```sql
   CREATE DATABASE social_db;
   ```
   Import the schema:
   ```bash
   mysql -u root -p social_db < docker/init.sql
   ```

3. **Set Environment Variables**
   ```bash
   # Windows PowerShell
   $env:DB_HOST="localhost"
   $env:DB_PORT="3306"
   $env:DB_NAME="social_db"
   $env:DB_USER="root"
   $env:DB_PASSWORD="your_password"
   ```

4. **Build and Deploy**
   ```bash
   mvn clean package
   # Deploy target/app.war to your Tomcat server
   ```

## 📁 Project Structure

```
app/
├── docker/
│   └── init.sql           # Database initialization script
├── src/
│   └── main/
│       ├── java/
│       │   ├── controller/  # Servlet controllers
│       │   ├── dao/         # Data Access Objects
│       │   ├── model/       # Entity models
│       │   └── util/        # Utility classes (DB connection)
│       ├── resources/
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml
│           ├── login.jsp
│           └── register.jsp
├── .dockerignore
├── .env.example
├── .gitignore
├── docker-compose.yml
├── Dockerfile
├── pom.xml
└── README.md
```

## 🔧 Tech Stack

- **Backend**: Java 21, Jakarta EE 9+ (Servlets, JSP, JSTL)
- **Database**: MySQL 8.0
- **Build Tool**: Maven
- **Server**: Apache Tomcat 10.1
- **Containerization**: Docker & Docker Compose

## 📝 License

This project is for educational purposes.
