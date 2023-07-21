# Base image
FROM ubuntu

# Install Git, Apache, and Python
RUN apt-get update && apt-get install -y git apache2 python3 python3-pip
RUN apt update && apt install -y php php-cli php-mbstring composer && apt update && apt install -y nodejs npm

# Clone the code from GitHub repository
RUN git clone https://github.com/prajeet1000/notes-app-web-deploy.git

# Copy the frontend & backend code to the Apache web root
RUN mkdir -p /app/backend
RUN cp -r notes-app-web-deploy/django-notes-app/* /app/backend

RUN cp -r notes-app-web-deploy/test.txt /var/www/html/
RUN cp -r notes-app-web-deploy/tb.php /var/www/html/
RUN cp -r notes-app-web-deploy/main.css /var/www/html/
RUN cp -r notes-app-web-deploy/index.php /var/www/html/
RUN cp -r notes-app-web-deploy/customisation.css /var/www/html/
RUN cp -r notes-app-web-deploy/Assets /var/www/html/



# Install Python dependencies
WORKDIR /app/backend
RUN pip3 install -r requirements.txt






# Expose ports for Apache and Python backend
EXPOSE 80
EXPOSE 8000

# Start Apache and Python backend when the container starts
CMD service apache2 start && python3 /app/backend/manage.py runserver 0.0.0.0:8000
