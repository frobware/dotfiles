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
(require 'aim-el-get)
(require 'aim-uniquify)
(require 'aim-global-keybindings)
(require 'aim-whatever)
(require 'aim-color-theme)
(require 'server)

(unless (server-running-p)
  (server-start))

(defvar short-system-name
  (car (split-string (system-name) "\\."))
  "Returns the short form of (system-name)")
