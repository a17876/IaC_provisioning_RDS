May need to modify to run the codes
------------
Terraform: You need to modify the aws credential part in the terra_modules/ec2_instances/main.tf & variables.tf
Ansible: add .env file to store AWS credentials in the root dorectory of Ansible.

Ansible Role Name
------------

- web_server: Create the frontend - install nginx and replace the index.html file.
- backend_server: install python related package and connect to the database

Ansible Requirements
------------

- web_server: nginx
- backend_server:    
    - python3
    - python3-pip
    - libmysqlclient-dev
    - pkg-config
    - python3-dev
    - Flask==2.2.5
    - Flask-SQLAlchemy==3.0.5
    - gunicorn==20.1.0
    - mysqlclient==2.1.0
    - Werkzeug==2.2.2

Ansible Role Variables
--------------

All variables go into the vars directory.


Video
------------------
Please set the video quality to the HD to see the codes clearly. 

terraform: https://youtu.be/B9heewmSzF4?si=g8k_dVADvcmZmOZB <br>
ansible: https://youtu.be/1f_DSe2lEGk?si=bVFQbYgYuREF3Qr1 
