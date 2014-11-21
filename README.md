**Admin template for sites on MondoDB**

  **Requirements:**

    * Ruby version 2.1.5

  **System dependencies**
  
    NodeJS *
    MongoDB (2.6.5 and above) *
    JDK (7 and abobe) or OpenJDK (6 and above)
    Elasticsearch (1.3.4)*
    libcurl3 libcurl3-gnutls libcurl4-openssl-dev

  ** Configuration**

    Ruby on Rails 4.1.6
    Mongoid 4
  
  **Installing MongoDB**

    Debian/Ununtu:

      sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
      echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
      sudo apt-get update
      sudo apt-get install -y mongodb-org

  **Installing Elasticsearch**

    Debian/Ubuntu:

      ! Required pre-installed JDK or OpenJDK

      Java Development Kit (Oracle)
        sudo add-apt-repository ppa:webupd8team/java
        sudo apt-get update
        sudo apt-get install oracle-java8-installer
      or
      OpenJDK
        sudo apt-get update
        sudo apt-get install openjdk-6-jre

      Elasticsearch

        wget -qO - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -

        ! Add in /etc/apt/sources.list
          deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main

        sudo apt-get update
        sudo apt-get install elasticsearch
        sudo service elasticsearch start
        
        Installing Elasticsearch Morphology plugin

        ! Execute from /usr/share/elasticsearch
        bin/plugin -install analysis-morphology -url http://dl.bintray.com/content/imotov/elasticsearch-plugins/org/elasticsearch/elasticsearch-analysis-morphology/1.2.0/elasticsearch-analysis-morphology-1.2.0.zip
        sudo service elasticsearch restart

        ! Copy config from config/elasticsearch.yml.example to /etc/elasticsearch/elasticsearch.yml.example
        ! Update indexes from project directory
        bundle exec rake environment elasticsearch:import:all

  **Database creation**

    nothing to do

  **Starting development**

    Debian/Ubuntu:

      git clone git@bitbucket.org:mystand/admin-with-mongo.git
      cp admin-with-mongo #{project name}
      cd #{project name}
      sudo apt-get install libcurl3 libcurl3-gnutls libcurl4-openssl-dev
      bundle
      cp config/mongoid.yml.example config/mongoid.yml
      cp config/secrets.yml.example config/secrets.yml
      rails s
      get http://localhost:3000

  **Deployment instructions**

     Add public ssh key to ~/.ssh/authorized_keys in #{deploy user}@new.mystand.ru

     - deploy:
         bundle exec cap production deploy

     - start server:
         bundle exec cap production unicorn:start

     - restart server:
         bundle exec cap production deploy:restart
       or
         bundle exec cap production unicorn:restart

     - stop server:
         bundle exec cap production unicorn:stop
       or
         bundle exec cap production unicorn:force_stop

       get http://kemerovo-invest-portal2.mystand.ru