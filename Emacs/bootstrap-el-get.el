;; ------------------------------------------------------------------------
;; Standard el-get stuff.
;; ------------------------------------------------------------------------

(require 'cl)				; common lisp goodies, loop

(setq el-get-user-package-directory "~/.emacs.d/packages.d/")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

;; local sources
(setq el-get-sources
      '((:name magit
	       :after (global-set-key (kbd "C-c i") 'magit-status))
	(:name lisppaste :type elpa)))

(setq my-packages
      (append
       '(
	 ag
	 cl-lib
	 dockerfile-mode
	 edit-server
	 el-get
	 ffap-
	 git-commit-mode
	 gnus-alias
	 go-mode
	 google-maps
	 message-x
	 monky
	 nxhtml
	 org-mode
	 package
	 projectile
	 switch-window
	 textile-mode
	 xcscope
	 yaml-mode
	 yasnippet
	 )
       (mapcar 'el-get-source-name el-get-sources)))

(unless (string-match "apple-darwin" system-configuration)
  (loop for p in '(color-theme		; nice looking emacs
		   color-theme-tango	; check out color-theme-solarized
		   )
	do (add-to-list 'el-get-sources p)))

(el-get 'sync my-packages)
(el-get 'sync)
