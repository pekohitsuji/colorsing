SHELL   := /bin/bash
RM      := rm -f

# IMAGES  := $(wildcard tenipri-parts/*.png) \
#            $(wildcard tenipri-result/*.png) \
#            $(wildcard portrait/*.jpg) $(wildcard portrait/*.png) \
#            $(wildcard portrait/*.mp4)

IMAGES := $(shell find portrait tenipri-parts tenipri-result \
            \( -name "*.jpg" -o -name "*.png" \
            -o -name "*.mov" -o -name "*.mp4" \) \
            | sort)

HARVEST := index.html

APP_IMG  := gosh app/img -c -l -m
APP_HTML := gosh app/html  -t "2026 誕生会 こ〜さん" \
                            -c ../../../css/base.css

all : $(HARVEST)

tags : TAGS
	ctags -R -e

clean :
	find -name "*~" -delete
	$(RM) $(HARVEST)

index.html : $(IMAGES) Makefile
	$(APP_IMG) $(IMAGES) | $(APP_HTML) > $@
