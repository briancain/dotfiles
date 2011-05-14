  ;; Interface stuff {{{
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 240 :width normal :foundry "apple" :family "Menlo")))))
  ;; Interface stuff }}}

(defconst emacs-lisp-root "~/Library/Emacs")
(setq load-path (cons emacs-lisp-root load-path))

  ;; Disabling backup
(setq make-backup-files nil) ;; do not make backup files 

  ;; Fixing "cannot open load file" errors {{{
  ;; I got this 'fix' from:
  ;; http://desk.stinkpot.org:8080
;;(add-to-list ‘load-path “/Applications/Emacs.app/Contents/Resources/lisp”)
  ;; }}}

  ;; org-mode {{{
  ;; Most of the following is from:
  ;; http://newartisans.com/2007/08/using-org-mode-as-a-day-planner

  ;; This line should not be necessary since org-mode is preinstalled
(require 'org-install)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(define-key mode-specific-map [?a] 'org-agenda)

(eval-after-load "org"
  '(progn
     (define-prefix-command 'org-todo-state-map)

     (define-key org-mode-map "\C-cx" 'org-todo-state-map)

     (define-key org-todo-state-map "x"
       #'(lambda nil (interactive) (org-todo "CANCELLED")))
     (define-key org-todo-state-map "d"
       #'(lambda nil (interactive) (org-todo "DONE")))
     (define-key org-todo-state-map "f"
       #'(lambda nil (interactive) (org-todo "DEFERRED")))
     (define-key org-todo-state-map "l"
       #'(lambda nil (interactive) (org-todo "DELEGATED")))
     (define-key org-todo-state-map "s"
       #'(lambda nil (interactive) (org-todo "STARTED")))
     (define-key org-todo-state-map "w"
       #'(lambda nil (interactive) (org-todo "WAITING")))

;;     (define-key org-agenda-mode-map "\C-n" 'next-line)
;;     (define-key org-agenda-keymap "\C-n" 'next-line)
;;     (define-key org-agenda-mode-map "\C-p" 'previous-line)
;;     (define-key org-agenda-keymap "\C-p" 'previous-line)
  ))


(eval-after-load "org-agenda"
  '(progn
     (define-key org-agenda-mode-map "\C-n" 'next-line)
     (define-key org-agenda-keymap "\C-n" 'next-line)
     (define-key org-agenda-mode-map "\C-p" 'previous-line)
     (define-key org-agenda-keymap "\C-p" 'previous-line)
     ;; Use C-c C-w to refile
     (setq org-refile-targets '((org-agenda-files . (:maxlevel . 5))))
  ))

(require 'remember)

(add-hook 'remember-mode-hook 'org-remember-apply-template)

(define-key global-map [(control meta ?r)] 'remember)

(custom-set-variables
 '(org-agenda-files (quote ("~/Dropbox/todo.org")))
 '(org-default-notes-file "~/Dropbox/todo.org")
 '(org-agenda-ndays 7)
 '(org-deadline-warning-days 14)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-reverse-note-order t)
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-agenda-custom-commands
   (quote (("d" todo "DELEGATED" nil)
       ("c" todo "DONE|DEFERRED|CANCELLED" nil)
       ("w" todo "WAITING" nil)
       ("W" agenda "" ((org-agenda-ndays 21)))
       ("A" agenda ""
        ((org-agenda-skip-function
          (lambda nil
        (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
         (org-agenda-ndays 1)
         (org-agenda-overriding-header "Today's Priority #A tasks: ")))
       ("u" alltodo ""
        ((org-agenda-skip-function
          (lambda nil
        (org-agenda-skip-entry-if (quote scheduled) (quote deadline)
                      (quote regexp) "\n]+>")))
         (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
 '(org-remember-store-without-prompt t)
 '(org-remember-templates
   (quote ((116 "* TODO %?\n  %u" "~/Dropbox/todo.org" "Tasks"))))
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler))))

  ;; Org-mode latex support
(require 'org-latex)
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")))  
(setq org-latex-to-pdf-process '("texi2dvi --pdf --clean --verbose --batch %f"))
  ;; org-mode }}}

  ;; Start with agenda list right away
"(add-hook 'after-init-hook '(lambda () (org-agenda-list 1)))
"(setq initial-buffer-choice 'org-agenda-list)

