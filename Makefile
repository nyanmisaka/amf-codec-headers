PREFIX = /usr/local
LIBDIR = lib
INSTALL = install
SED = sed

all:
ifeq ($(OS),Windows_NT)
	$(SED) 's#@@PREFIX@@#$(shell cygpath -m ${PREFIX})#' amfcodec.pc.in > amfcodec.pc
else
	$(SED) 's#@@PREFIX@@#$(PREFIX)#' amfcodec.pc.in > amfcodec.pc
endif

install: all
	$(INSTALL) -m 0755 -d '$(DESTDIR)$(PREFIX)/include/AMF/core'
	$(INSTALL) -m 0755 -d '$(DESTDIR)$(PREFIX)/include/AMF/components'
	$(INSTALL) -m 0644 include/core/*.h '$(DESTDIR)$(PREFIX)/include/AMF/core'
	$(INSTALL) -m 0644 include/components/*.h '$(DESTDIR)$(PREFIX)/include/AMF/components'
	$(INSTALL) -m 0755 -d '$(DESTDIR)$(PREFIX)/$(LIBDIR)/pkgconfig'
	$(INSTALL) -m 0644 amfcodec.pc '$(DESTDIR)$(PREFIX)/$(LIBDIR)/pkgconfig'

uninstall:
	rm -rf '$(DESTDIR)$(PREFIX)/include/AMF' '$(DESTDIR)$(PREFIX)/$(LIBDIR)/pkgconfig/amfcodec.pc'

.PHONY: all install uninstall

