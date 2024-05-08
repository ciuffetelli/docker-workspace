#!/bin/bash

# echo "**** Adding user ****"
# usermod --password $(echo "$USER_PASSWORD") user
# usermod --password $(echo "$USER_PASSWORD" | openssl passwd -1 -stdin) user

echo "**** Install DEV Essentials ****"

# Installing NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Installing NODE lts
nvm install --lts
nvm use --lts
