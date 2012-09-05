.PHONY: module install uninstall dist-tgz dist-clean

MANAGE=/usr/local/cpanel/bin/manage_hooks

ACCT_CREATE_MODULE=CustomAccount::CreateAcct
ACCT_CREATE_PM=CreateAcct.pm

install:
	$(MANAGE) add module $(ACCT_CREATE_MODULE)

uninstall:
	$(MANAGE) delete module $(ACCT_CREATE_MODULE)

dist-tgz:
	tar -czvf CustomAccount.tar.gz CreateAcct.pm Makefile

dist-clean:
	rm CustomAccount.tar.gz
