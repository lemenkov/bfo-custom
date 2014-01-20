all: bin bin/pxelinux.cfg
	$(MAKE) EMBED=../../script0.ipxe -C ipxe/src

	# Copy IPXE bins
	cp -af ipxe/src/bin/ipxe.dsk bin/
	cp -af ipxe/src/bin/ipxe.iso bin/
	cp -af ipxe/src/bin/ipxe.lkrn bin/
	cp -af ipxe/src/bin/ipxe.pxe bin/
	cp -af ipxe/src/bin/ipxe.usb bin/

	# Copy or create necessary configs
	cp -af pxelinux.cfg/default.custom bin/pxelinux.cfg/default
	cp -af pxelinux.cfg/centos_install.conf bin/pxelinux.cfg/centos_install.conf
	cp -af pxelinux.cfg/fedora_install.conf bin/pxelinux.cfg/fedora_install.conf
	cp -af pxelinux.cfg/fedora_rescue.conf bin/pxelinux.cfg/fedora_rescue.conf
	cp -af fedora.conf bin/fedora.conf
	cp -af bfo.png bin/bfo.png

	# Copy binary modules (requires syslinux installed)
	cp -af /usr/share/syslinux/pxelinux.0 bin/pxelinux.0
	cp -af /usr/share/syslinux/vesamenu.c32 bin/vesamenu.c32
	# FIXME is it still necessary?
	cp -af /usr/share/syslinux/vesainfo.c32 bin/vesainfo.c32

bin:
	test -d ./bin/ || mkdir -p ./bin/

bin/pxelinux.cfg:
	test -d ./bin/pxelinux.cfg/ || mkdir -p ./bin/pxelinux.cfg/

clean:
	$(MAKE) -C ipxe/src clean
	@rm -rf bin/
