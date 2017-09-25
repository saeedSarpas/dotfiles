SHELL := /bin/bash


.PHONY : help
help :
	@echo "Targets:";
	@echo " - zsh";
	@echo " - vim";
	@echo " - i3wm (including gtk, termite, fonts and X11)";
	@echo " - spacemacs";
	@echo " - gtk";
	@echo " - X11";
	@echo " - termite";
	@echo " - fonts";


.PHONY : all
all : zsh vim i3wm spacemacs


.PHONY : zsh
zsh :
	@[ ! -d ~/.oh-my-zsh ] && sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" || true
	$(call copy, ./zsh/zshrc, ~/.zshrc)
	$(call copy, ./zsh/zaliases, ~/.zaliases)
	$(call copy, ./zsh/zaliases.arch, ~/.zaliases.arch)
	$(call copy, ./zsh/zaliases.i3, ~/.zaliases.i3)
	$(call copy, ./zsh/zshenv, ~/.zshenv)
	@touch ~/.zshenv.local
	@source ~/.zshrc


.PHONY : vim
vim :
	@[ ! -d ~/.spf13-vim-3 ] && sh <(curl https://j.mp/spf13-vim3 -L) || true
	$(call copy, ./vim/vimrc.local, ~/.vimrc.local)


.PHONY : i3wm
i3wm : gtk X11 termite fonts
	@rm -rf ~/.i3;
	@mkdir -p ~/.config;
	@mkdir -p ~/.config/i3;
	$(call copy, ./i3/i3-config, ~/.config/i3/config)
	$(call copy, ./imgs/desktop-bg.jpg, ~/.config/i3/)
	$(call copy, ./imgs/terminal-bg.png, ~/.config/i3/)
	$(call copy, ./imgs/terminal-solarized-bg.png, ~/.config/i3/)
	@xrdb -load ~/.Xresources;
	$(call copy, ./i3/i3lock.sh, ~/.i3lock.sh)
	$(call check_prog, arandr feh pactl playerctl termite urxvt terminator \
		lxappearance rofi compton scrot i3blocks i3-msg)
	@echo "Please make sure that imagemagick is installed."
	@[ command -v i3-msg >/dev/null 2>&1 ] || i3-msg reload && true;


.PHONY : spacemacs
spacemacs :
	$(call copy, ./spacemacs/spacemacs-config, ~/.spacemacs)


.PHONY : gtk
gtk :
	@mkdir -p ~/.config;
	@mkdir -p ~/.config/gtk-3.0;
	$(call copy, ./gtk/gtkrc-2.0, ~/.gtkrc-2.0)
	$(call copy, ./gtk/settings.ini, ~/.config/gtk-3.0/)


.PHONY : X11
X11 :
	@mkdir -p ~/.Xresources.d;
	@mkdir -p ~/.Xresources.d/themes;
	$(call copy, ./X11/Xresources, ~/.Xresources)
	$(call copy, ./base16-xresources/xresources/*, ~/.Xresources.d/themes)
	@xrdb -load ~/.Xresources;


.PHONY : termite
termite :
	@mkdir -p ~/.config;
	@mkdir -p ~/.config/termite;
	$(call copy, ./termite/termite-config, ~/.config/termite/config)
	@xrdb -load ~/.Xresources;


.PHONY : fonts
fonts :
	@mkdir -p ~/.fonts;
	$(call copy, ./YosemiteSanFranciscoFontTTF/*.ttf, ~/.fonts)
	$(call copy, ./Font-Awesome/fonts/*.ttf, ~/.fonts)


define copy
	$(foreach f, ${1}, $(shell cp ${f} ${2}))
	@printf "Copied %s to %s\n" "${1}" ${2}
endef


define check_prog
	$(foreach p, ${1}, $(shell command -v ${p} >/dev/null 2>&1 \
		|| echo >&2 "Please consider installing ${p}.";))
endef
