;; Snippets, ideas, and even some of my own stuff collected from
;; various places and various people over many years.  If you see your
;; code or ideas here, and no attribution, then all I can say is,
;; sorry, but a MASSIVE thank you!

;; Load and/or create empty custom file.
(let ((fn "~/.emacs-custom.el"))
  (when (not (file-exists-p fn))
    (shell-command (concat "touch " fn)))
  (setq custom-file fn)
  (load custom-file))

(load custom-file 'noerror)

(setq vc-follow-symlinks t)

(setq aim/is-darwin (eq system-type 'darwin)
      aim/is-windows (eq system-type 'windows-nt)
      aim/is-linux (eq system-type 'gnu/linux))

;; The order here is important.

;; OS X doesn't use the shell PATH if it's not started from the shell.
(defun aim/set-exec-path-from-shell-PATH ()
  (let ((path-from-shell
	 (replace-regexp-in-string "[[:space:]\n]*$" ""
				   (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when aim/is-darwin
  (aim/set-exec-path-from-shell-PATH))

(load-file (concat user-emacs-directory "aim-functions.el"))

;; Do this upfront so that if there's some error then some of the less
;; irritating things have been fixed already.

(when aim/is-darwin
  (when window-system
    (progn
      ;;(set-default-font "Menlo-18")
      ;; (aim/reverse-video)
      (setq mac-command-modifier 'meta)
      (setq mac-option-modifier 'none))))

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 50)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(desktop-save-mode 1)

(setq auto-mode-alist (cons '("\\.mm$" . c++-mode) auto-mode-alist)
      c-default-style "linux"
      vc-follow-symlinks t
      inhibit-splash-screen t
      ring-bell-function '(lambda ())
      sentence-end-double-space nil
      require-final-newline t)

(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

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

(load-file (concat user-emacs-directory "bootstrap-el-get.el"))

(setq savehist-mode t)
(setq history-lenth 1000)

(require 'gnus)
(require 'ibuffer)
(require 'server)

(require 'epa-file)
(epa-file-enable)

(require 'ffap)
(ffap-bindings)

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; Share the clipboard
(setq x-select-enable-clipboard t)

;; Navigate windows with M-<arrows>
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

;; winner-mode provides C-<left> to get back to previous window layout
(winner-mode 1)

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
;; (global-auto-revert-mode -1)

;; M-x shell is a nice shell interface to use, let's make it colorful.  If
;; you need a terminal emulator rather than just a shell, consider M-x term
;; instead.
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; If you do use M-x term, you will notice there's line mode that acts like
;; emacs buffers, and there's the default char mode that will send your
;; input char-by-char, so that curses application see each of your key
;; strokes.
;;
;; The default way to toggle between them is C-c C-j and C-c C-k, let's
;; better use just one key to do the same.
(require 'term)
(define-key term-raw-map  (kbd "C-'") 'term-line-mode)
(define-key term-mode-map (kbd "C-'") 'term-char-mode)

;; Have C-y act as usual in term-mode, to avoid C-' C-y C-'
;; Well the real default would be C-c C-j C-y C-c C-k.
(define-key term-raw-map  (kbd "C-y") 'term-paste)

;; use ido for minibuffer completion
(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)

(global-set-key (kbd "C-x C-b") 'electric-buffer-list)

(require 'dired-x)
(setq-default dired-omit-files-p t) ; this is buffer-local variable

(when aim/is-linux
  (global-set-key [f11] 'aim/fullscreen))

;; View occurrence in occur mode
(define-key occur-mode-map (kbd "v") 'occur-mode-display-occurrence)
(define-key occur-mode-map (kbd "n") 'next-line)
(define-key occur-mode-map (kbd "p") 'previous-line)

(mapcar '(lambda (x)
	   (global-set-key (car x) (cdr x)))
	'(("\C-x\C-b"      . electric-buffer-list)
	  ("\C-x\C-j"      . dired-jump)
	  ("\C-x\m"        . gnus-msg-mail)
	  ([f1]            . gnus-slave)
	  ([f2]            . aim/revert-buffer-now)
	  ([f3]            . whitespace-cleanup)
	  ([f4]            . aim/reverse-video)
	  ("\C-xC"         . compile)
	  ("\C-xg"         . goto-line)
	  ("\C-x\C-g"      . goto-line)
	  ("\C-ci"         . magit-status)
	  ))

;; Make new frame visible when connecting via emacsclient
(add-hook 'server-switch-hook 'raise-frame)

;; More drugs vicar; hippie expand is dabbrev expand on steroids
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-file-name-partially
	try-complete-file-name
	try-expand-all-abbrevs
	try-expand-list
	try-expand-line
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol
	))

(setq hippie-expand-verbose t)

(global-set-key (kbd "M-/") 'hippie-expand)

;; When saving files, set execute permission if #! is in first line.
(add-hook 'after-save-hook
	  'executable-make-buffer-file-executable-if-script-p)

;; define function to shutdown emacs server instance
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs))

(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
	 (offset (- (1+ column) anchor))
	 (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    ;; Add kernel style
	    (c-add-style
	     "linux-tabs-only"
	     '("linux" (c-offsets-alist
			(arglist-cont-nonempty
			 c-lineup-gcc-asm-reg
			 c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
	  (lambda ()
	    (let ((filename (buffer-file-name)))
	      ;; Enable kernel mode for the appropriate files
	      (when (and filename
			 (or
			  (string-match (expand-file-name "~/src/linux-trees") filename)))
		(setq indent-tabs-mode t)
		(c-set-style "linux-tabs-only")))))

(defun sudo-find-file (file-name)
  "Like find file, but opens the file as root."
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))

;; find file as root
(defun djcb-find-file-as-root ()
  "Like `ido-find-file, but automatically edit the file with
root-privileges (using tramp/sudo), if the file is not writable by
user."
  (interactive)
  (let ((file (ido-read-file-name "Edit as root: ")))
    (unless (file-writable-p file)
      (setq file (concat "/sudo:root@localhost:" file)))
    (find-file file)))

(global-set-key (kbd "C-x C-S-f") 'djcb-find-file-as-root)

(defun occurrences (regexp &rest ignore)
  "Show all matches for REGEXP in an `occur' buffer."
  ;; keep text covered by occur-prefix and match text-properties
  (interactive (occur-read-primary-args))
  (occur regexp)
  (with-current-buffer (get-buffer "*Occur*")
    (let ((inhibit-read-only t)
	  delete-from
	  pos)
      (save-excursion
	(while (setq pos (next-property-change (point)))
	  (goto-char pos)
	  (if (not (or (get-text-property (point) 'occur-prefix)
		       (get-text-property (point) 'occur-match)))
	      (if delete-from
		  (delete-region delete-from (point))
		(setq delete-from (point)))
	    (when delete-from
	      (delete-region delete-from (point))
	      (if (get-text-property (point) 'occur-prefix)
		  (insert "\n")
		(insert " ")))
	    (setq delete-from nil)))))))

(when aim/is-linux
  (if (and (daemonp) (locate-library "edit-server"))
      (progn
	(require 'edit-server)
	(setq edit-server-new-frame nil)
	(edit-server-start))))

(add-hook 'edit-server-text-mode-hook
	  (lambda ()
	    (auto-complete-mode 1)
	    (flyspell-mode 1)))

(add-hook 'edit-server-done-hook
	  (lambda ()
	    (shell-command "wmctrl -x -a google-chrome")))

(and (require 'git-commit nil 'noerror)
     (add-hook 'git-commit-mode-hook 'turn-on-flyspell))

;; Run Mercurial commands through a single external process.
(and (executable-find "hg")
     (setq monky-process-type 'cmdserver))

(defun aim/frame-config (frame)
  "Custom behaviour for new frames."
  (with-selected-frame frame
    (when (display-graphic-p)
      ;; (set-background-color "#101416")
      ;; (set-background-color "grey50")
      ;;(set-foreground-color "#f6f3e8")
      (message "[%s] Wanting to change %s colors %s" (current-time-string) (selected-frame)  (face-foreground 'default)))
    ))

;; run now
(aim/frame-config (selected-frame))

;; and later
(add-hook 'after-make-frame-functions 'aim/frame-config)
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

;; Make sure _my_ specific stuff is first on the load path.
(add-to-list 'load-path "~/.emacs.d/lisp")

(unless (server-running-p)
  (server-start))

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; Store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(and (file-exists-p "~/.emacs.d/aim-mu.el")
     (load-file "~/.emacs.d/aim-mu.el"))

;;(setq initial-frame-alist '((height . 130)))
(setq mouse-yank-at-point t)

;;; Go

(add-to-list 'load-path
	     (concat (getenv "GOPATH") "/src/github.com/dougm/goflymake"))

(and (require 'auto-complete-mode nil 'noerror)
     (define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
     (define-key ac-complete-mode-map (kbd "C-p") 'ac-previous))

(require 'auto-complete)
(require 'go-mode nil 'noerror)
(require 'go-autocomplete nil 'noerror)
(require 'auto-complete-config nil 'noerror)
(require 'go-flymake nil 'noerror)

(add-hook 'before-save-hook 'gofmt-before-save)

(add-hook 'go-mode-hook
	  (lambda ()
	    (projectile-on)
	    (auto-complete-mode 1)
	    ;;(go-eldoc-setup)
	    (flymake-mode 1)
	    (local-set-key (kbd "M-.") 'godef-jump)
	    (local-set-key (kbd "M-/") 'ac-start)
	    (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
 
