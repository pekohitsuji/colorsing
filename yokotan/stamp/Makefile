SHELL   := /bin/bash
RM      := rm -f

IMAGES := $(shell find \
            \( -name "*.jpg" -o -name "*.png" \
            -o -name "*.mov" -o -name "*.mp4" \) \
            | sort)

HARVEST := index.html

APP_IMG  := gosh app/img -c -l -m
APP_HTML := gosh app/html  -t "よこたんスタンプ 314x314 背景透過PNG" \
                           -c ../../css/base.css

all : $(HARVEST)

tags : TAGS
	ctags -R -e

clean :
	find -name "*~" -delete
	$(RM) $(HARVEST)

index.html : $(IMAGES) Makefile
	$(APP_IMG) $(IMAGES) | $(APP_HTML) > $@
