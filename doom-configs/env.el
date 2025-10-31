;;; env.el -*- lexical-binding: t; -*-

(setenv "CC"  (executable-find "clang"))
(setenv "CXX" (executable-find "clang++"))

;;
(setenv "PATH"
        (concat (expand-file-name "~/.guix-profile/bin") ":"
                (getenv "PATH")))
(setenv "PKG_CONFIG_PATH"
        (concat (expand-file-name "~/.guix-profile/lib/pkgconfig")
                (when (getenv "PKG_CONFIG_PATH")
                  (concat ":" (getenv "PKG_CONFIG_PATH")))))
(setenv "LD_LIBRARY_PATH"
        (concat (expand-file-name "~/.guix-profile/lib")
                (when (getenv "LD_LIBRARY_PATH")
                  (concat ":" (getenv "LD_LIBRARY_PATH")))))

;; Make sure Emacs’s exec-path matches:
(add-to-list 'exec-path (expand-file-name "~/.guix-profile/bin"))
