;; (add-hook 'c++-mode-hook
;;           (lambda () (setq flycheck-clang-include-path
;;                            (list (expand-file-name "/home/tiankai/tools/ADT/android-ndk-r10e/platforms/android-19/arch-arm/usr/include")))))
;; (add-hook 'c-mode-hook
;;           (lambda () (setq flycheck-clang-include-path
;;                            (list (expand-file-name "/home/tiankai/tools/ADT/android-ndk-r10e/platforms/android-19/arch-arm/usr/include")))))

;; (add-hook
;;  'c-mode-hook
;;  (lambda () (set flycheck-clang-include-path (mapcar (lambda (p) (expand-file-name p (projectile-project-root)) my-relative-include-paths)))))


(setq flycheck-clang-include-path '
      ("/home/tiankai/tools/ADT/android-ndk-r10e/platforms/android-19/arch-arm/usr/include" "/home/tiankai/git-hub/AegisShield/src/DexUnshellTool/jni" "/home/tiankai/git-hub/AegisShield/src/DexUnshellTool/jni/dalvik" "/home/tiankai/git-hub/AegisShield/src/DexUnshellTool/jni/dalvik/vm" "/home/tiankai/git-hub/AegisShield/src/DexUnshellTool/jni/system/core/include" "/home/tiankai/git-hub/AegisShield/src/DexUnshellTool/jni/system/core/include/cutils" "/home/tiankai/git-hub/AegisShield/src/DexUnshellTool/jni/frameworks/base/include"))

;; (defun setup-flycheck-clang-project-path ()
;;   (let ((root (ignore-errors (projectile-project-root))))
;;     (when root
;;       (add-to-list
;;        (make-variable-buffer-local 'flycheck-clang-include-path)
;;        root)))

;;   (add-hook 'c++-mode-hook 'setup-flycheck-clang-project-path)

  (provide 'init-flycheck)
