;; Visual customizations

(add-to-list 'default-frame-alist '(font . "Hack-8"))
(set-face-attribute 'default t :font "Hack-8")

(set-face-attribute 'default nil :font "Hack-8")
(set-frame-font "Hack-8" nil t)

;; Setting theme
(load-theme 'misterioso t)
