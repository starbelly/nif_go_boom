import Config

config :nif_go_boom, :hello, System.fetch_env!("HELLO")
