#!/usr/bin/env bash

##
## Final dot sh
## Compile java classes, and build lib/libjcurses.so
##

# sdkman nuances
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
. "$HOME/.cargo/env"
# ---

type sdk >/dev/null || {
  echo "[ERROR] Could not execut sdkman"
  exit 1
}

java_8_sdkman_id="8.0.462-amzn"

## This is changing the user's java, I think
sdk use java "$java_8_sdkman_id" || {
  echo "Failed switching to $java_8_sdkman_id. Is it not installed?"
  echo "Install with: 'sdk install java $java_8_sdkman_id'"
  exit 1
}

make clean
make

