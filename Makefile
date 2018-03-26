SHELL := /bin/bash

DEV_DIR := ${HOME}/development


.PHONY : help
help :
	@echo "Targets:";
	@echo " - zsh";
	@echo " - vim";
	@echo " - sway (including bin, gtk, termite, fonts)";
	@echo " - i3wm (including gtk, termite, fonts and X11)";
	@echo " - polybar (including i3wm)"
	@echo " - spacemacs";
	@echo " - gtk";
	@echo " - X11";
	@echo " - bin";
	@echo " - termite";
	@echo " - fonts";
	@echo " - hidpi (including X11, zsh, gtk)"


.PHONY : all
all : zsh vim sway bin spacemacs


.PHONY : zsh
zsh :
	@[ ! -d ${HOME}/.oh-my-zsh ] \
		&& sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" || true
	$(call copy, ./zsh/zshrc, ${HOME}/.zshrc)
	@touch ${HOME}/.zshrc.local
	$(call copy, ./zsh/zaliases, ${HOME}/.zaliases)
	@touch ${HOME}/.zaliases.local
	$(call copy, ./zsh/zshenv, ${HOME}/.zshenv)
	@touch ${HOME}/.zshenv.local
	@source ${HOME}/.zshrc


.PHONY : vim
vim :
	@[ ! -d ${HOME}/.SpaceVim ] && curl -sLf https://spacevim.org/install.sh | bash || true
	@mkdir -p $(HOME)/.SpaceVim.d
	$(call copy, ./vim/init.vim, ${HOME}/.SpaceVim.d/init.vim)


.PHONY : i3wm
i3wm : pre-build gtk X11 termite fonts
	@rm -rf ${HOME}/.i3;
	$(call copy, ./i3/i3.config, ${HOME}/.config/i3/config)
	$(call copy, ./imgs/desktop-bg.jpg, ${HOME}/.config/i3/)
	$(call copy, ./imgs/terminal-bg.png, ${HOME}/.config/i3/)
	$(call copy, ./imgs/terminal-solarized-bg.png, ${HOME}/.config/i3/)
	$(call copy, ./i3/i3lock.sh, ${HOME}/.i3lock.sh)
	$(call check_prog, arandr feh pactl playerctl termite urxvt terminator \
		lxappearance rofi compton scrot i3blocks i3-msg)
	@echo "Please make sure that imagemagick is installed."
	@[ command -v i3-msg >/dev/null 2>&1 ] || i3-msg reload && true;


.PHONY : polybar
polybar : pre-build i3wm
	$(call copy, ./polybar/polybar.config, ${HOME}/.config/polybar/config)
	$(call check_prog, mopidy)


.PHONY : sway
sway : pre-build bin gtk termite fonts
	$(call copy, ./sway/sway.config, ${HOME}/.config/sway/config)
	$(call copy, ./imgs/Eslimi_3840x2160.jpg, ${HOME}/.config/sway/)
	$(call check_prog, feh termite rofi)
	@echo "Please make sure that imagemagick is installed."


.PHONY : proton
proton : pre-build
	$(call check_prog, lein apm)
	@[ ! -d ${DEV_DIR}/proton ] \
		&& git clone git@github.com:dvcrn/proton.git ${DEV_DIR}/proton || true
	@cd ${DEV_DIR}/proton && lein run -m build/release
	@cd ${DEV_DIR}/proton/plugin && apm install && apm link
	$(call copy, ./proton/proton.edn, ${HOME}/.proton)



.PHONY : spacemacs
spacemacs :
	$(call copy, ./spacemacs/spacemacs.config, ${HOME}/.spacemacs)


# Needs root access
GRUB_DIR := /boot/grub
GRUB_THEMES_DIR := ${GRUB_DIR}/themes
ESLIMI_THEME := grub-eslimi-theme
.PHONY : grub-theme
grub-theme:
	@echo "Installing grub theme at: ${GRUB_THEMES_DIR}/${ESLIMIT_THEME}"
	@mkdir -p ${GRUB_THEMES_DIR}
	@mkdir -p ${GRUB_THEMES_DIR}/${ESLIMIT_THEME}
	@cp -r dotfiles/grub-eslimi-theme/{*.png,icons,theme.txt} ${GRUB_THEMES_DIR}/${ESLIMIT_THEME}
	@sed -i "$(grep -n "GRUB_THEME" /etc/default/grub | cut -d ":" -f1)s/.*/GRUB_THEME=${GRUB_THEMES_DIR}/${ESLIMIT_THEME}/theme.txt/" /etc/default/grub
	@grub-mkconfig -o ${GRUB_DIR}/grub.cfg


