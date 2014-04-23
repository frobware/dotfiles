;;; Go (yay!)

;; (add-to-list 'load-path
;; 	     (concat (getenv "GOPATH") "/src/github.com/dougm/goflymake"))

;; (and (require 'auto-complete-mode nil 'noerror)
;;      (define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
;;      (define-key ac-complete-mode-map (kbd "C-p") 'ac-previous))

;; (and (require 'company)
;;      (define-key company-mode-map (kbd "C-n") 'company-select-next)
;;      (define-key company-mode-map (kbd "C-p") 'company-select-previous))

(require 'company)                                   ; load company mode
(require 'company-go)                                ; load company mode go backend
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-minimum-prefix-length 0)               ; autocomplete right after '.'
(setq company-idle-delay .3)                         ; shorter delay before autocompletion popup
(setq company-echo-delay 0)                          ; removes annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

(setq gofmt-command "goimports")
(add-to-list 'load-path "/home/you/goroot/misc/emacs/")
(require 'go-mode-load)
(add-hook 'before-save-hook 'gofmt-before-save)

(add-hook 'go-mode-hook
	  (lambda ()
	    (set (make-local-variable 'company-backends) '(company-go))
	    (company-mode)))

(defun aim/run-go-buffer ()
  (interactive)
  (shell-command (format "go run %s" (buffer-file-name (current-buffer)))))

(add-hook 'go-mode-hook
	  (lambda ()
	    (electric-pair-mode 1)
	    (flymake-mode 1)
	    (local-set-key (kbd "C-M-x") 'aim/run-go-buffer)
	    (local-set-key (kbd "M-.") 'godef-jump)
	    (local-set-key (kbd "M-/") 'company-complete)
	    (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))

(provide 'aim-go)
