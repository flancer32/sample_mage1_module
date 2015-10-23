# sample_mage1_module

Stub for Magento 1 module with development environment.

[![Build Status](https://travis-ci.org/flancer32/sample_mage1_module.svg)](https://travis-ci.org/flancer32/sample_mage1_module/)

## Magento 1 Module Links

* [Cotya/magento-composer-installer](https://github.com/Cotya/magento-composer-installer)
* [Adding Composer's autoloading ability to Magento](https://github.com/Cotya/magento-composer-installer/blob/3.0/doc/Autoloading.md)
* [Run Magento Installer from Command Line](http://fbrnc.net/blog/2012/03/run-magento-installer-from-command-line)



## Development Installation

Clone repo from github:

    $ git clone git@github.com:flancer32/sample_mage1_module.git
    $ cd sample_mage1_module/work/

... configure development instance (DB parameters, access parameters, [etc](http://fbrnc.net/blog/2012/03/run-magento-installer-from-command-line)):

    $ cp templates.json.init templates.json
    $ nano templates.json    
    {
      "vars": {
        "LOCAL_ROOT": "/home/magento/instance/sample_mage2_module",
        "LOCAL_OWNER": "magento",
        "LOCAL_GROUP": "www-data",
        "DEPLOYMENT_TYPE": "travis|manual",
        "CFG_ADMIN_FIRSTNAME": "Store",
        "CFG_ADMIN_LASTNAME": "Admin",
        "CFG_ADMIN_EMAIL": "admin@store.com",
        "CFG_ADMIN_USER": "admin",
        "CFG_ADMIN_PASSWORD": "eUvE7Yid057Cqtq5CkA8",
        "CFG_BASE_URL": "http://mage2.local.host.com/",
        "CFG_BACKEND_FRONTNAME": "admin",
        "CFG_DB_HOST": "localhost",
        "CFG_DB_NAME": "magento2",
        "CFG_DB_USER": "magento2",
        "CFG_DB_PASS": "JvPESKVSjXvZDrGk2gBe or use 'skip_password'",
        "CFG_LANGUAGE": "en_US",
        "CFG_CURRENCY": "USD",
        "CFG_TIMEZONE": "UTC",
        "CFG_USE_REWRITES": "0",
        "CFG_USE_SECURE": "0",
        "CFG_USE_SECURE_ADMIN": "0",
        "CFG_ADMI_USE_SECURITY_KEY": "0",
        "CFG_SESSION_SAVE": "db"
      }
    }
    
... then run composer, link modules to `./work/htdocs/` and install Magento DB:  
    
    $ composer install
    $ sh  ./bin/deploy/post_install.sh




## Magento modules redeployment

    $ composer run-script post-install-cmd -vvv -- --redeploy




## Setup web server

Point your web-server to folder `$LOCAL_ROOT/work/htdocs`. This is sample for the Apache2 web server:

    <VirtualHost *:80>
      DocumentRoot /home/magento/instance/sample_mage1_module/work/htdocs/
      DirectoryIndex index.php
    
      ServerName mage1.local.host.com
      ServerAdmin support@local.host.com
    
      <Directory /home/magento/instance/sample_mage1_module/work/htdocs>
        Options -Indexes +FollowSymLinks +MultiViews
        Require all granted
        AllowOverride All
        Order allow,deny
        Allow from all
        AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript
      </Directory>
    
      LogLevel debug
      ErrorLog /var/log/httpd/mage1_error.log
      CustomLog /var/log/httpd/mage1_access.log combined
    </VirtualHost>

