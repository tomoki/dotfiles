EXCLUDES=.git .gitmodules .gitignore
TARGETS =$(wildcard .??*) # it includes .git, gitmodules, ...
ACTUAL  =$(filter-out $(EXCLUDES), $(TARGETS))

fetch-sub:
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

install: fetch-sub
	@$(foreach v, $(ACTUAL), ln -sfv $(abspath $(v)) $(HOME)/$(v);)
