# PatchableTest

Test firmware that has targets configured for testing the new delta updates feature of NervesHub.

## Targets

Nerves applications produce images for hardware targets based on the
`MIX_TARGET` environment variable. If `MIX_TARGET` is unset, `mix` builds an
image that runs on the host (e.g., your laptop). This is useful for executing
logic tests, running utilities, and debugging. Other targets are represented by
a short name like `rpi3` that maps to a Nerves system image for that platform.
All of this logic is in the generated `mix.exs` and may be customized. For more
information about targets see:

https://hexdocs.pm/nerves/targets.html#content

- [patchable_rpi0](https://github.com/verypossible/patchable_rpi0)
- [patchable_rpi3](https://github.com/verypossible/patchable_rpi3)

## Getting Started

There are two paths to configuring this firmware:

- [Staging](https://github.com/verypossible/patchable_firmware/blob/main/STAGING_SETUP.md)
- [Development](https://github.com/verypossible/patchable_firmware/blob/main/LOCAL_SETUP.md)

## Learn more

- Official docs: https://hexdocs.pm/nerves/getting-started.html
- Official website: https://nerves-project.org/
- Forum: https://elixirforum.com/c/nerves-forum
- Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
- Source: https://github.com/nerves-project/nerves
