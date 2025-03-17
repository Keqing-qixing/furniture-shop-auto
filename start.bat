@echo off
echo Starting Django project setup...

:: Check if virtual environment exists
if not exist myvenv (
    echo Creating virtual environment...
    python -m venv myvenv
)

:: Activate the virtual environment
echo Activating virtual environment...
call myvenv\Scripts\activate

:: Upgrade pip
echo Upgrading pip...
python -m pip install --upgrade pip

:: Install dependencies
echo Installing Django and Pillow...
pip install django pillow

:: Navigate to the project directory
cd /d "%~dp0"

:: Apply migrations
echo Applying migrations...
python manage.py makemigrations
python manage.py migrate

:: Check if superuser needs to be created
set /p createsuperuser="Do you want to create a superuser? (y/n): "
if /i "%createsuperuser%"=="y" (
    python manage.py createsuperuser
)

:: Collect static files
echo Collecting static files...
python manage.py collectstatic --noinput

:: Run the development server
echo Starting Django server...
python manage.py runserver

pause
