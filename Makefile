PREFIX = /usr/local

bom: bom.sh bom.awk bom.tsv
	cat bom.sh > $@
	echo 'exit 0' >> $@
	echo '#EOF' >> $@
	tar czf - bom.awk bom.tsv >> $@
	chmod +x $@

test: bom.sh
	shellcheck -s sh bom.sh

clean:
	rm -f bom

install: bom
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f bom $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/bom

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/bom

.PHONY: test clean install uninstall
