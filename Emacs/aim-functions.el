(defun aim/reverse-video nil
  "*Invert default face"
  (interactive)
  (let* ((fg (face-foreground 'default))
	 (bg (face-background 'default)))
    (set-face-foreground 'default bg)
    (set-face-background 'default fg)))

(defun aim/fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(defun aim/revert-buffer-now ()
  "revert-(current-buffer) asking no questions"
  (interactive)
  (revert-buffer nil t))

(defun aim/check-frame-colours ()
  (interactive)
  (and window-system
       (if (string-equal (downcase (face-foreground 'default)) "black")
	   (aim/reverse-video))))
