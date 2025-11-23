#!/bin/sh

# session
gpg --quiet --batch --yes --decrypt --passphrase="$TG_GPG_PASSPHRASE" --output my_account.session my_account.session.gpg

# session string
gpg --quiet --batch --yes --decrypt --passphrase="$TG_GPG_PASSPHRASE" --output my_account.session_string my_account.session_string.gpg

# config file
gpg --quiet --batch --yes --decrypt --passphrase="$TG_GPG_PASSPHRASE" --output config.json config.json.gpg

# tg-signer log file
gpg --quiet --batch --yes --decrypt --passphrase="$TG_GPG_PASSPHRASE" --output tg-signer.log tg-signer.log.gpg
