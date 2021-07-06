; Foolish Attempt At An Emacs Configuration File
; ye have been warned


;; Time Startup Performance AndImprove By Disabling Garage Collectio
;; The default is 800 kilobytes.  Measured in bytes. Reset to default
;; At The End
(setq gc-cons-threshold (* 50 1000 1000))

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))




;; Fulscreen & Transparency
(set-frame-parameter (selected-frame) 'alpha '(92 . 92))
(add-to-list 'default-frame-alist '(alpha . (92 . 92)))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))




;; Bacic Commands Clearing UI elements
(setq inhibit-startup-message t)	; no startup message
(scroll-bar-mode -1)			; no scrollbar
(tool-bar-mode -1)			; no toolbar
(tooltip-mode -1)			; no tooltips
(menu-bar-mode -1)			; no menubar
					;
;(set-fringe-mode 15)			; horizontal padding on buffer
(setq visible-bell 1)                   ; replace beep with screen notification
(set-face-attribute 'default nil :font "Fira Code Retina" :height 130) ; font+size
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 130)
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 130 :weight 'regular)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)                ; escape now quits
(column-number-mode)                    ; index horizontal position on modeline
(global-display-line-numbers-mode t)    ; diplay linenumbers



;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))



;; Set Up Packages and Plugins
(require `package)                      ; load package mngmnt
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
      			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents        ; refresh arcive if not present
  (package-refresh-contents))           ; e.g. on first load

(unless (package-installed-p 'use-package) ; install and enable use-package
  (package-install `use-package))
(require 'use-package)
(setq use-package-always-ensure t)


(use-package org
  :config
  (setq org-hide-emphasis-markers t
        org-src-fontify-natively t
        org-fontify-quote-and-verse-blocks t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 2
        org-hide-block-startup nil
        org-src-preserve-indentation nil
        org-startup-folded 'content
        org-cycle-separator-lines 2))

  

;; Set Up IVY Completion Framework
;; with basic vim-like keybindings (TODO swap ctrl and capsck on my laptop) 
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-f" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :init
  (ivy-mode 1))
; and make it more descriptive
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))




;; Colour-Pair Delimiters In Programming Buffers
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))




;; Give List Of Possible Actions While Entering Commands
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0))



;; Counsel alternatives To Common EMACS Commands
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file))
  :config
  (setq ivy-initial-inputs-alist nil))





;; Replace The Help Help Functions With Better Ones
(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))



;; Use DOOM's modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)) 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-safe-themes
   '("ea5822c1b2fb8bb6194a7ee61af3fe2cc7e2c7bab272cbb498a0234984e1b2d9" default))
 '(fci-rule-color "#383838")
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(leuven-theme org-pomodoro quelpa powerthesaurus helm-flyspell slime flyspell-correct-helm flyspell-correct org-roam-bibtex helm-bibtex buffer-flip company-org-block ac-slime slime-company company-quickhelp company-jedi jedi flycheck-haskell flycheck company-auctex evil org-roam lsp-ui company company-capf ebuku lsp-mode org-journal visual-fill-column org-bullets counsel ivy-rich which-key rainbow-delimiters use-package ivy doom-modeline))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(warning-suppress-types '((org))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-ellipsis ((t (:foreground "gainsboro" :underline nil)))))





;; Set Up DOOM-vibrant Theme
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-vibrant t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))



;; Org Mode Configuration ------------------------------------------------------
(defun efs/org-font-setup ()
  
(set-face-attribute 'org-document-title nil :font "Cantarell" :weight 'bold :height 1.3)
  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.4)
                  (org-level-2 . 1.2)
                  (org-level-3 . 1.1)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'medium :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ")
  (efs/org-font-setup))



