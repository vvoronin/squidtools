include ../../Makefile.include

ROTATE_BASEDIR=$(BASEDIR)/rotate
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

clean:
	$(RM) -f $(TARGETS)

