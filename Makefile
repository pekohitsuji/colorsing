SHELL   := /bin/bash
RM      := rm -f

GIT_URL = https://github.com/pekohitsuji/$(shell basename $$(pwd)).git
GIT_CHK = git config remote.origin.url
GIT_ADD = git remote add origin $(GIT_URL)

### $(GIFT) 'タイトル' [画像ファイル ...]
GIFT    := gosh ./gift-list
### $(TRANS) 'タイトル' --meta title="タイトル" markdown-file
TRANS   := pandoc -f gfm -t html -s --css ../css/base/colorsing.css
### MARKDOWN | $(FILTER) > HTMLファイル
FILTER  := sed '/<header /,/<\/header>/d'
###
MD2HTML := sed 's/\.md"/.html"/g'

GIFT_HTML := gift-list.html \
             gift-list-effect.html \
             gift-list-valentine-2026.html

GIFT_MD := $(patsubst %.html, %.md, $(GIFT_HTML))

GIFT_LIST := $(wildcard img/gift/?????-???.png)

GIFT_LIST_EFFECT := \
    $(wildcard img/gift/000[7-9][0-9]-???.png \
               img/gift/00[1-9][0-9][0-9]-???.png \
               img/gift/0[1-9][0-9][0-9][0-9]-???.png)

GIFT_LIST_VALENTINE_2026 := \
    $(shell echo img/gift/{00255-001,00288-001,00321-001,00399-001}.png \
               img/gift/{01111-001,01214-001,01222-003,03939-001}.png)

all: index.html $(GIFT_HTML)
	make -C yokotan-stamp
	make -C 2026-06-27-ko

tags: TAGS
	ctags -R -e

clean:
	find -name "*~" -delete
	$(RM) index.html $(GIFT_HTML) $(GIFT_MD)

git:
	if [ ! -d .git ] ; then git init ; fi
	git config --local user.name  pekohitsuji
	git config --local user.email kaeru0921@icloud.com
	if [ -z "$$($(GIT_CHK))" ] ; then $(GIT_ADD) ; fi
	@echo "Do folloings:"
	@echo "    git add ."
	@echo "    git commit -m \"first commit\""
	@echo "    git branch -M main"
	@echo "    git push -u origin main"

index.html: README.md
	$(TRANS) --metadata title="ColorSing あれこれ" $< \
	| $(MD2HTML) | $(FILTER) > $@

gift-list.html: gift-list.md
	$(TRANS) --metadata title="全種" $< > $@

gift-list.md: $(wildcard $(patsubst %.png, %.txt, $(GIFT_LIST)))
	$(GIFT) "全種" $(GIFT_LIST) | $(FILTER) > $@

gift-list-effect.html: gift-list-effect.md
	$(TRANS) --metadata title="70コイン以上" $< > $@

gift-list-effect.md: $(wildcard $(patsubst %.png, %.txt, $(GIFT_LIST_EFFECT)))
	$(GIFT) "70コイン以上" $(GIFT_LIST_EFFECT) | $(FILTER) > $@

gift-list-valentine-2026.html: gift-list-valentine-2026.md
	$(TRANS) --metadata title="よこたんバレンタイン2026" $< > $@

gift-list-valentine-2026.md: $(wildcard $(patsubst %.png, %.txt, $(GIFT_LIST_VALENTINE_2026)))
	$(GIFT) "よこたんバレンタイン2026" $(GIFT_LIST_VALENTINE_2026) | $(FILTER) > $@