;(setq org-format-latex-options  '(:scale 1.5))

(setq org-format-latex-options '(plist-put org-format-latex-options '(:scale 2.0)))
  

 

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(defcustom org-format-latex-header "\\documentclass[leqno,14pt]{article}
\\usepackage[usenames]{color}
\[PACKAGES]
\[DEFAULT-PACKAGES]
\\pagestyle{empty}             % do not remove
% The settings below are copied from fullpage.sty
\\setlength{\\textwidth}{\\paperwidth}
\\addtolength{\\textwidth}{-3cm}
\\setlength{\\oddsidemargin}{1.5cm}
\\addtolength{\\oddsidemargin}{-2.54cm}
\\setlength{\\evensidemargin}{\\oddsidemargin}
\\setlength{\\textheight}{\\paperheight}
\\addtolength{\\textheight}{-\\headheight}
\\addtolength{\\textheight}{-\\headsep}
\\addtolength{\\textheight}{-\\footskip}
\\addtolength{\\textheight}{-3cm}
\\setlength{\\topmargin}{1.5cm}
\\addtolength{\\topmargin}{-2.54cm}"
  "The document header used for processing LaTeX fragments.
It is imperative that this header make sure that no page number
appears on the page.  The package defined in the variables
`org-latex-default-packages-alist' and `org-latex-packages-alist'
will either replace the placeholder \"[PACKAGES]\" in this
header, or they will be appended."
  :group 'org-latex
  :type 'string)


; Org remembers the time you finished a todo
(setq org-log-done 'time)



; Set up org-journal
(use-package org-journal
  :ensure t
  :defer t
  :init
  (setq org-journal-prefix-key "C-c j ")
  :config
  (setq org-journal-dir "~/journal/")
  (setq org-journal-date-format "%A, %d %B %Y"))


(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (latex-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package ebuku)

(use-package company)
(use-package lsp-ui)

(use-package company-auctex
  :init)
(require 'company-auctex)
(company-auctex-init)

(setq company-minimum-prefix-length 1
      company-idle-delay 0.0)

;; Add hook for latexmk on saving

(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory (file-truename "~/notebook/"))
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))




(with-eval-after-load 'org
  (org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . t)
	(python . t)
	(shell . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))



(use-package slime)
(setq inferior-lisp-program "sbcl")

(use-package ac-slime)
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))


(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package flycheck-haskell)
(use-package haskell-mode)
(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)

(use-package company-jedi)
(use-package slime-company
  :after (slime company)
  :config (setq slime-company-completion 'fuzzy
                slime-company-after-completion 'slime-company-just-one-space))
;(slime-setup '(slime-fancy slime-company))

(use-package company-org-block
  :ensure t
  :custom
  (company-org-block-edit-style 'auto) ;; 'auto, 'prompt, or 'inline
  :hook ((org-mode . (lambda ()
                       (setq-local company-backends '(company-org-block))
                       (company-mode +1)))))

(setq company-org-block-edit-style 'inline)


(add-to-list 'company-backends 'company-jedi)
(use-package company-quickhelp)
(company-quickhelp-mode)
(add-hook 'after-init-hook 'global-company-mode)

;;(use-package org-pomodoro)


;; Alt-tab functionality
(use-package buffer-flip
  :ensure t
  :bind  (("M-<tab>" . buffer-flip)
          :map buffer-flip-map
          ( "M-<tab>" .   buffer-flip-forward) 
          ( "M-S-<tab>" . buffer-flip-backward) 
          ( "M-ESC" .     buffer-flip-abort))
  :config
  (setq buffer-flip-skip-patterns
        '("^\\*helm\\b"
          "^\\*swiper\\*$")))


(use-package helm-bibtex)

(use-package org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (require 'org-ref)) ; optional: if Org Ref is not loaded anywhere else, load it here

;; Org-ref
;; Set up bibliography
(setq reftex-default-bibliography '("~/library/bibleography.bib"))
;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/library/bib-notes.org"
      org-ref-default-bibliography '("~/library/bibleography.bib")
      org-ref-pdf-directory "~/library/documents/")

(setq bibtex-completion-bibliography "~/library/bibleography.bib"
      bibtex-completion-library-path "~/library/documents"
      bibtex-completion-notes-path "~/library/bib-notes.org")

(setq org-ref-notes-directory "~/notebook/")
(setq org-ref-notes-function 'orb-edit-notes)

(use-package flyspell-correct
  :bind (:map flyspell-mode-map ("C-;" . flyspell-correct-wrapper)))

(use-package flyspell-correct-helm)

(use-package powerthesaurus
  :bind (:map org-mode-map ("C-t" . powerthesaurus-lookup-word-dwim)))

(setq org-todo-keywords
      '((sequence "TODO" "TOREAD" "READING" "|" "DONE" "READ")))

;; Build my package mods from my github
(use-package quelpa)
(quelpa '(org-pomodoro :fetcher github :repo "palkiakerr/org-pomodoro" :files (:defaults "resources")))
