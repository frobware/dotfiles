;;; Go (yay!)

(add-to-list 'load-path
	     (concat (getenv "GOPATH") "/src/github.com/dougm/goflymake"))

(and (require 'auto-complete-mode nil 'noerror)
     (define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
     (define-key ac-complete-mode-map (kbd "C-p") 'ac-previous))

(require 'auto-complete)
(require 'go-mode nil 'noerror)
(require 'go-autocomplete nil 'noerror)
(require 'auto-complete-config nil 'noerror)

(add-hook 'before-save-hook 'gofmt-before-save)

(defun aim/run-go-buffer ()
  (interactive)
  (shell-command (format "go run %s" (buffer-file-name (current-buffer)))))

(add-hook 'go-mode-hook
	  (lambda ()
	    (projectile-on)
	    (auto-complete-mode 1)
	    (flymake-mode 1)
	    (local-set-key (kbd "C-M-x") 'aim/run-go-buffer)
	    (local-set-key (kbd "M-.") 'godef-jump)
	    (local-set-key (kbd "M-/") 'ac-start)
	    (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
