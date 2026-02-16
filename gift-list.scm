;;; -*- coding: utf-8-unix; mode: scheme -*-
(import (scheme base))
(import (scheme list))            ; count
(import (scheme write))           ; display
(import (scheme file))            ; with-input-from-file
(import (srfi 19))                ; current-date, date-year, date-month
(import (scheme show))            ; show
(import (scheme process-context)) ; command-line
(import (file util))              ; file-is-readable?
;; (import (srfi 27))          ; rondom-integer random-real
;; (import (srfi 28))          ; format
;; (import (portable x->string))          ; x->string
;; (import (portable mine hankaku-width)) ; hankaku-width
;; (import (portable mine repeat))        ; repeat
;; (import (portable mine repeats))       ; repeats
;; (import (portable mine random-string)) ; random-string

(define today (current-date))

(define (png->num file)
  (string->number (substring file 9 14)))

(define (png->txt file)
  (string-append (substring file 0 19) "txt"))

(define (name? file)
  (and (file-is-readable? file)
       (with-input-from-file file read-line)))

(define (no-name files)
  (- (length files) (count name? (map png->txt files))))

(define (show-head files desc)
  (show #t
        "## ColorSing ギフト一覧 "
        (date-year today) "年" (padded 2 (date-month today)) "月 "
        (length files) "種類\n"
        desc nl
        "| 画像 | コイン | 名称 |\n"
        "|:----:|-------:|:-----|\n"))

(define (show-line file)
  (show #t
        "| <img height=\"30px\" src=\""
        file
        "\"> | "
        (padded 6 (numeric/comma (png->num file)))
        " | "
        (or (name? (png->txt file)) "")
        " |\n"))

(define (show-foot files)
  (show #t
        ;; "\n---\n"
        nl
        "生成: "
        (date-year today) "年"
        (padded 2 (date-month today)) "月"
        (padded 2 (date-day today)) "日\n"
        "名称未設定: " (no-name files) "件\n"))

(define (show-markdown files desc)
  (show-head files desc)
  (for-each show-line files)
  (show-foot files)
  (values))

(let ((cmd (command-line)))
  (show-markdown (cddr cmd) (cadr cmd)))
