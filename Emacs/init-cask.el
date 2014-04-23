(require 'cask "/usr/local/Cellar/cask/0.6.0/cask.el")
(cask-initialize)

;; Snippets, ideas, and even some of my own stuff collected from
;; various places and various people over many years.  If you see your
;; code or ideas here, and no attribution, then all I can say is,
;; sorry, but a MASSIVE thank you!

(fset 'yes-or-no-p 'y-or-n-p)

(require 'edebug)

(setq aim/is-darwin (eq system-type 'darwin)
      aim/is-linux (eq system-type 'gnu/linux))

;; frame-based visualization
(blink-cursor-mode -1)		     ; blink off!
(line-number-mode -1)		     ; have line numbers and
(column-number-mode 1)		     ; column numbers in the mode line
(tool-bar-mode -1)		     ; no tool bar with icons
(scroll-bar-mode -1)		     ; no scroll bars
(global-hl-line-mode)		     ; highlight current line
(global-linum-mode -1)		     ; add line numbers on the left

(when (or aim/is-linux (not window-system))
  (menu-bar-mode -1))

(setq vc-follow-symlinks t)

(require 'dired-x)
(setq-default dired-omit-files-p t) ; this is buffer-local variable
(global-set-key (kbd "C-x C-j") 'dired-jump)

(require 'ibuffer)

(require 'epa-file)
(epa-file-enable)

(require 'ffap)
(ffap-bindings)

;; Make sure _my_ specific stuff is first on the load path.
(add-to-list 'load-path (concat user-emacs-directory "lisp"))

;; /This/ file (~init.el~) that you are reading
;; should be in this folder
;; Make sure _my_ specific stuff is first on the load path.
(add-to-list 'load-path user-emacs-directory)

;; Keeps ~Cask~ file in sync with the packages
;; that you install/uninstall via ~M-x list-packages~
;; https://github.com/rdallasgray/pallet
(require 'pallet)

;; Root directory
(setq root-dir (file-name-directory
		(or (buffer-file-name) load-file-name)))

;; Theme
;; https://github.com/bbatsov/zenburn-emacs
(load-theme 'zenburn t)
(set-cursor-color "yellow")

;; Font
;; https://www.mozilla.org/en-US/styleguide/products/firefox-os/typeface/#download-primary
;;(set-frame-font "Menlo-18" nil t)

;; Don't show startup screen
(setq inhibit-startup-screen t)

;; Show keystrokes
(setq echo-keystrokes 0.02)

;; Path
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Git
(require 'magit)
(eval-after-load 'magit
  (progn '(global-set-key (kbd "C-c i") 'magit-status)))

;; flx-ido completion system, recommended by Projectile
(require 'flx-ido)
(flx-ido-mode 1)
;; change it if you have a fast processor.
(setq flx-ido-threshhold 1000)

;; Project management
(require 'ack-and-a-half)
(require 'projectile)
(projectile-global-mode)

;; Snippets
;; https://github.com/capitaomorte/yasnippet
;; (require 'yasnippet)
;; (yas-load-directory (concat root-dir "snippets"))
;; (yas-global-mode 1)

;; Python editing
(require 'elpy)
(elpy-enable)
(elpy-use-ipython)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'none)

(fset 'yes-or-no-p 'y-or-n-p)

(require 'edebug)

(setq aim/is-darwin (eq system-type 'darwin)
      aim/is-linux (eq system-type 'gnu/linux))

;; frame-based visualization
(blink-cursor-mode -1)		     ; blink off!
(line-number-mode -1)		     ; have line numbers and
(column-number-mode 1)		     ; column numbers in the mode line
(tool-bar-mode -1)		     ; no tool bar with icons
(scroll-bar-mode -1)		     ; no scroll bars
;;(global-hl-line-mode)		     ; highlight current line
(global-linum-mode -1)		     ; add line numbers on the left

(when (or aim/is-linux (not window-system))
  (menu-bar-mode -1))

(setq vc-follow-symlinks t)

(require 'dired-x)
(setq-default dired-omit-files-p t) ; this is buffer-local variable
(global-set-key (kbd "C-x C-j") 'dired-jump)

(require 'ibuffer)

(require 'epa-file)
(epa-file-enable)

(require 'ffap)
(ffap-bindings)

;; Make sure _my_ specific stuff is first on the load path.
(add-to-list 'load-path (concat user-emacs-directory "lisp"))

(require 'aim-functions)

(when aim/is-darwin
  (aim/set-exec-path-from-shell-PATH))

(require 'aim-customize)
(require 'aim-frame)
(require 'aim-recentf)
(require 'aim-uniquify)
(require 'aim-global-keybindings)
(require 'aim-whatever)
(require 'aim-color-theme)
(require 'aim-go)
(require 'server)

(unless (server-running-p)
  (server-start))

(defvar short-system-name
  (car (split-string (system-name) "\\."))
  "Returns the short form of (system-name)")

(require 'company)
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-minimum-prefix-length 0)               ; autocomplete right after '.'
(setq company-idle-delay .3)                         ; shorter delay before autocompletion popup
(setq company-echo-delay 0)                          ; removes annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

(add-to-list 'company-backends 'company-dabbrev t)
(add-to-list 'company-backends 'company-ispell t)
(add-to-list 'company-backends 'company-aspell t)
(add-to-list 'company-backends 'company-files t)

(global-company-mode 1)

(require 'autopair nil 'noerror)
