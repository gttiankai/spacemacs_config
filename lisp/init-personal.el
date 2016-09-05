;; ========================================================================
;;                    config shortkey and add short key(key binding)
;; ========================================================================
;; fullscreen
(global-set-key [f4] 'toggle-frame-fullscreen)

;; refresh the file
(defun refresh-file ()
  (interactive)
  (revert-buffer t (not (buffer-modified-p)) t))
(global-set-key [f5] 'refresh-file)

;;格式化整个文件函数
(defun indent-whole ()
  (interactive)
  (indent-region (point-min) (point-max))
  (message "format successfully"))
;;绑定到F7键
(global-set-key [f7] 'indent-whole)

;; 使用f8快捷键删除行末多余的空格
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-set-key [f8] 'delete-trailing-whitespace)

;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  ;;(setq mac-option-modifier 'nil)
  ;;(setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

;; set key map helm-buffers-list to C-x C-b
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
;; set key map helm-find-files to C-c f
(global-set-key (kbd "C-c f") 'helm-for-files)

(global-set-key (kbd "C-c i") 'helm-imenu)


;; 向上翻页
(defun window-move-up (&optional arg)
  "Current window move-up 2 lines."
  (interactive "P")
  (if arg
      (scroll-up arg)
    (scroll-up 2)))

(defun window-move-down (&optional arg)
  "Current window move-down 3 lines."
  (interactive "P")
  (if arg
      (scroll-down arg)
    (scroll-down 3)))

(defun other-window-move-up (&optional arg)
  "Other window move-up 1 lines."
  (interactive "p")
  (scroll-other-window arg))

(defun other-window-move-down (&optional arg)
  "Other window move-down 2 lines."
  (interactive "P")
  (if arg
      (scroll-other-window-down arg)
    (scroll-other-window-down 2)))

(global-set-key [(meta v)] 'scroll-down)
;; 下面这两个键模拟Vi的光标不动屏幕动效果, 我很喜欢, 几乎总在使用.
;; (global-set-key [(meta n)] 'window-move-up)
;; (global-set-key [(meta p)] 'window-move-down)

(global-set-key [(meta n)] 'next-line)
(global-set-key [(meta p)] 'previous-line)
;; 同上, 但是是另一个buffer窗口上下移动. 常常查看帮助用这个.
(global-set-key [(meta N)] 'other-window-move-down)
(global-set-key [(meta P)] 'other-window-move-up)

;; config the delete-backward-char
;;(global-set-key (kbd "C-h") 'delete-backward-char)

;;代码折叠功能:系统自带功能
(load-library "hideshow")    ;;开启代码折叠功能
(add-hook 'c-mode-hook 'hs-minor-mode)    ;;C文件折叠功能
(add-hook 'c++-mode-hook 'hs-minor-mode)    ;;C++文件折叠功能
(add-hook 'go-mode-hook 'hs-minor-mode)    ;;GO文件折叠功能
(add-hook 'python-mode-hook 'hs-minor-mode)    ;;Python文件折叠功能
(add-hook 'javascript-mode-hook 'hs-minor-mode) ;;Javascript文件折叠功能
(global-set-key (kbd "C--") 'hs-hide-block)    ;;折叠代码 (键绑定)
(global-set-key (kbd "C-=") 'hs-show-block)    ;;打开折叠 (键绑定)
(global-set-key (kbd "C-<") 'hs-hide-all)    ;;折叠全部代码 (键绑定)
(global-set-key (kbd "C->") 'hs-show-all)    ;;展开全部折叠 (键绑定)



;; ========================================================================
;;                            config org
;; ========================================================================
;; config the org indent
(setq org-startup-indented t)
;;change the key alt to command in mac os
(setq org-display-inline-images nil)

(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
;; blow config  does not work!
;; make the copy and past work like they should
;; (setq interprogram-cut-function 'paste-to-osx)
;; (setq interprogram-paste-function 'copy-from-osx)
;; config for wakatime
;;(setq wakatime-python-bin "/usr/local/bin/python")





;; ========================================================================
;;                      config fonts and theme
;; ========================================================================
;;config chinese font
;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;   (set-fontset-font (frame-parameter nil 'font)
;;                     charset (font-spec :family "Kaiti SC"
;;                                        :size 18
;;                                        )))



;; ========================================================================
;;                      add funciton
;; ========================================================================
;; 统计org-mode中的字数
(defun zjs-count-word ()
  (interactive)
  (let ((beg (point-min)) (end (point-max))
        (eng 0) (non-eng 0))
    (if mark-active
        (setq beg (region-beginning)
              end (region-end)))
    (save-excursion
      (goto-char beg)
      (while (< (point) end)
        (cond ((not (equal (car (syntax-after (point))) 2))
               (forward-char))
              ((< (char-after) 128)
               (progn
                 (setq eng (1+ eng))
                 (forward-word)))
              (t
               (setq non-eng (1+ non-eng))
               (forward-char)))))
    (message "English words: %d\nNon-English characters: %d"
             eng non-eng)))
;; TODO close the org-mode auto display the image





;; ========================================================================
;;                     enhance the older function
;; ========================================================================
;; Smart copy, if no region active, it simply copy the current whole line
;; (defadvice kill-line (before check-position activate)
;;   (if (member major-mode
;;               '(emacs-lisp-mode scheme-mode lisp-mode
;;                                 c-mode c++-mode objc-mode js-mode
;;                                 latex-mode plain-tex-mode))
;;       (if (and (eolp) (not (bolp)))
;;           (progn (forward-char 1)
;;                  (just-one-space 0)
;;                  (backward-char 1)))))

;; (defadvice kill-ring-save (before slick-copy activate compile)
;;   "When called interactively with no active region, copy a single line instead."
;;   (interactive (if mark-active (list (region-beginning) (region-end))
;;                  (message "Copied line")
;;                  (list (line-beginning-position)
;;                        (line-beginning-position 2)))))

;; (defadvice kill-region (before slick-cut activate compile)
;;   "When called interactively with no active region, kill a single line instead."
;;   (interactive
;;    (if mark-active (list (region-beginning) (region-end))
;;      (list (line-beginning-position)
;;            (line-beginning-position 2)))))

;; ;; Copy line from point to the end, exclude the line break
;; (defun qiang-copy-line (arg)
;;   "Copy lines (as many as prefix argument) in the kill ring"
;;   (interactive "p")
;;   (kill-ring-save (point)
;;                   (line-end-position))
;;   ;; (line-beginning-position (+ 1 arg)))
;;   (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
;; (global-set-key (kbd "M-k") 'qiang-copy-line)

;; config the
(setq c-default-style "linux"
      c-basic-offset 4)

(if (eq system-type 'darwin)
    ;; http://stackoverflow.com/questions/13517910/yank-does-not-paste-text-when-using-emacs-over-ssh
    (defun copy-from-osx ()
      "Handle copy/paste intelligently on osx."
      (let ((pbpaste (purecopy "/usr/bin/pbpaste")))
        (if (and (eq system-type 'darwin)
                 (file-exists-p pbpaste))
            (let ((tramp-mode nil)
                  (default-directory "~"))
              (shell-command-to-string pbpaste)))))
  (defun paste-to-osx (text &optional push)
    "paste to osx"
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))
  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx)
  )

;; ========================================================================
;;                     enhance the older function
;; ========================================================================

(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
(add-hook 'c-mode-hook 'ggtags-mode)
(add-hook 'c++-mode-hook 'ggtags-mode)
(add-hook 'java-mode-hook 'ggtags-mode)
(add-hook 'python-mode-hook 'ggtags-mode)

(add-hook 'c-mode-hook 'linum-mode)
(add-hook 'c++-mode-hook 'linum-mode)
(add-hook 'java-mode-hook 'linum-mode)
(add-hook 'python-mode-hook 'linum-mode)

(provide 'init-personal)
