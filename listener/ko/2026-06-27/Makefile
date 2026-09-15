SHELL   := /bin/bash
RM      := rm -f

# IMAGES  := $(wildcard parts/*.png) \
#            $(wildcard result/*.png) \
#            $(wildcard portrait/*.jpg) $(wildcard portrait/*.png) \
#            $(wildcard portrait/*.mp4)

IMGS := $(shell find parts party portrait result \
                     \( -name "*.jpg" -o -name "*.png" \
                        -o -name "*.mov" -o -name "*.mp4" \) \
                | sort)

APP_IMG  := gosh app/img  -c -l -m
APP_HTML := gosh app/html -t "2026 誕生会 こ〜さん" \
                          -c ../../../css/base.css

HARVEST := index.html

all : $(HARVEST)

tags : TAGS
	ctags -R -e

clean :
	find -name "*~" -delete
	$(RM) $(HARVEST)

index.html : Makefile $(IMGS)
	$(APP_IMG) $(IMGS) | $(APP_HTML) > $@
