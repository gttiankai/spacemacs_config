(if (eq system-type 'darwin)
    (setq window-system-default-frame-alist
          '((x (font . "Inconsolata 20")) ;; 若frame在X下创建
            (nil))) ;; 若frame在terminal中创建
  )
;; (if (or (eq system-type 'gnu/linux) (eq system-type 'linux) )

;;     )
;;Source Code Pro
;; (if (eq system-type 'darwin)
;;     (setq window-system-default-frame-alist
;;           '((x (font . "Menlo 18")) ;; 若frame在X下创建
;;             (nil))) ;; 若frame在terminal中创建
;;   )


(provide 'init-font)
