#!/usr/bin/env sh

set -eu

command -v git >/dev/null 2>&1 || sudo apt-get install git

info() {
  printf "\033[0;36m\033[1m[INFO]\033[0m %s" "$1"
}

release() {
  # your stuff here
  info "Unimplemented!"
  exit 1
}

case "$(git log --oneline --format=%B -n 1 HEAD)" in
*[Rr]elease*) release ;;
*)
  info "Not a release commit, exiting peacefully..."
  exit 0
  ;;
esac
