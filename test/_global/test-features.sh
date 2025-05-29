#!/bin/bash

# This test file is executed against running containers constructed
# from the scenarios defined in the tests/_global/scenarios.json file.
#
# This test can be run with the following command (from the root of this repo)
#    devcontainer features test --global-scenarios-only .

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Testing alpine-base feature
check "packages are installed" bash -c "command -v bash && command -v git && \
 command -v ssh && command -v pnpm && command -v npm && command -v starship"
check "bash is default shell" bash -c '[ "$SHELL" = "/bin/bash" ]'
check ".bashrc exists" bash -c "sudo test -f /root/.bashrc"
check ".bashrc works" bash -c "sudo bash --rcfile /root/.bashrc -i -c 'l'"
check "ni command is available" bash -c "command -v ni"

# Report result
reportResults
