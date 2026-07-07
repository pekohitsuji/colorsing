SHELL   := /bin/bash
RM      := rm -f

LINKS   := $(shell find \
             \( -name "*.html" -a ! -name "index.html" \) \
             | sort)

HARVEST := index.html

APP_IMG  := gosh app/img -c -l -m
APP_HTML := gosh app/html  -t "よこたんカレンダー" \
                           -c ../../css/base.css

all : $(HARVEST)

tags : TAGS
	ctags -R -e

clean :
	find -name "*~" -delete
	$(RM) $(HARVEST)

index.html : $(LINKS) Makefile
	$(APP_IMG) $(LINKS) | $(APP_HTML) > $@
