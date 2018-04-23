# Sample .deb build with a Go binary

Requires:

* Go
* Docker

Does not require a Debian system; Docker is used in place of that requirement.

## Use

Run `make` to build a deb in the project root directory.

Run `make test-install` to launch a Debian Docker container, install the .deb, run it, and uninstall it. This Makefile target builds the .deb if it doesn't exist.
