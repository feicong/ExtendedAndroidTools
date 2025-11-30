# Copyright (c) Meta Platforms, Inc. and affiliates.

# Build SDK package with headers and static libraries for Android development

SDK_DIR = $(ANDROID_SYSROOTS_OUT_DIR)/bpftools-sdk
SDK_TAR = bpftools-android-sdk-$(NDK_ARCH).tar.gz

sdk: $(SDK_TAR)

$(SDK_TAR): $(SDK_DIR)
	tar -zcf $@ -C $(ANDROID_SYSROOTS_OUT_DIR) bpftools-sdk \
		--owner=0 --group=0 \
		--transform="s|^bpftools-sdk|bpftools-android-sdk-$(NDK_ARCH)|"

$(SDK_DIR): $(ANDROID_SYSROOTS_OUT_DIR)
$(SDK_DIR): $(call project-android-target,argp)
$(SDK_DIR): $(call project-android-target,bcc)
$(SDK_DIR): $(call project-android-target,bpftrace)
$(SDK_DIR): $(call project-android-target,cereal)
$(SDK_DIR): $(call project-android-target,elfutils)
$(SDK_DIR): $(call project-android-target,ffi)
$(SDK_DIR): $(call project-android-target,flex)
$(SDK_DIR): $(call project-android-target,libbpf)
$(SDK_DIR): $(call project-android-target,llvm)
$(SDK_DIR): $(call project-android-target,xz)

$(SDK_DIR):
	mkdir -p $@

	# Copy all headers
	mkdir -p $@/include
	cp -r $(ANDROID_OUT_DIR)/include/* $@/include/ 2>/dev/null || true

	# Copy all static libraries
	mkdir -p $@/lib
	cp $(ANDROID_OUT_DIR)/lib/*.a $@/lib/ 2>/dev/null || true

	# Copy shared libraries
	cp $(ANDROID_OUT_DIR)/lib/*.so* $@/lib/ 2>/dev/null || true

	# Copy pkg-config files
	mkdir -p $@/lib/pkgconfig
	cp $(ANDROID_OUT_DIR)/lib/pkgconfig/*.pc $@/lib/pkgconfig/ 2>/dev/null || true

	# Copy licenses
	mkdir -p $@/licenses
	cp -r $(ANDROID_OUT_DIR)/licenses/* $@/licenses/ 2>/dev/null || true

	# Create README
	echo "BPF Tools Android SDK - $(NDK_ARCH)" > $@/README.md
	echo "" >> $@/README.md
	echo "This SDK contains headers and libraries for building BPF tools on Android." >> $@/README.md
	echo "" >> $@/README.md
	echo "Contents:" >> $@/README.md
	echo "- include/: Header files" >> $@/README.md
	echo "- lib/: Static (.a) and shared (.so) libraries" >> $@/README.md
	echo "- lib/pkgconfig/: pkg-config files" >> $@/README.md
	echo "- licenses/: License files for all components" >> $@/README.md
