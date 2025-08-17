#!/usr/bin/env bash

##
## Compile java classes, build lib/libjcurses.so, and install to local maven repository
##

# sdkman nuances
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
. "$HOME/.cargo/env"
# ---

type sdk >/dev/null || {
  echo "[ERROR] Could not execut sdkman"
  exit 1
}

mvn clean install  || exit 1

java_8_sdkman_id="8.0.462-amzn"

## This is changing the user's java, I think
sdk use java "$java_8_sdkman_id" || {
  echo "Failed switching to $java_8_sdkman_id. Is it not installed?"
  echo "Install with: 'sdk install java $java_8_sdkman_id'"
  exit 1
}

make clean || exit 1
make || exit 1

echo "Build done successfully"
echo ""
read -p "Do you want to copy lib/libjcurses.so to /usr/lib/? (y/n) " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    echo -n "Copying... "
    sudo cp lib/libjcurses.so /usr/lib/
    echo "Done"
elif [[ "$answer" =~ ^[Nn]$ ]]; then
    echo "Not doing it then"
else
    echo "I don't know what you mean"
    echo "Here's the command: 'sudo cp lib/libjcurses.so /usr/lib/'"
fi
