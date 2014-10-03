(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)
(color-theme-approximate-on)

(electric-pair-mode t)
   
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("f0a99f53cbf7b004ba0c1760aa14fd70f2eabafe4e62a2b3cf5cabae8203113b" "7fa9dc3948765d7cf3d7a289e40039c2c64abf0fad5c616453b263b601532493" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "ea0c5df0f067d2e3c0f048c1f8795af7b873f5014837feb0a7c8317f34417b04" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow")))))

(scroll-bar-mode -1)

(if (display-graphic-p)
    (progn
      (load-theme 'solarized-dark))
  (load-theme 'cyberpunk))

;; Key bindings
(global-set-key (kbd "C-c d") 'insert-date)
(global-set-key (kbd "C-c s") 'sort-lines)
(global-set-key (kbd "C-c r") 'indent-region)

;; Add ~/.cabal/bin to exec-path
(setq exec-path (append exec-path '("/home/roger/.cabal/bin")))



(ido-mode t)
(setq ido-mode-auto-merge-work-directories-length -1)
(column-number-mode t)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(require 'flymake-easy)
(require 'flymake-haskell-multi) ;; not needed if installed via package
(add-hook 'haskell-mode-hook 'flymake-haskell-multi-load)

(defun flymake-haskell-init ()
  "When flymake triggers, generates a tempfile containing the
  contents of the current buffer, runs `hslint` on it, and
  deletes file. Put this file path (and run `chmod a+x hslint`)
  to enable hslint: https://gist.github.com/1241073"
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "hlint" (list local-file))))

(defun flymake-haskell-enable ()
  "Enables flymake-mode for haskell, and sets <C-c d> as command
  to show current error."
  (when (and buffer-file-name
             (file-writable-p
              (file-name-directory buffer-file-name))
             (file-writable-p buffer-file-name))
    (local-set-key (kbd "C-c d") 'flymake-display-err-menu-for-current-line)
    (flymake-mode t)))




(defun select-all-indent ()
  "Selects whole buffer and indents it correctly"
  (interactive)
  (mark-whole-buffer)
  (indent-region))


(defun insert-date (prefix)
   "Insert the current date. With prefix-argument, use ISO format. With two prefix arguments, write out the day and month name."
   (interactive "P")
   (let ((format (cond
		  ((not prefix) "%d.%m.%Y")
		  ((equal prefix '(4)) "%Y.%m.%d")
		  ((equal prefix '(16)) "%A, %d. %B %Y")))
		 (system-time-locale "en_GB"))
	 (insert (format-time-string format))))
