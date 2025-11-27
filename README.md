# Datawarehouse Project using Dbt
A practise project to build an ecommerce data warehouse using dbt and postgres

## Getting Started
- Install python 3+
- Download dbt `pip install dbt`
- Verify installation `dbt --version`

- Specify the database details (postgres) in profiles.yml
- Run `dbt deps` in the terminal to install dependencies
- Run `dbt seed` to create raw tables with dummy data loaded via csv in a schema named `raw`

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