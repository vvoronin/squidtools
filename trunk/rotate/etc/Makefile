include ../../Makefile.include

ROTATE_BASEDIR=$(BASEDIR)/rotate
ROTATE_BINDIR=$(BASEDIR)/bin
ROTATE_ETCDIR=$(ROTATE_BASEDIR)/etc

all:

install:
	$(INSTALL_DIR) $(BASEDIR)
	$(INSTALL_DIR) $(ROTATE_BASEDIR)
	$(INSTALL_DIR) $(ROTATE_ETCDIR)
	$(INSTALL_FILE) proxylog.conf $(ROTATE_ETCDIR)

clean:
	$(RM) -f $(TARGETS)

