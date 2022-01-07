# Tea Shop

## Welcome to Tea Shop!

Find the project spec [here](https://mod4.turing.edu/projects/take_home/take_home_be)

## Table of Contents

- [Overview](#overview)
- [Tools Utilized](#framework)
- [Database Schema](#database)
- [Contributors](#contributors)
- [Deployed Endpoints](#deployed-endpoints)
- [Project Configurations](#setup)


------

### <ins>Overview</ins>

[Tea Shop](https://github.com/KevinMugele/tea_shop) is the final take-home challenge for the Back End Engineering program at Turing School.

The challenge was to build a fully functional JSON API 1.0 - compliant REST API that exposes endpoints for multiple resources from a relational database, modeling a true back-end framework that could be consumed by an entirely separate front-end framework.

Learning goals and areas of focus consisted of:

- A strong understanding of Rails conventions
- Ability to create restful routes
- Demonstration of well-organized code, following OOP
- Test Driven Development
- Clear documentation

[Technical Requirements](https://mod4.turing.edu/projects/take_home/take_home_be)

#### <ins>Framework</ins>
<p>
  <img src="https://img.shields.io/badge/Ruby%20On%20Rails-b81818.svg?&style=flat&logo=rubyonrails&logoColor=white" />
</p>

#### Languages
<p>
  <img src="https://img.shields.io/badge/Ruby-CC0000.svg?&style=flaste&logo=ruby&logoColor=white" />
  <img src="https://img.shields.io/badge/ActiveRecord-CC0000.svg?&style=flaste&logo=rubyonrails&logoColor=white" />
  <img src="https://img.shields.io/badge/SQL-CC0000.svg?&style=flaste&logo=SQL&logoColor=white" />
</p>

#### Tools
<p>
  <img src="https://img.shields.io/badge/Atom-66595C.svg?&style=flaste&logo=atom&logoColor=white" />  
  <img src="https://img.shields.io/badge/Git-F05032.svg?&style=flaste&logo=git&logoColor=white" />
  <img src="https://img.shields.io/badge/GitHub-181717.svg?&style=flaste&logo=github&logoColor=white" />
  </br>
  <img src="https://img.shields.io/badge/Postman-f74114.svg?&style=flat&logo=postman&logoColor=white" />
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1.svg?&style=flaste&logo=postgresql&logoColor=white" />
</p>

#### Gems
<p>
  <img src="https://img.shields.io/badge/rspec-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/pry-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />  
  <img src="https://img.shields.io/badge/simplecov-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />  
  <img src="https://img.shields.io/badge/factory--bot-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  </br>
  <img src="https://img.shields.io/badge/faker-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />  
  
</p>

#### Development Principles
<p>
  <img src="https://img.shields.io/badge/OOP-b81818.svg?&style=flaste&logo=OOP&logoColor=white" />
  <img src="https://img.shields.io/badge/TDD-b87818.svg?&style=flaste&logo=TDD&logoColor=white" />
  <img src="https://img.shields.io/badge/MVC-b8b018.svg?&style=flaste&logo=MVC&logoColor=white" />
  <img src="https://img.shields.io/badge/REST-33b818.svg?&style=flaste&logo=REST&logoColor=white" />  
</p>

### <ins>Database</ins>

<img width="1084" alt="Database Schema" src="https://user-images.githubusercontent.com/82777170/148253823-6e4c8479-cb8a-4c51-99b3-095b6e40dfca.png">

### <ins>Contributors</ins>

👤  **Kevin Mugele**
- Github: [Kevin Mugele](https://github.com/kevinmugele)
- LinkedIn: [Kevin Mugele](https://www.linkedin.com/in/kevinmugele/)

## <ins>Deployed Endpoints</ins>

The `base path` of each endpoint is:

```
/api/v1
```

- For `GET` requests, you can send the requests through your internet browser, or utilize an API client (i.e. [Postman](https://www.postman.com/))
- For `POST` or `PATCH` requests, you will need to use an API client to provide the required request body

#### Tea Endpoint

#### Subscription Endpoints

*Create a new tea subscription for an existing customer*

**Example Request:**

```
POST /api/v1/customers/{:id}/subscriptions
```

With the following `JSON` body:

```json
{
    "title": "green",
    "tea_id": 1,
    "price": 20,
    "frequency": "Weekly",
    "status": "Active",
    "customer_id": 3
}
```

**Example Response:**

201 (Created)

```json
{
    "data": {
        "id": "4",
        "type": "subscription",
        "attributes": {
            "customer_id": 3,
            "tea_id": 1,
            "title": "green",
            "price": 20,
            "frequency": "Weekly",
            "status": "Active"
        }
    }
}
```

**Example Request:**

```
POST /api/v1/customers/{:id}/subscriptions
```

With the following `JSON` body:

```json
{}
```

**Example Response:**

422 (Unprocessable Entity)

```json
{
    "errors": [
        "Tea can't be blank",
        "Price can't be blank",
        "Price is not a number",
        "Frequency can't be blank",
        "Status can't be blank"
    ]
}
```

---

*Cancel an existing tea subscription*

**Example Request:**

```
PATCH /api/v1/customers/{:customer_id}/subscriptions/{:id}
```

With the following `JSON` body:

```json
{
    "status": "Cancelled"
}
```

**Example Response:**

200 (OK)

```json
{
    "data": {
        "id": "4",
        "type": "subscription",
        "attributes": {
            "customer_id": 3,
            "tea_id": "5fa402618765bf0017f09759",
            "title": "green",
            "price": 20,
            "frequency": "Weekly",
            "status": "Cancelled"
        }
    }
}
```

**Example Request:**

```
PATCH /api/v1/customers/{:customer_id}/subscriptions/{:id}
```

With the following `JSON` body:

```json
{
    "status": "TESTING"
}
```

**Example Response:**

422 (Unprocessable Entity)

```json
{
    "errors": [
        "'TESTING' is not a valid status"
    ]
}
```

**Example Request:**

```
PATCH /api/v1/customers/{:customer_id}/subscriptions/bar
```

---

*Get all tea subscriptions for an existing customer*

**Example Request:**

```
GET /api/v1/customers/{:id}/subscriptions
```

**Example Response:**

200 (OK)

```json
{
    "data": [
        {
            "id": "4",
            "type": "subscription",
            "attributes": {
                "customer_id": 3,
                "tea_id": "5fa402618765bf0017f09759",
                "title": "green",
                "price": 20,
                "frequency": "Weekly",
                "status": "Active"
            }
        },
        {
            "id": "5",
            "type": "subscription",
            "attributes": {
                "customer_id": 3,
                "tea_id": 2,
                "title": "chai",
                "price": 15.5,
                "frequency": "Weekly",
                "status": "Cancelled"
            }
        }
    ]
}
```

## <ins>Setup</ins>

This project requires Ruby 2.7.2 and Rails 6.1.4.4

* Fork this repository
* Install gems and set up your database:
    * `bundle`
    * `rails db:{drop,create,migrate,seed}`
    * `rails db:schema:dump`
* Run the test suite with `bundle exec rspec -fd`
* Run your development server with `rails s`


### Project Configurations

* Ruby version
    ```bash
    $ ruby -v
    ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-darwin20]
    ```

* [System dependencies](https://github.com/kevinmugele/rails-engine/blob/main/Gemfile)
    ```bash
    $ rails -v
    Rails 5.2.6
    ```

* Database creation
    ```bash
    $ rails db:{drop,create,migrate,seed}
    ...
    $ rails db:schema:dump
    ```

* How to run the test suite
    ```bash
    $ bundle exec rspec -fd
    ```

* [Local Deployment](http://localhost:3000), for testing:
    ```bash
    $ rails s
    => Booting Puma
    => Rails 5.2.6 application starting in development
    => Run `rails server -h` for more startup options
    Puma starting in single mode...
    * Version 3.12.6 (ruby 2.7.2-p137), codename: Llamas in Pajamas
    * Min threads: 5, max threads: 5
    * Environment: development
    * Listening on tcp://localhost:3000
    Use Ctrl-C to stop
    ```
