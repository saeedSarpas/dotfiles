SHELL := /bin/bash

DEV_DIR := ${HOME}/development


.PHONY : help
help :
	@echo "Targets:";
	@echo " - vim";
	@echo " - sway (including bin, gtk, termite, fonts)";
	@echo " - polybar"
	@echo " - spacemacs";
	@echo " - gtk";
	@echo " - X11";
	@echo " - bin";
	@echo " - termite";
	@echo " - fonts";
	@echo " - hidpi (including X11, zsh, gtk)"


.PHONY : all
all : sway bin spacemacs


.PHONY : polybar
polybar : pre-build
	$(call copy, ./polybar/polybar.config, ${HOME}/.config/polybar/config)
	$(call copy, ./polybar/polybar-launch.sh, $(HOME)/.config/polybar/launch.sh)
	@chmod +x $(HOME)/.config/polybar/launch.sh
	$(call check_prog, mopidy)
	@echo "Please consider installing illum package for brighness control"


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
	@cp -r ./grub-eslimi-theme/{*.png,icons,theme.txt} ${GRUB_THEMES_DIR}/${ESLIMIT_THEME}
	@sed -i "$(grep -n "GRUB_THEME" /etc/default/grub | cut -d ":" -f1)s/.*/GRUB_THEME=${GRUB_THEMES_DIR}/${ESLIMIT_THEME}/theme.txt/" /etc/default/grub
	@grub-mkconfig -o ${GRUB_DIR}/grub.cfg


.PHONY : gtk
gtk : pre-build
	$(call copy, ./gtk/gtkrc-2.0, ${HOME}/.gtkrc-2.0)
	$(call copy, ./gtk/settings.ini, ${HOME}/.config/gtk-3.0/)
	./Qogir-theme/Install


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
	@sed -i 's/^background.*/background\ =\ rgba\(29\,31\,33\,0.8\)/' ${HOME}/.config/termite/config


.PHONY : fonts
fonts : pre-build
	$(call copy, ./YosemiteSanFranciscoFontTTF/*.ttf, ${HOME}/.fonts)
	$(call copy, ./Font-Awesome/fonts/*.ttf, ${HOME}/.fonts)

.PHONY : hidpi
hidpi :
	$(append_env "export QT_AUTO_SCREEN_SCALE_FACTOR=1" ${HOME}/.zshenv.local)
	$(append_env "export GDK_SCALE=2" ${HOME}/.zshenv.local)
	$(append_env "export GDK_DPI_SCALE=0.5" ${HOME}/.zshenv.local)
	$(append_env "export ELM_SCALE=1.5" ${HOME}/.zshenv.local)
	@touch ${HOME}/.config/chromium-flags.conf
	$(append_env "--force-device-scale-factor=2" ${HOME}/.config/chromium-flags.conf)
	$(append_env "alias chromium='chromium --force-device-scale-factor=2'" ${HOME}/.zaliases.local)
	$(append_env "alias spotify='spotify --force-device-scale-factor=2'" ${HOME}/.zaliases.local)
	# @sed -i 's/:size.*/:size 20/' ${HOME}/.spacemacs
	@sed -i 's/96/192/' ${HOME}/.local/bin/rofi
	@sed -i 's/96/192/' ${HOME}/.Xresources
	$(call copy, ./bin/spotify, ${HOME}/.local/bin)
	@echo "[GTK +2] Use oomox-git to generate a theme"
	@echo "[FireFox] set parameter layout.css.devPixelsPerPx to 2 in about:config"
	@echo "[Thunderbird] set parameter layout.css.devPixelsPerPx to 2"
	@echo "[Gimp] Use gimp-hidpi"
	# TODO: Side display section of HiDPI article


.PHONY : pre-build
pre-build :
	@mkdir -p ${HOME}/.config;
	@mkdir -p ${HOME}/.config/sway;
	@mkdir -p ${HOME}/.config/polybar;
	@mkdir -p ${HOME}/.config/termite;
	@mkdir -p ${HOME}/.config/gtk-3.0;
	@mkdir -p ${HOME}/.Xresources.d;
	@mkdir -p ${HOME}/.Xresources.d/themes;
	@mkdir -p ${HOME}/.local;
	@mkdir -p ${HOME}/.local/bin;
	@mkdir -p ${HOME}/.fonts;


.PHONY : mpv
mpv :
	@mkdir -p ${HOME}/.config/mpv
	$(call copy, ./mpv/input.conf, ${HOME}/.config/mpv/input.conf)


.PHONY : screen
screen :
	$(call copy, ./screen/screenrc, ${HOME}/.screenrc)


.PHONY : irssi
irssi :
	@mkdir -p ${HOME}/.irssi
	$(call copy, ./irssi/config, ${HOME}/.irssi/config)
	@mkdir -p ${HOME}/.irssi/scripts
	@mkdir -p ${HOME}/.irssi/scripts/autorun
	@rm -rf ${HOME}/.irssi/scripts/autorun/uberprompt.pl ${HOME}/.irssi/scripts/autorun/vim_mode.pl
	@ln -s "$$(pwd)/irssi-scripts/vim-mode/irssi/scripts/autorun/uberprompt.pl" ${HOME}/.irssi/scripts/autorun
	@ln -s "$$(pwd)/irssi-scripts/vim-mode/irssi/scripts/autorun/vim_mode.pl" ${HOME}/.irssi/scripts/autorun


define copy
$(foreach f, ${1}, $(shell cp ${f} ${2}))
@printf "Copied %s to %s\n" "${1}" ${2}
endef


define check_prog
$(foreach p, ${1}, $(shell command -v ${p} >/dev/null 2>&1 \
	|| echo >&2 "Please consider installing ${p}.";))
endef


define apm_install_packages
@[ ! -d ${HOME}/.oh-my-zsh ] && apm install $1 || true
endef

define apm_install
@$(foreach p,$1,$(call apm_install_packages $p))
endef

define append_env
@if grep -Fxq $(rg_export) $2 >/dev/null 2>&1; then \
	echo "$2 already contains $1"; \
	else \
	echo "$1 > $2"; \
	echo $1 > $2; \
	fi
endef
