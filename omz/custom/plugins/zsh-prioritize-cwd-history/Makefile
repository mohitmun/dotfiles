SRC_DIR    := ./src
SCRIPT_DIR := ./script

SRC_FILES := \
	$(SRC_DIR)/opts.zsh \
	$(SRC_DIR)/config.zsh \
	$(SRC_DIR)/histrefs.zsh \
	$(SRC_DIR)/hooks.zsh


HEADER_FILES := \
	DESCRIPTION \
	URL \
	VERSION \
	LICENSE

PLUGIN_TARGET := zsh-prioritize-cwd-history.zsh
OH_MY_ZSH_LINK_TARGET := zsh-prioritize-cwd-history.plugin.zsh

ALL_TARGETS := \
	$(PLUGIN_TARGET) \
	$(OH_MY_ZSH_LINK_TARGET)

all: $(ALL_TARGETS)

$(PLUGIN_TARGET): $(HEADER_FILES) $(SRC_FILES)
	cat $(HEADER_FILES) | sed -e 's/^/# /g' > $@
	cat $(SRC_FILES) >> $@

$(OH_MY_ZSH_LINK_TARGET): $(PLUGIN_TARGET)
	ln -s $(PLUGIN_TARGET) $@

.PHONY: clean
clean:
	rm $(ALL_TARGETS)
