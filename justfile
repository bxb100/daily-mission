set dotenv-load

default:
  @just --list

alias d:= decrypt
alias e:= encrypt
alias l:= lint
alias review:= download-tg-log

encrypt:
  ./scripts/tg/encrypt.sh
decrypt:
  ./scripts/tg/decrypt.sh
lint:
  prek run -a

[confirm("Are you sure to clean all signer data?")]
prune:
  rm -rf .signer
  rm -rf logs
  rm -rf logfile
  rm -f my_account.session my_account.session_string tg-signer.log*

run task:
  tg-signer run-once {{task}}

[confirm("This will using encrypted config first")]
run-all: decrypt
  ./scripts/tg/core.sh ./configs.json

download-tg-log:
  #!/usr/bin/env sh
  rm -rf logfile
  RUN_ID=$(gh run list --json databaseId -w=tg.yml --limit 1 | jq -r '.[0].databaseId')
  gh run download $RUN_ID
  gpg --quiet --batch --yes --decrypt --passphrase="$TG_GPG_PASSPHRASE" --output 'logfile/remote.log' 'logfile/tg-signer.log.gpg'
