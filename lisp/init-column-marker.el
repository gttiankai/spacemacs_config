(require 'column-marker)
(add-hook 'foo-mode-hook (lambda () (interactive) (column-marker-1 80)))

(provide 'init-column-marker)
