# feedback-flow

# Setup Process

## Environment Setup
- sudo apt install npm
- .NET 6.0 installation

**BackEnd**
- Visual Studio (ASP.NET)

**FrontEnd**
- npx create-react-app my-app [Install react]
  - Installing react, react-dom, and react-scripts with cra-template...
- install chakra framework

**Database**
- Entity Framework Core for data access
- SQL Server 2022 (Developer Edition) [60GB Free -> 56.9GB = 3GB Usage]
  - SQL Server Management Studio  21 with Visual Studio Installer [3GB]

## Running Steps
There are two apps, run them independently

- Step-1: Setup the database connection string (after installing SQL Server and SSMS) and run the API.Administration
- Step-2: Run the API.Client in case the swagger is needed
- Step-3: GoTo -> cd .\Agap2IT.Labs.LearingForum.Presentation\ -> client app
  - Run the following commands in Developer Command Prompt (depend on the npm setup to chose amond Powershell and Command Prompt)
    - npm install
    - npm start

# Snapshots
