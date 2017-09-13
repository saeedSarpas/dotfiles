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
	@[ ! -d ~/.oh-my-zsh ] && sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" || true
	$(call copy, ./zsh/zshrc, ~/.zshrc)
	$(call copy, ./zsh/zaliases, ~/.zaliases)
	$(call copy, ./zsh/zaliases.arch, ~/.zaliases.arch)
	$(call copy, ./zsh/zaliases.i3, ~/.zaliases.i3)
	@touch ~/.zshenv
	@source ~/.zshrc

.PHONY : vim
vim :
	@[ ! -d ~/.spf13-vim-3 ] && sh <(curl https://j.mp/spf13-vim3 -L) || true
	$(call copy, ./vim/vimrc.local, ~/.vimrc.local)

.PHONY : i3wm
i3wm :
	$(call init_i3wm)
	$(call copy, ./i3/i3-config, ~/.config/i3/config)
	$(call copy, ./YosemiteSanFranciscoFontTTF/*.ttf, ~/.fonts)
	$(call copy, ./Font-Awesome/fonts/*.ttf, ~/.fonts)
	$(call copy, ./imgs/desktop-bg.jpg, ~/.config/i3/)
	$(call copy, ./imgs/terminal-bg.png, ~/.config/i3/)
	$(call copy, ./imgs/terminal-solarized-bg.png, ~/.config/i3/)
	$(call copy, ./i3/gtkrc-2.0, ~/.gtkrc-2.0)
	$(call copy, ./i3/settings.ini, ~/.config/gtk-3.0/)
	$(call copy, ./i3/Xresources, ~/.Xresources)
	$(call copy, ./i3/termite-config, ~/.config/termite/config)
	$(call copy, ./base16-xresources/xresources/*, ~/.Xresources.d/themes)
	@xrdb -load ~/.Xresources;
	$(call copy, ./i3/i3lock.sh, ~/.i3lock.sh)
	$(call check_prog, arandr feh pactl playerctl termite urxvt terminator \
		lxappearance rofi compton scrot i3blocks)
	@echo "Please make sure that imagemagick is installed."
	@i3-msg reload


.PHONY : spacemacs
spacemacs :
	$(call copy, ./spacemacs/spacemacs-config, ~/.spacemacs)

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
	@mkdir -p ~/.Xresources.d;
	@mkdir -p ~/.Xresources.d/themes;
endef
