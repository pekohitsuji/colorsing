#!/bin/bash
# -*- coding: utf-8-unix; mode: shell-script -*-

function trans() {
    pandoc -f gfm -t html \
           -s --css css/base.css --metadata title="${1}" ${@:2}
}

function filter() {
    sed '/<header /,/<\/header>/d'
}

gosh ./gift-list '70 コイン以上' \
     img/gift/?????-???.png \
    | filter > gift-list.md

gosh ./gift-list 'よこたんバレンタイン' \
     img/gift/{00255-001,00288-001,00321-001,00399-001}.png \
     img/gift/{01111-001,01214-001,01222-003,03939-001}.png \
    | filter > gift-list-valentine.md


trans "70コイン以上" gift-list.md \
    | filter > gift-list.html

trans "よこたんバレンタイン"   gift-list-valentine.md \
    | filter > gift-list-valentine.html

trans "ColorSing あれこれ" README.md | \
    sed 's/\.md"/.html"/g' | \
    filter > index.html
