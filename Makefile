SHELL := /bin/bash

DEV_DIR := ${HOME}/development


.PHONY : help
help :
	@echo "Targets:";
	@echo " - hidpi"
	@echo " - irssi"


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
	@sed -i 's/96/192/' ${HOME}/.Xresources
	$(call copy, ./bin/spotify, ${HOME}/.local/bin)
	@echo
	@echo "[FireFox] set parameter layout.css.devPixelsPerPx to 2 in about:config"
	@echo "[Thunderbird] set parameter layout.css.devPixelsPerPx to 2"
	@echo "[Gimp] Use gimp-hidpi"
	# TODO: Side display section of HiDPI article


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


define append_env
@if grep -Fxq $(rg_export) $2 >/dev/null 2>&1; then \
	echo "$2 already contains $1"; \
	else \
	echo "$1 > $2"; \
	echo $1 > $2; \
	fi
endef
