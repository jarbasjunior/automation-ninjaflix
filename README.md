# Automation Ninjaflix

  Automation Ninjaflix is a software test automation project, which will use the following tools:

  - **[BDD](https://cucumber.io/docs/gherkin)** (Behavior Driven Development) for the product specification;
  - **[Cucumber](https://docs.cucumber.io/installation)**, **[Capybara](https://github.com/teamcapybara/capybara)** and **[RSpec](https://rspec.info)** to automate;
  - **[HTTParty](https://github.com/jnunemaker/httparty)** for Api integration; and
  - **[Page Objects](https://github.com/SeleniumHQ/selenium/wiki/PageObjects)** as a test development standard.


## Installing WebDrivers in Debian/Ubuntu

  ### Geckodriver (Firefox)

  1 - Go to the geckodriver releases page. Find the latest version of the driver for your platform and download it. For example:

  ```
  wget https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz
  ```

  2 - Extract the file with:

  ```
  tar -xvzf geckodriver-v0.26.0-linux64.tar.gz
  ```

  3 - Make it executable:

  ```
  chmod +x geckodriver
  ```

  4 - Move the geckodrive to /usr/local/bin/:

  ```
  sudo mv geckodriver /usr/local/bin/
  ```

  ### ChromeDriver (Google Chrome)

  1 - Go to the ChromeDriver releases page. Find the latest version of the driver for your platform and download it. For example:

  ```
  wget https://chromedriver.storage.googleapis.com/81.0.4044.69/chromedriver_linux64.zip
  ```

  2 - Extract the file with:

  ```
  unzip chromedriver_linux64.zip
  ```

  3 - Make it executable:

  ```
  sudo mv chromedriver /usr/bin/chromedriver
  sudo chown root:root /usr/bin/chromedriver
  sudo chmod +x /usr/bin/chromedriver
  ```


  This project will validate users and movies API's, which will configured locally with Docker.

## Prerequisite: Installed [Docker](https://docs.docker.com/engine/install)

  ### Configuration the docker network

  - Create the docker network, wich will be  user for to insert the images API's and databases. The network will be called **skynet**
  ```
  docker network create --driver bridge skynet
  ```

  ### Configuration the docker databases

  - Download the **postgres** image
    ```
    docker pull postgres
    ```
  - Check the image download with `docker images` and create database container within **skynet** network using **name repository** or **image id**
    ```
    docker run --name pgdb --network=skynet -e "POSTGRES_PASSWORD=qaninja" -p 5432:5432 -v var/lib/postgresql/data -d postgres
    ```
  - Download **pgadmin** image and create your container within **skynet** network
    ```
    docker run --name pgadmin --network=skynet -e "PGADMIN_DEFAULT_EMAIL=root@qaninja.io" -e "PGADMIN_DEFAULT_PASSWORD=qaninja" -p 15432:80 -d dpage/pgadmin4
    ```
  #### Configuration pgadmin client

  - Access the database in the browser with the URL: `localhost:15432`, login: root@qaninja.io, password: `qaninja`;
  - Right click from `Servers` >> `Create` >> `Server...`;
  - From tab `General` enter server name `pgdb`;
  - From tab `Connection` enter **host**: `pgdb`, **Username:** `postgres`, **Password:** `qaninja`, check **Save Password?** and click from `Save`;
  - Right click in the `Database created (pgdb)` >> `Create` >> `Database...`;
  - From tab `General` enter **Database:** `nflix`, **owner:** `postgres` and click from `Save`;

  ### Configuration the docker API's

  - Download the **api users** image
    ```
    docker pull papitoio/nflix-api-users
    ```
  - Check the image download with `docker images` and create database container within **skynet** network using **name repository** or **image id**
    ```
    docker run --name nflix-api-users --network=skynet -e "DATABASE=pgdb" -p 3001:3001 -d papitoio/nflix-api-users
    ```
  - Access the nflix-api-users in the browser with the URL: `localhost:3001` and add `/apidoc` from url for see api documentation;

  - Download the **api movies** image
    ```
    docker pull papitoio/nflix-api-movies
    ```
  - Check the image download with `docker images` and create database container within **skynet** network using **name repository** or **image id**
    ```
    docker run --name nflix-api-movies --network=skynet -e "DATABASE=pgdb" -p 3002:3002 -d papitoio/nflix-api-movies
    ```
  - Access the nflix-api-movies in the browser with the URL: `localhost:3002` and add `/apidoc` from url for see api documentation;

  - Download the **api gateway** image
    ```
    docker pull papitoio/nflix-api-gateway
    ```
  - Check the image download with `docker images` and create database container within **skynet** network using **name repository** or **image id**
    ```
    docker run --name nflix-api-gateway --network=skynet -e "DATABASE=pgdb" -e "API_USERS=http://nflix-api-users:3001" -e "API_MOVIES=http://nflix-api-movies:3002" -p 3000:3000 -d papitoio/nflix-api-gateway
    ```
  - Access the nflix-api-gateway in the browser with the URL: `localhost:3000` for see api in execution;

  - Download the **api web** image
    ```
    docker pull papitoio/nflix-web
    ```
  - Check the image download with `docker images` and create database container within **skynet** network using **name repository** or **image id**
    ```
    docker run --name nflix-web --network=skynet -e "VUE_APP_API=http://localhost:3000" -p 8080:8080 -d papitoio/nflix-web
    ```
  - Access the nflix-api-gateway in the browser with the URL: `localhost:8080` for see api web in execution;

### Configuration for worker with Jenkins

  - Remove container `nflix-web`
  ```
  docker container rm -f nflix-web
  ```
  - Download the **api web 2** image
  ```
  docker pull papitoio/nflix-web2
  ```
  - Check the image download with `docker images` and create database container within **skynet** network using **name repository** or **image id**
  ```
  docker run --name nflix-web --network=skynet -e "VUE_APP_API=http://nflix-api-gateway:3000" -p 8000:8000 -d papitoio/nflix-web2
  ```
  - Access the nflix-api-gateway in the browser with the URL: `localhost:8000` for see api web in execution;

  - Create `alias` from the `/etc/hosts` file inthe your pc, for access your containers;
  ```
  sudo nano /etc/hosts
  ```
  - Insert at the end of the file:
  ```
  127.0.0.1       pgdb 
  127.0.0.1       pgadmin
  127.0.0.1       nflix-web
  127.0.0.1       nflix-api-users
  127.0.0.1       nflix-api-movies
  127.0.0.1       nflix-api-gateway
  ```
  - Save the `hosts` file and check in the browser, the url's following;
    
    - http://pgadmin:15432
    - http://nflix-api-users:3001/apidoc
    - http://nflix-api-movies:3002/apidoc
    - http://nflix-api-gateway:3000
    - http://nflix-web:8000

#### Configuration Docker Jenkins

  - Download the **jenkinsci/blueocean** image
  ```
  docker pull jenkinsci/blueocean
  ```
  - Check the image download with `docker images` and create a volume to persist Jenkins data
  ```
  docker volume create jenkins-data
  ```
  - Create Jenkins container within **skynet** network with **jenkins-data** volume using **name repository** or **image id**
  ```
  docker container run --name jenkins-blueocean --detach \
  --network skynet -u root \
  --volume jenkins-data:/var/jenkins_home \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --publish 8080:8080 --publish 50000:50000 jenkinsci/blueocean
  ```
  - Check configuration in the browser with the url: http://localhost:8080, your must be see the image bellow:

    <img src="https://jenkins.io/doc/book/resources/tutorials/setup-jenkins-01-unlock-jenkins-page.jpg" width="700" height="500">

  - Execute the command: `docker exec -it jenkins-blueocean bash`, next, execute: `cat /var/jenkins_home/secrets/initialAdminPassword`. Your must be have the following output:
  ```
  ~ docker exec -it jenkins-blueocean bash
  bash-4.4# cat /var/jenkins_home/secrets/initialAdminPassword
  f281a2e3abdd4f9b892a2e982b7f3334
  ```
  - Copy the password generated on your terminal and paste it in the `Administrator password` field from: http://localhost:8080, and click on the `Continue` button;

  - On the page `Customize Jenkins`, click on the `Install suggested plugins` cards, for Jenkins to download the basic plugins;

    <img src="https://assets.digitalocean.com/articles/jenkins-install-ubuntu-1804/customize_jenkins_screen_two.png" width="700" height="500">

  - Create your first admin user, in this example we will use `devops` for user, password, full name, the e-mail choose one of your preference. Next, click on the `Save and Continued` button;

    <img src="https://assets.digitalocean.com/articles/jenkins-install-ubuntu-1804/jenkins_create_user.png" width="700" height="500">

  - Check the `Jenkins url` (http://localhost:8080), click on the `Save and Finished` button, next `Start using Jenkins` and Jenkins local settings will be completed.
    

For list your containers execute: `docker ps`.

For see docker network **skynet** execute: `docker network inspect skynet`. For more details about docker networks, click [here](https://docs.docker.com/network/network-tutorial-standalone).
