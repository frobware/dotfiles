.PHONY: restart
restart: /etc/auto_master /etc/auto_u /etc/auto_r
	sudo automount -vc

/etc/auto_master: auto_master
	sudo install $< $@

## These /etc/auto_<X> files must be 0600 when installed or they will
## silently fail to work.

/etc/auto_u: auto_u
	sudo install -m 644 $< $@

/etc/auto_r: auto_r
	sudo install -m 644 $< $@
