#!/bin/bash
# -*- coding: utf-8-unix; mode: shell-script -*-

gosh ./gift-list '70 コイン以上' img/gift/?????-???.png > gift-list.md
gosh ./gift-list 'ハート限定' img/gift/{00255-001,00288-001,00321-001,00399-001,01111-001,01214-001,01222-003,03939-001}.png > gift-list-heart.md

function trans() {
    pandoc -f gfm -t html \
           -s --css css/base.css --metadata title="${1}" ${@:2}
}

trans "70コイン以上" gift-list.md       -o gift-list.html
trans "ハート限定"   gift-list-heart.md -o gift-list-heart.html

trans 'ColorSing あれこれ'  README.md | sed 's/\.md"/.html"/g' > index.html
