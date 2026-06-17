# Get the directory for this file, and use that instead of a fixed path.
local_dir := $(dir $(lastword $(MAKEFILE_LIST)))

# Attach the flag value definitions to the various release configurations.
$(call declare-release-config, cp2a, $(local_dir)build_config/cp2a.scl)

local_dir :=
