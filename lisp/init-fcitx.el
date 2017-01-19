;; Make sure the following comes before `(fcitx-aggressive-setup)'
(setq fcitx-active-evil-states '(insert emacs hybrid)) ; if you use hybrid mode
(fcitx-aggressive-setup)
(fcitx-prefix-keys-add "M-m") ; M-m is common in Spacemacs
;; (setq fcitx-use-dbus t) ; uncomment if you're using Linux


(provide 'init-fcitx)
