#! /bin/bash
# Copyright (c) Meta Platforms, Inc. and affiliates.

dest="${1:-$(pwd)}"
TMP_NDK="/tmp/android-ndk-linux.zip"

echo "downloading ndk to ${dest}..."

curl -s -o "${TMP_NDK}" https://dl.google.com/android/repository/android-ndk-r27b-linux.zip
unzip -q "${TMP_NDK}" -d "${dest}"
rm "${TMP_NDK}"

echo "done"
