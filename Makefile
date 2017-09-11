SHELL := /bin/bash

.PHONY : help
help :
	@echo "zshrc:";
	@echo "Use \`$ make zshrc\` to copy configuration files.";
	@echo "";
	@echo "vim:";
	@echo "Use \`$ make vim\` to copy vim configuration files.";
	@echo "";
	@echo "i3wm:";
	@echo "Use \`$ make i3wm\` to copy i3wm configuration files.";
	@echo "";
	@echo "spacemacs:";
	@echo "Use \`$ make spacemacs\` to copy spacemacs configuration files.";
	@echo "";
	@echo "all:";
	@echo "Use \`$ make all\` to run all the above targets.";

.PHONY : all
all : zshrc vim i3wm spacemacs

.PHONY : zshrc
zshrc :
	$(call copy, ./zshrc, ~/.zshrc)
	$(call copy, ./zaliases, ~/.zaliases)
	$(call copy, zaliases.arch, ~/.zaliases.arch)
	$(call copy, zaliases.i3, ~/.zaliases.i3)
	@touch ~/.zshenv
	@source ~/.zshrc

.PHONY : vim
vim :
	$(call copy, vimrc.local, ~/.vimrc.local)

.PHONY : i3wm
i3wm :
	$(call init_i3wm)
	$(call copy, ./i3-config, ~/.config/i3/config)
	$(call copy, ./YosemiteSanFranciscoFont/Text\ Face\ \(alternate\)/*.ttf, ~/.fonts)
	$(call copy, ./Font-Awesome/fonts/*.ttf, ~/.fonts)
	$(call copy, ./imgs/desktop-bg.jpg, ~/.config/i3/)
	$(call copy, ./imgs/terminal-bg.png, ~/.config/i3/)
	$(call copy, ./imgs/terminal-solarized-bg.png, ~/.config/i3/)
	$(call copy, ./gtkrc-2.0, ~/.gtkrc-2.0)
	$(call copy, ./settings.ini, ~/.config/gtk-3.0/)
	$(call copy, ./Xresources, ~/.Xresources)
	$(call copy, ./termite-config, ~/.config/termite/config)
	@xrdb ~/.Xresources;
	$(call copy, ./i3lock.sh, ~/.i3lock.sh)
	$(call check_prog, arandr feh pactl playerctl termite urxvt terminator \
		lxappearance rofi compton scrot i3blocks)
	@echo "Please make sure that imagemagick is installed."
	@i3-msg reload


.PHONY : spacemacs
spacemacs :
	$(call copy, spacemacs, ~/.spacemacs)

define copy
	$(foreach f, ${1}, $(shell cp ${f} ${2}))
	@printf "Copied %s to %s\n" "${1}" ${2}
endef

define check_prog
	$(foreach p, ${1}, $(shell command -v ${p} >/dev/null 2>&1 \
		|| echo >&2 "Please consider installing ${p}.";))
endef

define init_i3wm
	@rm -rf ~/.i3;
	@mkdir -p ~/.fonts;
	@mkdir -p ~/.config;
	@mkdir -p ~/.config/i3;
	@mkdir -p ~/.config/gtk-3.0;
	@mkdir -p ~/.config/termite;
endef
