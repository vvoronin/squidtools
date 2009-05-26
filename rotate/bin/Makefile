include ../../Makefile.include

ROTATE_BASEDIR=$(BASEDIR)/rotate
ROTATE_BINDIR=$(BASEDIR)/bin
ROTATE_ETCDIR=$(ROTATE_BASEDIR)/etc

SRCS=log_compress.in log_rename.in log_runstats.in log_dateprefix.in log_rotate.in
TARGETS=log_compress log_rename log_runstats log_dateprefix log_rotate

all: $(SRCS)
	@for i in $(SRCS); do \
		TARGET="`echo $$i | sed s/\.in$$//`"; \
		echo Converting $$i to $$TARGET; \
		cat $$i | \
			sed 's!@ROTATE_BASEDIR@!$(ROTATE_BASEDIR)!' | \
			sed 's!@ROTATE_ETCDIR@!$(ROTATE_ETCDIR)!' \
		> $$TARGET ; \
	done

install:
	$(INSTALL_DIR) $(BASEDIR)
	$(INSTALL_DIR) $(ROTATE_BASEDIR)
	$(INSTALL_DIR) $(ROTATE_BINDIR)
	$(INSTALL_DIR) $(ROTATE_ETCDIR)
	$(INSTALL_BIN) log_compress $(ROTATE_BINDIR)
	$(INSTALL_BIN) log_dateprefix $(ROTATE_BINDIR)
	$(INSTALL_BIN) log_rename $(ROTATE_BINDIR)
	$(INSTALL_BIN) log_rotate $(ROTATE_BINDIR)
	$(INSTALL_BIN) log_runstats $(ROTATE_BINDIR)
	# $(INSTALL_FILE) proxylog.conf $(BASEDIR)/rotate/etc

clean:
	$(RM) -f $(TARGETS)

