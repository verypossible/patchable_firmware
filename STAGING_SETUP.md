Note: prefix all mix commands with `MIX_TARGET=patchable_XXX` of your choice or export MIX_TARGET with the correct value assigned.

1. Don't forget to configure a public key to use for SSH on `config/target.exs#L32-34`
2. In 1Password download the `staging-link-ssl.zip` file from the `NervesHub` vault into a directory named `ca_certs`. Unzip the file and note the location of the directory
3. `cp .env.staging.example .env.staging` and edit the new file replacing `NERVES_HUB_CA_CERTS` with the path of the unzipped `staging-link-ssl` folder from step 1. Also update the `WIFI_SSID` and `WIFI_PSK`
4. `source .env.staging`
5. `mix nerves_hub.user register` or `mix nerves_hub.user auth` following prompts to login/create an account
6. `mix nerves_hub.product create` following the prompts to create a new product
7. `NERVES_HUB_NON_INTERACTIVE=y mix nerves_hub.device create --identifier test --description test --tag test` following the prompts to register your device. Continue following the the CLI suggestion to create a cert. Depending on the cert install location, you may need to update `PEM_CERT` and `PEM_KEY` in the `.env.staging` file
8. Generate der formatted files of your key/cert:

   - `openssl ec -inform pem -in ./nerves-hub/test-key.pem -outform der -out ./nerves-hub/test-key.der`
   - `openssl x509 -inform pem -in ./nerves-hub/test-cert.pem -outform der -out ./nerves-hub/test-cert.der`

and make sure the `.env.staging` file has all the correct paths for `DER_CERT` and `DER_KEY` and you've called `source .env.staging` as needed

9. `mix nerves_hub.key create devkey` and follow prompts to create a firmware signing key
10. You may need to recompile at this point: `mix deps.compile --force`
11. Now you should be ready to compile firmware: `mix firmware` and go through the regular NervesHub signing/deployment process.
