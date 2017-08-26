(custom-set-variables
;; ;; custom-set-variables was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
;; '(custom-enabled-themes (quote (whiteboard)))
 '(inhibit-startup-screen t))
;; '(org-file-apps (quote ((auto-mode . emacs) ("\\.mm\\'" . default) ("\\.pdf\\'" . "evince %s") ("\\.x?html?\\'" . default)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Refresh all buffers emacs
(global-auto-revert-mode t)

;; Load any external packages
(add-to-list 'load-path "~/.elisp")
(require 'xclip)
(require 'buffer-move)
(require 'cuda-mode)

(add-to-list 'load-path "~/Documents/MATLAB/j_tools/src/dev/ml_emacs")
  (require 'matlab-load)

(matlab-cedet-setup)

(add-hook 'matlab-mode-hook 'turn-off-auto-fill)

;; set up more matlab stuff
(setq warning-minimum-level :emergency)
(server-start)
(setq warning-minimum-level :warning)
(global-set-key (kbd "C-x m") 'matlab-shell)
(global-set-key (kbd "C-x C-m") 'matlab-shell)

;; keybindings for buffer move
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

(add-hook 'text-mode-hook (lambda () (visual-line-mode)))
(add-hook 'org-mode-hook (lambda () (visual-line-mode)))

;; Add OpenCL and CUDA code to the c-mode list
(add-to-list 'auto-mode-alist '("\\.cl\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c-mode))

(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)

(add-hook 'html-mode-hook
	  (lambda ()
	    ;; Default indentation is usually 2 spaces, changing to 4.
	    (set (make-local-variable 'sgml-basic-offset) 4)))

;; Automatically move cursor to new frame when created
(defadvice split-window (after move-point-to-new-window activate)
  "Moves the cursor to newly created window"
  (other-window 1))

;; XClip keybindings
;; Bind C-c C-w to 'clipboard-kill-ring-save
(global-set-key (kbd "C-c C-w") 'clipboard-kill-ring-save)
(global-set-key (kbd "C-c C-y") 'clipboard-yank)

;; Bind C-x / to string-insert-rectangle
(global-set-key (kbd "C-x /") 'string-insert-rectangle)

;; Bind C-c f to buffer switch ( I just can't get used to C-x b
;; for some reason and never use the auto fill stuff)
(global-set-key (kbd "C-x f") 'switch-to-buffer)

;;Change default C-x C-b to buffer-menu (instead of buffer list)
(global-set-key (kbd "C-x C-b") 'buffer-menu)

;; Bind C-j to RET in C-mode
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Bind C-x c to 'calculator ;; DANGEROUS!
(global-set-key (kbd "C-x c") 'calculator)

;; Keybinding for toggle-truncate-lines
(global-set-key (kbd "C-x t")  'toggle-truncate-lines)

;; Tweak the emacs shell
(remove-hook 'comint-output-filter-functions
	     'comint-postoutput-scroll-to-bottom)

;; Set easier window resize commands
(global-set-key (kbd "M-S-<down>") 'enlarge-window)
(global-set-key (kbd "M-S-<up>") 'shrink-window)
(global-set-key (kbd "M-S-<left>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-S-<right>") 'shrink-window-horizontally)
(put 'upcase-region 'disabled nil)

;; Set paren matching navigation commands 
(global-set-key (kbd "C-M-f") 'forward-sexp)
(global-set-key (kbd "C-M-b") 'backward-sexp)

;; Compile keystroke
(global-set-key (kbd "C-M-c") 'compile)

;; Set backup directory (so we don't get all the *~ in the working directories)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
(put 'downcase-region 'disabled nil)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))

;; Recent file mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(let ((default-directory "~/.emacs.d/"))
    (normal-top-level-add-subdirs-to-load-path))
;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0")
(require 'yasnippet)
(yas-global-mode 1)

;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-20150618.1949")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;; Python BS
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(setq-default python-indent 4)


;; SCons compiling stuff
 (setq auto-mode-alist
      (cons '("SConstruct" . python-mode) auto-mode-alist))
 (setq auto-mode-alist
      (cons '("SConscript" . python-mode) auto-mode-alist))
 (setq auto-mode-alist
      (cons '(".*.scons" . python-mode) auto-mode-alist))

;; John's function definitions
(defun attach-current-buffer-to-email ()
  "Attach the current buffer to a new thunderbird email"
  (interactive "")
  (call-process "thunderbird" nil "-compose" nil (message "%s" (buffer-file-name)))
  )

(defun scons()
  (interactive "")
  (message "%s" (compile "scons"))
  )

(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (file-exists-p (buffer-file-name)) (not (buffer-modified-p)))
        (revert-buffer t t t) )))
  (message "Refreshed open files.") )

(defun grab-current-filename()
  " Add the current buffer filename to the kill ring.
If buffer is not visiting a file, add the buffer name"
  (interactive)
  (let ((name (buffer-file-name (current-buffer))))
    (message name)
    (if name
	(kill-new name nil)
      (message "Buffer not visiting file. Filename not killed.")
      )
    )
  )

(defun save-copy-as (filename &optional confirm)
  "Write the current buffer to a file, without visiting that file"
  (interactive (list (if buffer-file-name
	     (read-file-name "Save a copy of file as: "
			     nil nil nil nil)
	   (read-file-name "Save a copy of buffer as: " default-directory
			   (expand-file-name
			    (file-name-nondirectory (buffer-name))
			    default-directory)
			   nil nil))
	 (not current-prefix-arg)))

  (message filename)
   (save-excursion
    (mark-whole-buffer)
    (write-region nil nil filename))
  )

(defun align-repeat (start end regexp)
  "Repeat alignment with respect to 
   the given regular expression."
  (interactive "r\nsAlign regexp: ")
  (align-regexp start end 
      (concat "\\(\\s-*\\)" regexp) 1 1 t))

;; Turn on line numbering for Code file types
(add-hook 'c-mode-hook (lambda () (linum-mode t)))
(add-hook 'c++-mode-hook (lambda () (linum-mode t)))
(add-hook 'matlab-mode-hook (lambda () (linum-mode t)))
(add-hook 'makefile-mode-hook (lambda () (linum-mode t)))
(add-hook 'python-mode (lambda () (linum-mode t)))
;(global-linum-mode t) ;;old global version

;; Default to toggle-truncate-lines in C-mode C++-mode and for makefiles
(add-hook 'c-mode-hook (lambda () (setq truncate-lines t)))
(add-hook 'c++-mode-hook (lambda () (setq truncate-lines t)))
(add-hook 'matlab-mode-hook (lambda () (setq truncate-lines t)))
(add-hook 'makefile-mode-hook (lambda () (setq truncate-lines t)))
(add-hook 'python-mode (lambda () (setq truncate-lines t)))

;; Open file in dired mode
(defun dired-open-file ()
  "In dired, open the file named on this line."
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (call-process "xdg-open" nil 0 nil file)))
