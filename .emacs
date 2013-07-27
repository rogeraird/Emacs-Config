(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "ea0c5df0f067d2e3c0f048c1f8795af7b873f5014837feb0a7c8317f34417b04" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(scroll-bar-mode -1)

(if (display-graphic-p)
    (progn
      (load-theme 'solarized-dark))
  (load-theme 'cyberpunk))

;; Key bindings
(global-set-key (kbd "C-c d") 'insert-date)



(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/templates/")
(setq auto-insert-query nil)
(define-auto-insert "\.c" "c.c")
(ido-mode t)
(setq ido-mode-auto-merge-work-directories-length -1)
(column-number-mode t)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(defun insert-date (prefix)
   "Insert the current date. With prefix-argument, use ISO format. With two prefix arguments, write out the day and month name."
   (interactive "P")
   (let ((format (cond
		  ((not prefix) "%d.%m.%Y")
		  ((equal prefix '(4)) "%Y.%m.%d")
		  ((equal prefix '(16)) "%A, %d. %B %Y")))
		 (system-time-locale "en_GB"))
	 (insert (format-time-string format))))
