#!/bin/sh

encrypt_file() {
  gpg --yes --batch --pinentry-mode loopback --passphrase "$TG_GPG_PASSPHRASE" --symmetric --cipher-algo AES256 "$1"
}

# session
encrypt_file my_account.session

# session string
# encrypt_file my_account.session_string

# config file
encrypt_file configs.json

# tg-signer log file
encrypt_file tg-signer.log || true
