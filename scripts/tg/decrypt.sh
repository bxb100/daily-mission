#!/bin/sh

decrypt_file() {
  gpg --quiet --batch --yes --decrypt --passphrase="$TG_GPG_PASSPHRASE" --output "$1" "$1.gpg"
}

# session
decrypt_file my_account.session

# session string
# decrypt_file my_account.session_string

# config file
decrypt_file configs.json

decrypt_file tg-signer.log || true
