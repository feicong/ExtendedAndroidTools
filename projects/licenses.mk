# Copyright (c) Meta Platforms, Inc. and affiliates.

# Definitions of licensing macros

LGPL_FILE := projects/lgpl-3.0.txt

fetch-license = cp -f $(LGPL_FILE) $(ANDROID_OUT_DIR)/licenses/$(1)
