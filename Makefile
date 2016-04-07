EXCLUDES=.git .gitmodules .gitignore
TARGETS =$(wildcard .??*) # it includes .git, gitmodules, ...
ACTUAL  =$(filter-out $(EXCLUDES), $(TARGETS))

install:
	@$(foreach v, $(ACTUAL), ln -sfv $(abspath $(v)) $(HOME)/$(v);)
