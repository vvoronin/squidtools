include ../Makefile.include
SUBDIRS=bin etc

all:
	@for i in $(SUBDIRS); do \
		echo "Making all in $$i.."; \
		( cd $$i && $(MAKE) all ); \
	done

install:
	@for i in $(SUBDIRS); do \
		echo "Making install in $$i.."; \
		( cd $$i && $(MAKE) install ); \
	done

clean:
	@for i in $(SUBDIRS); do \
		echo "Making clean in $$i.."; \
		( cd $$i && $(MAKE) clean ); \
	done
