# Dependable

A production-ready Elixir template that shows how to set up, develop, test, and deploy using GitHub Actions and other modern DevOps tools. From project structure to pipelines, dependable helps you build scalable and maintainable apps with confidence.

## Local Setup

Documentation can be generated locally for development purposes using [ExDoc](https://github.com/elixir-lang/ex_doc).


### Build & Run
This step requires that you have Docker and Docker Compose installed.\
To install Docker, follow [these installation steps](https://docs.docker.com/engine/install/ubuntu/).\
To install Docker Compose, follow [these installation steps](https://docs.docker.com/compose/install/).


After that, you can run the app with Docker Compose: 

    $ docker compose up

The application will be available inside container.


### Seeds

You can run ` docker exec -it dependable sh -c "cd /app && exec sh"
` to access app directory and run commands to create, drop or reset database and apply seeds into the database. It only works on development environment.

Create database and apply seeds

    mix ecto.setup 


## Running IEx and tests locally

You can run IEx and the tests in the code you're working on through. `docker exec -it dependable sh -c "cd /app && exec sh` We usually get into the container using `sh`.


Then, inside the container, run:

    # iex -S mix

To run the tests:

    # mix test

To run only the tests that failed in the last time `mix test` was executed:

    # mix test --failed

To run only tests involving modules that changed since the last time `mix test` was executed:

    # mix test --stale

## Deployment

Integrate your changes by merging your branch with main and deploy though Github Actions.