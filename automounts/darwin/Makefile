all: /etc/auto_master /etc/auto_u /etc/auto_r restart

/etc/auto_master: auto_master
	sudo install $< $@

/etc/auto_u: auto_u
	sudo install $< $@

/etc/auto_r: auto_r
	sudo install $< $@

.PHONY: restart
restart:
	sudo automount -v
