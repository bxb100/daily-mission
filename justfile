default:
  @just --list

alias d:= decrypt
alias e:= encrypt
alias l:= lint

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
  rm -f my_account.session my_account.session_string tg-signer.log*

run task:
  tg-signer run-once {{task}}

run-all: decrypt
  ./scripts/tg/core.sh ./configs.json
