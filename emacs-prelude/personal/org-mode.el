;; Some customization for org-mode

;;; Enabling opening links by RET enter
(setq org-return-follows-link 'true)

;;; Setting additional TODO states
(setq org-todo-keywords
      '((sequence "TODO" "IN PROGRESS" "VERIFY" "|" "DONE" "DELEGATED" "CANCELED")))

;;; Setting custom faces for TODO items
(setq org-todo-keyword-faces
      '(("TODO" . org-warning)
        ("IN PROGRESS" . "yellow")
        ("VERIFY" . "orange")
        ("DONE" . (:foreground "green" :weight bold))
        ("DELEGATED" . (:foreground "green" :weight bold))
        ("CANCELED" . (:foreground: "white" weight: bold)))
     )
