
# Microsoft SQL Server dev env

## 1. Start the SQL Server make sure DockerDesktop is running, then:

    > docker-compose up

  or 

    > docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=yourStrong(!)Password" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-latest

## 2. Load the database file (db_init.sql) into the database, however you see fit.

  I used [SSMS](https://docs.microsoft.com/en-us/sql/ssms/sql-server-management-studio-ssms?view=sql-server-ver15)

## 3. Run the test app:

    > py -m venv venv
    > venv\Scripts\activate.ps1
    (venv) > pip install -r requirements.txt
    (venv) > python app.py
