;;; -*- coding: utf-8-unix; mode: scheme -*-
(import (scheme base))
(import (scheme list))            ; count
(import (scheme write))           ; display
(import (scheme file))            ; with-input-from-file
(import (scheme show))            ; show
(import (scheme process-context)) ; command-line
(import (srfi 19))                ; current-date, date-year, date-month
;; (import (srfi 27))               ; rondom-integer random-real
;; (import (srfi 28))               ; format
(import (only (gauche base) slices))
(import (file util))              ; file-is-readable?
;; (import (portable x->string))          ; x->string
;; (import (portable mine hankaku-width)) ; hankaku-width
;; (import (portable mine repeat))        ; repeat
;; (import (portable mine repeats))       ; repeats
;; (import (portable mine random-string)) ; random-string

;;;
;;; 概要
;;;
;;; 引数で指定されたギフトを表にする（5段組）
;;;
;;; 使用法
;;;
;;; gosh [-r7] colorsing/gift-list5 タイトル [ギフトtxt ...]
;;;
;;; 注意
;;;
;;; gosh に -l オプションを付けると、(command-line) が返すリストに
;;; スクリプト名が入らないのでエラーになる
;;;

(define today (current-date))

(define (png->num file)
  (string->number (substring file 9 14)))

(define (png->txt file)
  (string-append (substring file 0 19) "txt"))

(define (txt->png file)
  (string-append (substring file 0 19) "png"))

(define (name? file)
  (and (file-is-readable? file)
       (with-input-from-file file read-line)))

(define (no-name files)
  (- (length files) (count name? (map png->txt files))))

(define-syntax SHOW
  (syntax-rules ()
    ((_ x ...) (show #t x ...))))

(define (show-head files desc)
  (SHOW
   "<!DOCTYPE html>" nl
   "<html lang=\"ja\">" nl
   "  <head>" nl
   "    <meta charset=\"UTF-8\">" nl
   "    <title>" desc "（段組）</title>" nl
   "    <base target=\"_blank\">" nl
   "    <link rel=\"stylesheet\" href=\"../css/base.css\" />" nl
   "  </head>" nl
   "  <body>" nl
   "    <h1>ColorSing ギフト一覧 </h1>" nl
   (date-year today) "年"
   (padded 2 (date-month today)) "月"
   (padded 2 (date-day today)) "日 生成<br/>" nl
   desc " " (length files) "種類 "
   "名称未設定: " (no-name files) "件<br/>" nl nl
   "    <table>" nl
   "      <tbody>" nl)
  (values))

(define (show-line files)  ; 5つずつに分割されたリスト
  (SHOW "<tr>" nl)
  (for-each
   (lambda (file)
     (SHOW "<td style=\"padding: 10px; text-align: center;\">" nl)
     (when file
       (SHOW
        "  <img width=\"180px\" src=\"" (txt->png file) "\"><br/>" nl
        "  <span style=\"font-size: small;\">"
        "  " (or (name? file) "") "<br/>" (numeric/comma (png->num file))
        "</span>" nl))
     (SHOW "</td>" nl))
   files)
  (SHOW "</tr>" nl)
  (values))

(define (show-foot files)
  (SHOW
   "      </tbody>" nl
   "    </table>" nl
   "  </body>" nl
   "</html>" nl)
  (values))

(define (show-markdown files desc)
  (show-head files desc)
  (for-each show-line (slices files 5 #t #f))
  (show-foot files)
  (values))

(let ((cmd (command-line)))
  ;; (show #t "DEBUG: 0: " cmd nl)
  ;; (show #t "DEBUG: 1: " (cadr cmd) nl)
  ;; (show #t "DEBUG: 2: " (cddr cmd) nl)
  (show-markdown (cddr cmd) (cadr cmd)))
