#!/bin/bash
# -*- coding: utf-8-unix; mode: shell-script -*-

function trans() {
    pandoc -f gfm -t html \
           -s --css css/base.css --metadata title="${1}" ${@:2}
}

function filter() {
    sed '/<header /,/<\/header>/d'
}

trans "ColorSing あれこれ" README.md | \
    sed 's/\.md"/.html"/g' | \
    filter > index.html


gosh ./gift-list '全種' \
     img/gift/?????-???.png \
    | filter > gift-list.md

trans "全種" gift-list.md \
    | filter > gift-list.html


gosh ./gift-list '70 コイン以上' \
     img/gift/000[7-9][0-9]-???.png \
     img/gift/00[1-9][0-9][0-9]-???.png \
     img/gift/0[1-9][0-9][0-9][0-9]-???.png \
    | filter > gift-list-effect.md

trans "70コイン以上" gift-list-effect.md \
    | filter > gift-list-effect.html


gosh ./gift-list 'よこたんバレンタイン2026' \
     img/gift/{00255-001,00288-001,00321-001,00399-001}.png \
     img/gift/{01111-001,01214-001,01222-003,03939-001}.png \
    | filter > gift-list-valentine.md


trans "よこたんバレンタイン2026" gift-list-valentine.md \
    | filter > gift-list-valentine.html
