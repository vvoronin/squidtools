include ../../Makefile.include

SRCS=log_compress.in log_rename.in log_runstats.in log_dateprefix.in log_rotate.in
TARGETS=log_compress log_rename log_runstats log_dateprefix log_rotate

all: $(SRCS)
	@for i in $(SRCS); do \
		TARGET="`echo $$i | sed s/\.in$$//`"; \
		echo Converting $$i to $$TARGET; \
		cat $$i | \
			sed 's!@BASEDIR@!$(BASEDIR)!' | \
			sed 's!@ETCDIR@!$(ETCDIR)!' \
		> $$TARGET ; \
	done

install:

clean:
	$(RM) -f $(TARGETS)

