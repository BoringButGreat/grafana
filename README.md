# Grafana

Elixir tools for accessing the Grafana API (see http://docs.grafana.org/http_api/).

## Installation

  1. Add grafana to your list of dependencies in `mix.exs`:
     ```elixir
     def deps do
       [{:grafana, "~> 0.1.0"}]
     end
     ```

  2. Ensure grafana is started before your application:
     ```elixir
     def application do
       [applications: [:grafana]]
     end
     ```

  3. Configure the environment variables in your config files:
     ```elixir
     config :grafana,
       api_host: "<your grafana server url>",
       api_key: "Bearer <your key>"
     ```

## Mocked mode for simulating API calls in your application's test scripts
  ```elixir
  config :grafana, api_host: "test"
  ```
