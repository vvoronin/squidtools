include ../Makefile.include

all:

install:
	$(INSTALL_DIR) $(BASEDIR)
	$(INSTALL_DIR) $(BASEDIR)/rotate
	$(INSTALL_DIR) $(BASEDIR)/rotate/bin
	$(INSTALL_DIR) $(BASEDIR)/rotate/etc
	$(INSTALL_BIN) bin/log_compress $(BASEDIR)/rotate/bin
	$(INSTALL_BIN) bin/log_dateprefix $(BASEDIR)/rotate/bin
	$(INSTALL_BIN) bin/log_rename $(BASEDIR)/rotate/bin
	$(INSTALL_BIN) bin/log_rotate $(BASEDIR)/rotate/bin
	$(INSTALL_BIN) bin/log_runstats $(BASEDIR)/rotate/bin
	$(INSTALL_ETC) etc/proxylog.conf $(BASEDIR)/rotate/etc

clean:
