;; Are we running XEmacs or Emacs?
(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Custom Vars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(case-fold-search t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(global-font-lock-mode t nil (font-lock))
 '(py-python-command "ipython")
 '(save-place t nil (saveplace))
 '(show-paren-mode t nil (paren))
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Make it Pretty
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(default ((t (:stipple nil :background "cornsilk" :foreground "#000000" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 147 :width normal :family "adobe-courier"))))
 '(bold ((t (:bold t))))
 '(bold-italic ((t (:size "12pt" :family "Courier" :bold t :italic t))))
 '(cvs-marked-face ((((class color) (background light)) (:foreground "green4" :bold t))))
 '(dired-face-boring ((((class color)) (:foreground "Gray45"))))
 '(dired-face-executable ((((class color)) (:foreground "SeaGreen" :bold t))))
 '(dired-face-flagged ((((class color)) (:background "Gray"))))
 '(dired-face-marked ((((class color)) (:background "pink"))))
 '(dired-face-symlink ((((class color)) (:foreground "cyan4"))))
 '(font-lock-builtin-face ((((class color) (background light)) (:bold t :foreground "dark green"))))
 '(font-lock-comment-face ((((class color) (background light)) (:inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight light :height 150 :width normal :family "adobe-courier" :foreground "blue3"))))
 '(font-lock-constant-face ((((class color) (background light)) (:bold t :foreground "CadetBlue"))))
 '(font-lock-function-name-face ((((class color) (background light)) (:foreground "Blue" :bold t))))
 '(font-lock-keyword-face ((((class color) (background light)) (:bold t :foreground "purple4"))))
 '(font-lock-other-type-face ((t (:foreground "orange3" :bold t))))
 '(font-lock-reference-face ((((class color) (background light)) (:foreground "red3"))))
 '(font-lock-string-face ((((class color) (background light)) (:foreground "dark green" :bold t))))
 '(font-lock-type-face ((((class color) (background light)) (:bold t :foreground "purple4"))))
 '(font-lock-variable-name-face ((((class color) (background light)) (:foreground "navy"))))
 '(fringe ((t (:stipple nil :background "cornsilk2" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 150 :width normal :family "adobe-courier"))))
 '(italic ((t (:size "10pt" :family "Courier" :italic t))))
 '(modeline ((t (:foreground "black" :background "grey82")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc Config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;no splash screen
(setq inhibit-startup-message t)
;; 'y' or 'n' instead of 'yes' or 'no'
(fset 'yes-or-no-p 'y-or-n-p)
;;DO NOT make backup files
(setq make-backup-files nil)
;;; Disable automatic evaluations. (security reasons)
(put 'eval-expression 'disabled nil)
;;; Make Text mode the default for new buffers
(setq default-major-mode 'text-mode)
;;  Turn on Auto Fill mode automatically in Text mode
;; (add-hook 'text-mode-hook 'turn-on-auto-fill)
;; Always prompt for an ssh pw
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)
;; color in shell mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; Auto complete 
(add-hook 'minibuffer-setup-hook '(lambda() (icomplete-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mousewheel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(if (not running-xemacs)
    (require 'mwheel) ; Emacs
  (mwheel-install) ; XEmacs
)

(defun sd-mousewheel-scroll-up (event)
  "Scroll window under mouse up by five lines."
  (interactive "e")
  (let ((current-window (selected-window)))
    (unwind-protect
        (progn 
          (select-window (posn-window (event-start event)))
          (scroll-up 5))
      (select-window current-window))))

(defun sd-mousewheel-scroll-down (event)
  "Scroll window under mouse down by five lines."
  (interactive "e")
  (let ((current-window (selected-window)))
    (unwind-protect
        (progn 
          (select-window (posn-window (event-start event)))
          (scroll-down 5))
      (select-window current-window))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "<mouse-5>") 'sd-mousewheel-scroll-up)
(global-set-key (kbd "<mouse-4>") 'sd-mousewheel-scroll-down)
(global-set-key "\C-xg" 'goto-line)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line) 
;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)
;;make sure backspace is set
(define-key global-map "\^D" 'delete-backward-char)
(global-set-key [f5] 'shell)
(global-set-key [f6] 'replace-string)
(global-set-key [f7] 'shell-command-on-region)
(global-set-key [f9] 'dired-do-shell-command)
(global-set-key [f10] 'dired-show-file-type)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; View
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(scroll-bar-mode nil)
(tool-bar-mode nil)
(display-time)
(column-number-mode 1)
(setq visible-bell t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Editing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Always end a file with a newline
(setq require-final-newline t)
;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)
