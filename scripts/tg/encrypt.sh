#!/bin/sh

# session
gpg --yes --batch --pinentry-mode loopback --passphrase "$TG_GPG_PASSPHRASE" --symmetric --cipher-algo AES256 my_account.session

# session string
gpg --yes --batch --pinentry-mode loopback --passphrase "$TG_GPG_PASSPHRASE" --symmetric --cipher-algo AES256 my_account.session_string

# config file
gpg --yes --batch --pinentry-mode loopback --passphrase "$TG_GPG_PASSPHRASE" --symmetric --cipher-algo AES256 config.json

# tg-signer log file
gpg --yes --batch --pinentry-mode loopback --passphrase "$TG_GPG_PASSPHRASE" --symmetric --cipher-algo AES256 tg-signer.log
