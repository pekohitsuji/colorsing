SHELL   := /bin/bash
RM      := rm -f

IMAGES  := $(wildcard tenipri-parts/*.png) \
           $(wildcard tenipri-result/*.png) \
           $(wildcard portrait/*.jpg) $(wildcard portrait/*.png)

HARVEST := index.html

APP_IMG  := gosh app/img
APP_HTML := gosh app/html  -t "2026 誕生会 こ〜さん" \
                            -c ../css/base.css

all : $(HARVEST)

tags : TAGS
	ctags -R -e

clean :
	find -name "*~" -delete
	$(RM) $(HARVEST)

index.html : $(IMAGES) Makefile
	$(APP_IMG) $(IMAGES) | $(APP_HTML) > $@
