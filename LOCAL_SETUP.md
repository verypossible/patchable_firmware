You will need a variety of NervesHub services to run the app locally. This doc should help you get all of them configured and running.

1. `git clone git@github.com:verypossible/nerveshub-terraform.git`
2. `cd nerveshub-terraform`
3. `git submodule update --init --recursive`
4. `cd nerves_hub_www`
5. Follow setup instructions in the repo README.md
6. (Optional for running on Erlange/OTP 23) Add the following to the :ssl keyword list on line 75 of `config/dev.exs:75`: `versions: [:"tlsv1.2"],`
7. `make iex-server`
8. `cd ../../`.
9. `git clone git@github.com:nerves-hub/nerves_hub_ca.git`
10. `cd nerves_hub_ca`
11. Update `dev.env` to match `export DATABASE_URL="postgres://db:db@localhost:2345/db"`
12. `source dev.env`
13. `export NERVES_HUB_CA_DIR=/Absolute/Path/To/nerveshub-terraform/nerves_hub_web/test/fixtures/ssl/`
14. `mix do deps.get, nerves_hub_ca.init, ecto.create, ecto.migrate`
15. `cp etc/ssl/* ../nerveshub-terraform/nerves_hub_web/test/fixtures/ssl`
16. `iex -S mix`
17. `cd ../`
18. `git clone git@github.com:verypossible/patchable_firmware.git`
19. `cd patchable_firmware`
20. `cp .env.dev.example .env.dev` and modify `NERVES_HUB_HOST`, `DEVICE_API_HOST`, `NERVES_HUB_CA_CERTS`, `NERVES_HUB_CA_CERTS`, `WIFI_SSID`, `WIFI_PSK` to make sure they reflect your environment. Then run `source .env.dev` to set the ENV vars.
21. `MIX_TARGET=desired_target mix deps.get`
22. Register a new account by executing the register command following the prompts: `mix nerves_hub.user register`
23. Create a new product: `mix nerves_hub.product create`
24. Create a new device: `NERVES_HUB_NON_INTERACTIVE=y mix nerves_hub.device create --identifier test --description test --tag test`
25. Follow the next prompt to create a cert.
26. The `NERVES_HUB_CA_CERTS` ENV var needs to point the the certs from `../nerveshub-terraform/nerves_hub_web/test/fixtures/ssl/` but they need to be under a `ca_certs` directory so maybe copy them locally to `./ssl/ca_certs` or something like that. Then update the ENV var and run `source .env.dev`
27. Force recompile: `mix deps.compile --force`
28. Run the project: `iex -S mix`
