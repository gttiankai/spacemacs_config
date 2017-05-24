(setq-default dotspacemacs-configuration-layers
              '((auto-completion :variables
                                 auto-completion-return-key-behavior 'complete
                                 auto-completion-tab-key-behavior 'cycle
                                 auto-completion-complete-with-key-sequence nil
                                 auto-completion-complete-with-key-sequence-delay 0.01
                                 auto-completion-private-snippets-direcotry t
                                 auto-completion-enable-sort-by-usage t
                                 auto-completion-enable-snippets-in-popup t
                                 auto-completion-private-snippets-directory "~/git-hub/spacemacs_config/snippets/"
                                 )))

;; disable company for org-mode
;; (spacemacs|disable-company org-mode)

(provide 'init-company)
