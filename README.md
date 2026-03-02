<p align="center">
  <img width="1280" height="256" alt="Gemini_Generated_Image_utey79utey79utey-Photoroom" src="https://github.com/user-attachments/assets/8afa2c28-fdd3-4909-8fe1-6c66c5f41f05" />
</p>

[![Sync docker images](https://github.com/bxb100/daily-mission/actions/workflows/sync.yml/badge.svg?branch=main)](https://github.com/bxb100/daily-mission/actions/workflows/sync.yml)

[sync.yml](./.github/workflows/sync.yml) using [skopeo](https://github.com/containers/skopeo) to synchronize docker images between registries.

[![Telegram signer](https://github.com/bxb100/daily-mission/actions/workflows/tg.yml/badge.svg)](https://github.com/bxb100/daily-mission/actions/workflows/tg.yml)

[tg.yml](./.github/workflows/tg.yml) using [tg-signer](https://github.com/amchii/tg-signer) to sign telegram messages.[^1]

`configs.json` schema is `[ { "task_name": "mytask", ...tg-signer_exported_json_config } ]`

[^1]: <https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets#storing-large-secrets>
