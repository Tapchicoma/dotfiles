;; #### INIT VARIABLES ###

;; Show debug info
;; (setq debug-on-error t)

;; Set config dir
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; Font init
(set-face-font 'default "-unknown-Droid sans mono-medium-r-normal--17-120-100-100-m-0-iso10646-1")
(set-face-attribute 'default nil :font "droid sans mono-18")

;; stop creating backup~ and #auto-save# files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; default input method
(setq default-input-method 'russian-computer)

;; save history
(savehist-mode t)

;; smooth scrolling
(setq redisplay-dont-pause t
      scroll-margin 2
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; whitespace mode settings
(setq whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab
                                  face)
      whitespace-line-column 120)

;; Delete selection when typing
(delete-selection-mode t)

;; set monday the first day of the week in calendar
(setq calendar-week-start-day 1)

;; set nxml mode indentation to 4 spaces
(setq nxml-child-indent 4)

;; spell check settings
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=fast"))
(setq ispell-dictionary "en")

;; yasnippet snippets directory
(setq yas-snippet-dirs `(,(concat dotfiles-dir "snippets")
                         ,(concat dotfiles-dir "vendor/yasnippet/snippets")))

;; autocomplete settings
(setq ac-comphist-file (concat dotfiles-dir "ac/ac-comphist.dat"))

;; android mode
(setq android-mode-sdk-dir "/opt/android-sdk-update-manager")

;; semantic vars
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                  global-semantic-idle-summary-mode
                                  global-semanticdb-minor-mode
                                  global-semantic-idle-completions-mode
                                  global-semantic-stickyfunc-mode
                                  global-semantic-mru-bookmark-mode))

;; gtags vars
(setq gtags-suggested-key-mapping t)
(setq gtags-auto-update t)

;; add loading all from vendor dir
(add-to-list 'load-path (concat dotfiles-dir "vendor"))
(add-to-list 'load-path (concat dotfiles-dir "vendor/cedet-1.1/cogre"))
(add-to-list 'load-path (concat dotfiles-dir "vendor/cedet-1.1/common"))
(add-to-list 'load-path (concat dotfiles-dir "vendor/cedet-1.1/contrib"))
(add-to-list 'load-path (concat dotfiles-dir "vendor/cedet-1.1/ede"))
(add-to-list 'load-path (concat dotfiles-dir "vendor/cedet-1.1/eieio"))
(add-to-list 'load-path (concat dotfiles-dir "vendor/cedet-1.1/semantic"))
(add-to-list 'load-path (concat dotfiles-dir "vendor/cedet-1.1/speedbar"))
(add-to-list 'load-path (concat dotfiles-dir "vendor/cedet-1.1/srecode"))
(add-to-list 'load-path (concat dotfiles-dir "vendor/cedet-1.1/tests"))
(add-to-list 'load-path (concat dotfiles-dir "vendor/auto-complete"))
(add-to-list 'load-path (concat dotfiles-dir "vendor/yasnippet"))

;;; ------------------------------------------------------------------------------------------

;; #### FUNCTIONS ####

;; Toggles emacs go fullscreen mode
(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))

;; android clean project and start debug compilation
(defun android-start-clean-debug ()
  (interactive)
  (android-ant "clean debug"))

;; android install debug apk to device
(defun android-install-debugapp ()
  (interactive)
  (android-ant "installd"))

;; android start debug compilation
(defun android-start-debug ()
  (interactive)
  (android-ant "debug"))

;; android start lint checks
(defun android-start-lint-check ()
  (interactive)
  (android-ant "lint"))

;; load custom theme
(defun load-my-theme ()
  (load-theme 'solarized-dark t))

;; always linum-mode
(defun linum-mode-find-file-hook ()
 (linum-mode t))
(add-hook 'find-file-hook 'linum-mode-find-file-hook)

;; add winner mode (manage emacs windows)
(defun setup-winner ()
  (require 'winner)
  (setq winner-dont-bind-my-keys t)
  (winner-mode t))

;; load yasnippet
(defun setup-yasnippet ()
  (require 'yasnippet)
  (yas-global-mode 1))

;; load autocomplete
(defun setup-jde-acsources ()
  (require 'semantic-ia nil t)
  (push 'ac-source-semantic ac-sources))
(defun setup-autocomplete ()
  (require 'auto-complete-config)
  (add-to-list 'ac-dictionary-directories (concat dotfiles-dir "ac/ac-dict"))
  (ac-config-default)
  (ac-set-trigger-key "TAB")
  (add-to-list 'ac-modes 'nxml-mode))

;; load android-mode
(defun setup-android-mode ()
  (require 'android-mode)
  (require 'android))

;; setup cedet
(defun setup-cedet ()
  (require 'cedet)
  (require 'cedet-android)
  (require 'cedet-java)
  (require 'semantic)
  )

;; setup flymake
(defun setup-flymake ()
  (require 'flymake)
  (require 'flymake-cursor)
  (add-to-list 'flymake-allowed-file-name-masks '("\\.java\\'" jde-ecj-server-flymake-init jde-ecj-flymake-cleanup))
  (add-hook 'find-file-hook 'flymake-find-file-hook))

;; nxml mode hook
(defun nxml-mode-prehooks ()
  (hl-line-mode t))
(add-hook 'nxml-mode-hook 'nxml-mode-prehooks)

;; setup gtags
(defun setup-gtags ()
  (autoload 'gtags-mode "gtags" "" t))

;;; -------------------------------------------------------------------------------------------

;; #### KEY BINDINGS ####

(global-set-key (kbd "<f2>") 'android-start-debug)
(global-set-key (kbd "<f3>") 'android-start-clean-debug)
(global-set-key (kbd "<f4>") 'android-install-debugapp)
(global-set-key (kbd "<f5>") 'android-start-lint-check)
(global-set-key (kbd "<f11>") 'toggle-fullscreen)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "<C-x left>") 'winner-undo)
(global-set-key (kbd "<C-x right>") 'winner-redo)

;;; -------------------------------------------------------------------------------------------

;; #### MY CONFIG INIT ####

(defun init-my-config ()
  (print "load my config")
  (load-my-theme)
  (setup-winner)
  (setup-yasnippet)
  (setup-autocomplete)
  (setup-android-mode)
  (setup-cedet)
  (setup-flymake)
  (setup-gtags)
  (print "end loading my config")
  )

(add-hook 'egorr-hook (lambda () (init-my-config)))

;;; -------------------------------------------------------------------------------------------
