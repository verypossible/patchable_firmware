# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

config :patchable_test, target: Mix.target()

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware,
  rootfs_overlay: "rootfs_overlay",
  provisioning: :nerves_hub_link

config :nerves_hub_link,
  ssl: [
    key: {:ECPrivateKey, File.read!(System.get_env("DER_KEY"))},
    cert: File.read!(System.get_env("DER_CERT"))
  ],
  ca_certs: Path.expand("../test/fixtures/ca_certs", __DIR__),
  configurator: NervesHubLink.Configurator.Default,
  fwup_public_keys: [:devkey],
  remote_iex: true

# Device HTTP connection.
config :nerves_hub_link,
  device_api_host: System.get_env("DEVICE_API_HOST"),
  device_api_port: System.get_env("DEVICE_API_PORT"),
  device_api_sni: System.get_env("DEVICE_API_SNI")

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1597779287"

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [RingLogger]

if Mix.target() != :host do
  import_config "target.exs"
else
  cert =
    if File.exists?(System.get_env("PEM_CERT")),
      do: File.read!(System.get_env("PEM_CERT"))

  key =
    if File.exists?(System.get_env("PEM_KEY")),
      do: File.read!(System.get_env("PEM_KEY"))

  config :nerves_runtime, :kernel, autoload_modules: false
  config :nerves_runtime, target: "host"

  config :nerves_runtime, Nerves.Runtime.KV.Mock, %{
    "nerves_fw_active" => "a",
    "a.nerves_fw_uuid" => "8a8b902c-d1a9-58aa-6111-04ab57c2f2a8",
    "a.nerves_fw_product" => "patchable_test",
    "a.nerves_fw_architecture" => "x86_64",
    "a.nerves_fw_version" => "0.1.0",
    "a.nerves_fw_platform" => "x86_84",
    "a.nerves_fw_misc" => "extra comments",
    "a.nerves_fw_description" => "test firmware",
    "nerves_hub_cert" => cert,
    "nerves_hub_key" => key,
    "nerves_fw_devpath" => "/tmp/fwup_bogus_path",
    "nerves_serial_number" => "test"
  }

  config :nerves_runtime, :modules, [
    {Nerves.Runtime.KV, Nerves.Runtime.KV.Mock}
  ]
end
