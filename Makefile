FORCE = false
ARCH  = false
I3    = false

.PHONY : help
help :
	@echo "zshrc:"; \
	echo "\tUse \`$ make zshrc\` to copy configuration files."; \
	echo "\tFor overwriting the current zshrc related file, set \`FORCE=true\`."; \
	echo "\tFor also copying the archlinux aliases, set \`ARCH=true\`."; \
	echo "\tFor also copying the i3wm aliases, set \`I3=true\`."; \
	echo "\n"; \
	echo "vim:"; \
	echo "\tUse \`$ make vim\` to copy vim configuration files."; \
	echo "\tFor overwriting the current vimrc.local file, set \`FORCE=true\`."; \
	echo ""; \
	echo "i3wm:"; \
	echo "\tUse \`$ make i3wm\` to copy i3wm configuration files."; \
	echo "\tFor overwriting the current i3wm config file, set \`FORCE=true\`.";
	echo ""; \
	echo "spacemacs:"; \
	echo "\tUse \`$ make spacemacs\` to copy spacemacs configuration files."; \
	echo "\tFor overwriting the current spacemacs config file, set \`FORCE=true\`.";

.PHONY : zshrc
zshrc :
	@if [ \( ! -f ~/.zshrc -a ! -f ~/.zaliases \) -o \( "${FORCE}" = true \) ]; \
	then \
		echo "Copyting zshrc and zaliases..."; \
		cp -f ./zshrc ~/.zshrc; \
		cp -f ./zaliases ~/.zaliases; \
		if [ "${ARCH}" = true ]; \
		then \
			echo "Copyting archlinux aliases..."; \
			echo "\n# archlinux aliases\nsource ~/.zaliases.arch" >> ~/.zshrc; \
			cp -f zaliases.arch ~/.zaliases.arch; \
		fi; \
		if [ "${I3}" = true ]; \
		then \
			echo "Copyting i3wm aliases..."; \
			echo "\n# i3wm aliases\nsource ~/.zaliases.i3" >> ~/.zshrc; \
			cp -f zaliases.i3 ~/.zaliases.i3; \
		fi \
	else \
		echo "err: The zshrc dotfile is already exist."; \
		echo "Use \`$ make FORCE=true\` to overwrite it."; \
	fi; \
	touch ~/.zshenv

.PHONY : vim
vim :
	@if [ \( ! -f ~/.vimrc.local \) -o \( "${FORCE}" = true \) ]; \
	then \
		echo "Copyting vimrc.local file..."; \
		cp -f vimrc.local ~/.vimrc.local; \
	fi

.PHONY : i3wm
i3wm :
	@if [ \( ! -f ~/.i3/config -a ! -f ~/.config/i3/config \) -o \( "${FORCE}" = true \) ]; \
	then \
		if [ -d ~/.i3 ]; \
		then \
			echo "Copyting i3wm config file to \`~/.i3/config\`..."; \
			cp -f i3-config ~/.i3/config; \
		else \
			echo "Copyting i3wm config file to \`~/.config/i3/config\`..."; \
			mkdir -p ~/.config/i3; \
			cp -f i3-config ~/.config/i3/config; \
		fi; \
		echo "Copyting i3wm status file..."; \
		if [ \( ! -f ~/.i3status.config \) -o \( "${FORCE}" = true \) ]; \
		then \
			cp -f i3-status ~/.i3status.conf; \
		fi \
	fi

.PHONY : spacemacs
spacemacs :
	@if [ \( ! -f ~/.spacemacs \) -o \( "${FORCE}" = true \) ]; \
	then \
		echo "Copyting spacemacs config file..."; \
		cp -f spacemacs ~/.spacemacs; \
	fi
