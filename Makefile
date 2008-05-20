# set wm name - sets the WM name

include config.mk

SRC = setwmname.c
OBJ = ${SRC:.c=.o}

all: options setwmname

options:
	@echo setwmname build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"
	@echo "LD       = ${LD}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.mk

setwmname: ${OBJ}
	@echo LD $@
	@${LD} -o $@ ${OBJ} ${LDFLAGS}
	@strip $@

clean:
	@echo cleaning
	@rm -f setwmname ${OBJ} setwmname-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p setwmname-${VERSION}
	@cp -R LICENSE Makefile README config.mk ${SRC} setwmname-${VERSION}
	@tar -cf setwmname-${VERSION}.tar setwmname-${VERSION}
	@gzip setwmname-${VERSION}.tar
	@rm -rf setwmname-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f setwmname ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/setwmname

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/setwmname

.PHONY: all options clean dist install uninstall
