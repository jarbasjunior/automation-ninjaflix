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

  ### For list your containers execute: `docker ps`.

  ### For see docker network **skynet** execute: `docker network inspect skynet`. For more details about docker networks, click [here](https://docs.docker.com/network/network-tutorial-standalone).
