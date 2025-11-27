# Datawarehouse Project using Dbt
A practise project to build an ecommerce data warehouse using airbyte, dbt and postgres.
Raw data ingestion from bigquery using airbyte and transforming data with dbt. Creating facts, dimensions and marts. Destination is local postgres. 

## Install dbt (Windows)  
- Install python 3+
- Download dbt `pip install dbt`
- Verify installation `dbt --version`

## Install dbt (Ubuntu) in virtual env 
- sudo apt install python3-venv -y
- python3 -m venv dbt-env
- source dbt-env/bin/activate
- pip install dbt-postgres

- Specify the database details (postgres) in profiles.yml
- Run `dbt deps` in the terminal to install dependencies

### Using the project

Try running the following commands:
- `dbt debug` (test the db connection)
- `dbt run` -> run the project
- `dbt run --select <model_name>` -> run a specific model
- `dbt test` -> run test cases

- `dbt docs generate` -> generates documentation based on the description added in the `schema.yml` files
- `dbt docs serve` hosts the documentation in the web browser


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)