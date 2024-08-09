# Copyright (c) Meta Platforms, Inc. and affiliates.

$(eval $(call project-define,gnulib))

$(GNULIB_ANDROID):
	echo "gnulib build is not supported"
	false

GNULIB_COMMIT_HASH = 81868618e1f25b4f30b4aac5640da9c608320e30
GNULIB_REPO = https://github.com/coreutils/gnulib.git
projects/gnulib/sources:
	git clone $(GNULIB_REPO) $@
	cd $@ && git checkout $(GNULIB_COMMIT_HASH)
