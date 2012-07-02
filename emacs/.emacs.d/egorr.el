;; Font init
(set-face-font 'default "-unknown-Droid Sans Mono-medium-r-normal--20-0-72-72-m-0-iso10646-1")
(set-face-attribute 'default nil :font "Droid Sans Mono-10")

;; Theme init
(color-theme-solarized-dark)

;; stop creating backup~ and #auto-save# files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; default input method
(setq default-input-method 'russian-computer)

;; whitespace mode settings
;; (setq whitespace-style '(trailing lines space-before-tab
;;                                  indentation space-after-tab)
;;      whitespace-line-column 80)

;; save history
(savehist-mode t)

;; Delete selection when typing
(delete-selection-mode t)

;; always linum-mode
(defun linum-mode-find-file-hook ()
 (linum-mode t))
(add-hook 'find-file-hook 'linum-mode-find-file-hook)

;; smooth scrolling
(setq redisplay-dont-pause t
      scroll-margin 2
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; add winner mode (manage emacs windows)
(require 'winner)
(setq winner-dont-bind-my-keys t)
(global-set-key (kbd "<C-s-left>") 'winner-undo)
(global-set-key (kbd "<C-s right>") 'winner-redo)
(winner-mode t)

;; android start debug compilation
(defun android-start-debug ()
  (interactive)
  (android-ant "clean debug"))

(defun android-install-debugapp ()
  (interactive)
  (android-ant "installd"))

;; key configuration
(global-set-key (kbd "<f11>") 'toggle-fullscreen)
(global-set-key (kbd "<f3>") 'android-start-debug)
(global-set-key (kbd "<f4>") 'android-install-debugapp)

;; spell check settings
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=fast"))
(setq ispell-dictionary "en")

;; yasnippet settings
(require 'yasnippet)
(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)

;; autocomplete settings
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(setq ac-comphist-file "~/.emacs.d/ac-comphist.dat")
(ac-config-default)

;; set monday the first day of the week in calendar
(setq calendar-week-start-day 1)

;; add android mode
(require 'android-mode)

;; load android sdk tool for emacs
(add-to-list 'load-path (concat dotfiles-dir "/vendor"))
(require 'android)

;; add auto enable java-mode for java files
(add-to-list 'auto-mode-alist '("\\.java$" . java-mode))