.PHONY : gtk
gtk : pre-build
	$(call copy, ./gtk/gtkrc-2.0, ${HOME}/.gtkrc-2.0)
	$(call copy, ./gtk/settings.ini, ${HOME}/.config/gtk-3.0/)


.PHONY : X11
X11 : pre-build
	$(call copy, ./X11/Xresources, ${HOME}/.Xresources)
	$(call copy, ./X11/xinitrc, ${HOME}/.xinitrc)
	$(call copy, ./base16-xresources/xresources/*, ${HOME}/.Xresources.d/themes)
	@echo "Please consider copying ./X11/70-synaptics.conf to /etc/X11/xorg.conf.d/"


.PHONY : bin
bin : pre-build
	$(call copy, ./bin/rofi ./bin/sway, ${HOME}/.local/bin)


.PHONY : termite
TERMITE_THEME := base16-tomorrow-night.config
termite : pre-build
	$(call copy, ./termite/termite.config, ${HOME}/.config/termite/config)
	@echo "Setting termite theme: ${TERMITE_THEME}"
	@cat ./base16-termite/themes/${TERMITE_THEME} >> ${HOME}/.config/termite/config


.PHONY : fonts
fonts : pre-build
	$(call copy, ./YosemiteSanFranciscoFontTTF/*.ttf, ${HOME}/.fonts)
	$(call copy, ./Font-Awesome/fonts/*.ttf, ${HOME}/.fonts)

.PHONY : hidpi
hidpi : pre-build X11 zsh gtk
	@echo "export QT_AUTO_SCREEN_SCALE_FACTOR=1" >> ~/.zshenv.local
	@echo "export GDK_SCALE=2" >> ~/.zshenv.local
	@echo "export GDK_DPI_SCALE=0.5" >> ~/.zshenv.local
	@echo "export ELM_SCALE=1.5" >> ~/.zshenv.local
	@touch ~/.config/chromium-flags.conf
	@echo "--force-device-scale-factor=2" >> ~/.config/chromium-flags.conf
	@echo "alias chromium='chromium --force-device-scale-factor=2'" >> ~/.zaliases
	@echo "alias spotify='spotify --force-device-scale-factor=2'" >> ~/.zaliases
	@sed -i 's/:size.*/:size 20/' ${HOME}/.spacemacs
	@sed -i 's/96/192/' ${HOME}/.local/bin/rofi
	$(call copy, ./bin/spotify, ${HOME}/.local/bin)
	@echo "[GTK +2] Use oomox-git to generate a theme"
	@echo "[FireFox] set parameter layout.css.devPixelsPerPx to 2 in about:config"
	@echo "[Thunderbird] set parameter layout.css.devPixelsPerPx to 2"
	@echo "[Gimp] Use gimp-hidpi"
	# TODO: Side display section of HiDPI article


.PHONY : pre-build
pre-build :
	@mkdir -p ${HOME}/.config;
	@mkdir -p ${HOME}/.config/i3;
	@mkdir -p ${HOME}/.config/sway;
	@mkdir -p ${HOME}/.config/polybar;
	@mkdir -p ${HOME}/.config/termite;
	@mkdir -p ${HOME}/.config/gtk-3.0;
	@mkdir -p ${HOME}/.Xresources.d;
	@mkdir -p ${HOME}/.Xresources.d/themes;
	@mkdir -p ${HOME}/.local;
	@mkdir -p ${HOME}/.local/bin;
	@mkdir -p ${HOME}/.fonts;


define copy
	$(foreach f, ${1}, $(shell cp ${f} ${2}))
	@printf "Copied %s to %s\n" "${1}" ${2}
endef


define check_prog
	$(foreach p, ${1}, $(shell command -v ${p} >/dev/null 2>&1 \
		|| echo >&2 "Please consider installing ${p}.";))
endef
