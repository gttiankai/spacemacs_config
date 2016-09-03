;; Use the system clipboard
(setq x-select-enable-clipboard t
      x-select-enable-primary t)

;; kill-ring and clipboard are same? No, it's annoying!
;; (setq save-interprogram-paste-before-kill t)

(autoload 'simpleclip-get-contents "simpleclip" "" t)
(autoload 'simpleclip-set-contents "simpleclip" "" t)

;; you need install xsel under Linux
;; xclip has some problem when copying under Linux
(defun copy-yank-str (msg &optional clipboard-only)
  (unless clipboard-only (kill-new msg))
  (simpleclip-set-contents msg))

(defun cp-filename-of-current-buffer ()
  "Copy file name (NOT full path) into the yank ring and OS clipboard"
  (interactive)
  (let (filename)
    (when buffer-file-name
      (setq filename (file-name-nondirectory buffer-file-name))
      (copy-yank-str filename)
      (message "filename %s => clipboard & yank ring" filename))))

(defun cp-filename-line-number-of-current-buffer ()
  "Copy file:line into the yank ring and clipboard"
  (interactive)
  (let (filename linenum rlt)
    (when buffer-file-name
      (setq filename (file-name-nondirectory buffer-file-name))
      (setq linenum (save-restriction
                      (widen)
                      (save-excursion
                        (beginning-of-line)
                        (1+ (count-lines 1 (point))))))
      (setq rlt (format "%s:%d" filename linenum))
      (copy-yank-str rlt)
      (message "%s => clipboard & yank ring" rlt))))

(defun cp-fullpath-of-current-buffer ()
  "Copy full path into the yank ring and OS clipboard"
  (interactive)
  (when buffer-file-name
    (copy-yank-str (file-truename buffer-file-name))
    (message "file full path => clipboard & yank ring")))

(defun copy-to-x-clipboard (&optional num)
  "If NUM equals 1, copy the downcased string.
If NUM equals 2, copy the captalized string.
If NUM equals 3, copy the upcased string.
If NUM equals 4, kill-ring => clipboard."
  (interactive "P")
  (let ((thing (if (region-active-p)
                   (buffer-substring-no-properties (region-beginning) (region-end))
                 (thing-at-point 'symbol))))
    (cond
     ((not num))
     ((= num 1)
      (setq thing (downcase thing)))
     ((= num 2)
      (setq thing (capitalize thing)))
     ((= num 3)
      (setq thing (upcase thing)))
     ((= num 4)
      (simpleclip-set-contents (car kill-ring)))
     (t
      (message "C-h f copy-to-x-clipboard to find right usage")))

    (simpleclip-set-contents thing)
    (if (not (and num (= 4 num))) (message "kill-ring => clipboard")
      (message "thing => clipboard!"))))

(defun paste-from-x-clipboard(&optional n)
  "Paste string clipboard.
If N is 1, we paste diff hunk whose leading char should be removed.
If N is 2, paste into kill-ring too"
  (interactive "P")
  ;; paste after the cursor in evil normal state
  (when (and (functionp 'evil-normal-state-p)
             (functionp 'evil-move-cursor-back)
             (evil-normal-state-p)
             (not (eolp))
             (not (eobp)))
    (forward-char))
  (let ((str (simpleclip-get-contents)))
    (cond
     ((not n)
      ;; do nothing
      )
     ((= 1 n)
      (setq str (replace-regexp-in-string "^\\(+\\|-\\)" "" str)))
     ((= 2 n)
      (kill-new str)))
    (insert str)))

;; Smart copy, if no region active, it simply copy the current whole line
(defadvice kill-line (before check-position activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode js-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1)
                 (just-one-space 0)
                 (backward-char 1)))))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end))
                 (message "Copied line")
                 (list (line-beginning-position)
                       (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; Copy line from point to the end, exclude the line break
(defun qiang-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (point)
                  (line-end-position))
  ;; (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
(global-set-key (kbd "M-k") 'qiang-copy-line)

(provide 'init-clipboard)
