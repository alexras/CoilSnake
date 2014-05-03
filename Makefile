CCSCRIPT_SRC_DIR=ccscript_legacy/src
CCSCRIPT_EXE=$(CCSCRIPT_SRC_DIR)/bin/ccc

MOBILE_SPROUT_LIB_DIR=mobile-sprout/lib

ASSETS_CCSCRIPT_DIR=coilsnake/assets/ccc
ASSETS_CCSCRIPT_EXE=$(ASSETS_CCSCRIPT_DIR)/ccc
ASSETS_CCSCRIPT_LIB_DIR=$(ASSETS_CCSCRIPT_DIR)/lib

all: coilsnake_lib ccscript mobile_sprout

install: all
	python setup.py install
	python script/post_install.py

test: coilsnake_lib
	python setup.py test

coverage: coilsnake_lib
	script/coverage.sh

coilsnake_lib:
	python setup.py build_ext --inplace clean

ccscript: submodule
	cd $(CCSCRIPT_SRC_DIR) ; \
		make
	cp $(CCSCRIPT_EXE) $(ASSETS_CCSCRIPT_EXE)

mobile_sprout: submodule
	cp -r $(MOBILE_SPROUT_LIB_DIR)/* $(ASSETS_CCSCRIPT_LIB_DIR)

submodule:
	git submodule init
	git submodule update

clean:
	python setup.py clean
	cd $(CCSCRIPT_SRC_DIR) ; \
		make clean
	rm -f $(ASSETS_CCSCRIPT_EXE)
	rm -f $(ASSETS_CCSCRIPT_LIB_DIR)/*.ccs