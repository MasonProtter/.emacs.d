;; (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

;; (load-library "url-handlers")

  ;; (setq backup-directory-alist '(("." . "~/.emacs-saves")))

  ;; (defconst home-directory "$HOME")
  ;; (defconst emacs-directory (concat home-directory ".emacs.d/"))
  ;; (defconst config-directory (concat emacs-directory "config/"))
  ;; (defconst package-directory (concat emacs-directory "packages/"))

  ;; (add-to-list 'load-path (concat package-directory ""))
  ;; (add-to-list 'load-path (concat package-directory "evil-leader"))
  ;; (add-to-list 'load-path (concat package-directory "evil"))
  ;; (add-to-list 'load-path (concat package-directory "emacs-grammarly"))
  ;; (add-to-list 'load-path (concat package-directory "julia-repl"))
  ;; (add-to-list 'load-path (concat package-directory "lsp-julia"))
  ;; (add-to-list 'load-path (concat package-directory "ob-julia"))
  ;; (add-to-list 'load-path (concat package-directory "ESS/lisp"))

  ;; (add-to-list 'load-path "~/.emacs.d/packages/evil-leader/")
  ;; (add-to-list 'load-path "~/.emacs.d/packages/evil/")
  ;; (add-to-list 'load-path "~/.emacs.d/packages/emacs-grammarly/")
  ;; ;(add-to-list 'load-path "~/.emacs.d/packages/ESS/lisp/")
  ;; (add-to-list 'load-path "~/.emacs.d/packages/ob-julia")
  ;; (add-to-list 'load-path "~/.emacs.d/packages/")
  ;; (add-to-list 'load-path "/Users/mason/julia-repl")
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(use-package general
  :ensure t
  :init
  (which-key-mode)

   (defconst my-leader [escape])

   (general-create-definer my-leader-def
     ;; :prefix my-leader
     ;; or without a variable
     :prefix [escape])

   (which-key-add-key-based-replacements
     "<escape> f" "files"
     "<escape> fd" "dotfile"
     "<escape> fc" "config files"
     "<escape> <SPC>" "M-x"
     "<escape> o" "open"
     "<escape> m" "mode"
     "<escape> l" "LaTeX"
     "<escape> lp" "preview"
     "<escape> r" "remove")

  (defun select-current-line ()
    "Select the current line"
    (interactive)
    (end-of-line) ; move to end of line
    (set-mark (line-beginning-position)))


  (defun remove-newlines-in-region ()
    "Removes all newlines in the region."
    (interactive)
    (save-restriction
      (narrow-to-region (point) (mark))
      (goto-char (point-min))
      (while (search-forward "\n" nil t) (replace-match " " nil t))))

  (my-leader-def
    "<SPC>" 'helm-M-x
    "ff" 'helm-find-files
    "fd" '(lambda () (interactive) (find-file "~/.emacs.d/myinit.org"))
    "fc" '(lambda () (interactive) (find-file config-directory))
    "s" 'save-buffer
    "oe" 'eshell
    "os" 'shell
    "ot" 'term
    "b"  'switch-to-buffer
    "l"  'select-current-line
    "t"  'iterm-send-text
    "rq"  'remove-newlines-in-region)

  (my-leader-def 
    :keymaps 'LaTeX-mode-map
    "mc" 'TeX-command-master
    "mv" 'TeX-view
    "mpb" 'preview-buffer
    "mpr" 'preview-region
    "mps" 'preview-section
    "mpe" 'preview-environment
    "mpd" 'preview-document
    "me"  'LaTeX-environment)

  (general-define-key 
   "s-c" 'kill-ring-save
   "s-x" 'kill-region
   "s-v" 'yank
   "s-b" 'yank-pop)

  (my-leader-def
    :keymaps 'org-mode-map
    "q" 'org-fill-paragraph
    "cc" 'julia-repl-send-region-or-line))

(use-package wrap-region
  :init
  (wrap-region-global-mode t))

(use-package multiple-cursors
  :init
  (general-define-key
   "C-M-<mouse-1>" 'mc/add-cursor-on-click))

(defun is-in-gui()
  (display-graphic-p))
(defmacro when-gui (&rest body)
  "Works just like `progn' but will only evaluate expressions in VAR when Emacs is running in a GUI else just nil."
  `(when (is-in-gui) ,@body))
(defmacro when-not-gui (&rest body)
  `(when (not (is-in-gui)) ,@body))


(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))

(general-define-key 
 "C-<backspace>" 'backward-delete-word)

;; use option key for meta
(setq mac-option-modifier 'meta)


(when-not-gui
 (defvar personal/fast-keyseq-timeout 200)

 (defun personal/-tty-ESC-filter (map)
   (if (and (equal (this-single-command-keys) [?\e])
	    (sit-for (/ personal/fast-keyseq-timeout 1000.0)))
       [escape] map))

 (defun personal/-lookup-key (map key)
   (catch 'found
     (map-keymap (lambda (k b) (if (equal key k) (throw 'found b))) map)))

 (defun personal/catch-tty-ESC ()
   "Setup key mappings of current terminal to turn a tty's ESC into `escape'."
   (when (memq (terminal-live-p (frame-terminal)) '(t pc))
     (let ((esc-binding (personal/-lookup-key input-decode-map ?\e)))
       (define-key input-decode-map
	 [?\e] `(menu-item "" ,esc-binding :filter personal/-tty-ESC-filter)))))

 (personal/catch-tty-ESC))

(delete-selection-mode 1)

(use-package helm-config
  :init
  (general-define-key 
   "M-x" #'helm-M-x
   "C-x r b" #'helm-filtered-bookmarks
   "C-x C-f" #'helm-find-files
   "M-y" 'helm-show-kill-ring)
  (helm-mode 1))

(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-one t)
(doom-themes-visual-bell-config)
(doom-themes-neotree-config)  ; all-the-icons fonts must be installed!
(doom-themes-org-config)


(defun is-in-gui()
  (display-graphic-p))
(defmacro when-gui (&rest body)
  "Works just like `progn' but will only evaluate expressions in VAR when Emacs is running in a GUI else just nil."
  `(when (is-in-gui) ,@body))

(when-gui
 (toggle-scroll-bar -1) 
 (tool-bar-mode -1))

(global-undo-tree-mode)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(setenv "PATH" (concat "/Library/TeX/texbin" ":" (getenv "PATH")))

(use-package reftex
  :ensure t)

(use-package tex-site
  :ensure auctex
  :mode ("\\.tex\\'" . latex-mode)
  :config
  (setq reftex-plug-into-AUCTeX t)
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (add-hook 
   'LaTeX-mode-hook
   (lambda ()
     (company-mode)
     (setq TeX-auto-save t)
     (setq TeX-parse-self t)
     (setq TeX-save-query nil)
     (setq TeX-PDF-mode t)
     (setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
     ;; (setq TeX-view-program-list
     ;; 	   '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
     (setq  TeX-view-evince-keep-focus nil)))

  ;; Update PDF buffers after successful LaTeX runs
  (add-hook 'TeX-after-TeX-LaTeX-command-finished-hook
	    #'TeX-revert-document-buffer)

  (add-hook 'TeX-after-compilation-finished-functions
	    #'TeX-revert-document-buffer)
  ;; to use pdfview with auctex
  (add-hook 'LaTeX-mode-hook 'pdf-tools-install)

  ;; to use pdfview with auctex
  (setq TeX-view-program-selection '((output-pdf "pdf-tools"))
	TeX-source-correlate-start-server t)
  (setq TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view"))))

(use-package company-auctex
  :ensure t)
(company-auctex-init)

;; (add-to-list 'load-path "~/emacs-jupyter")
(use-package popup
  :ensure t)
(use-package jupyter
  :ensure t
  :config
  (require 'jupyter-python)
  (require 'jupyter-julia)
  (setq jupyter-eval-short-result-display-function 'popup-tip)
  (add-hook 'jupyter-repl-mode-hook 'rainbow-delimiters-mode-enable))


(require 'jupyter)
(require 'jupyter-julia)

(with-eval-after-load "org"

  (setq org-src-fontify-natively t
	org-src-tab-acts-natively t
	org-confirm-babel-evaluate nil
	org-edit-src-content-indentation 0)

					;(require 'ob-ipython)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (jupyter . t)))

  (setq org-confirm-babel-evaluate nil)
  (add-to-list 'org-structure-template-alist
	       '("j" "#+BEGIN_SRC julia
  ? 
  #+END_SRC"))

  (add-to-list 'org-structure-template-alist
	       '("jj" "#+BEGIN_SRC jupyter-julia
?
#+END_SRC"))

  (add-to-list 'org-structure-template-alist
	       '("la" "#+BEGIN_latex latex
  \\begin{align}
  ? 
  \\end{align}
  #+END_latex"))

  (add-to-list 'org-structure-template-alist
	       '("las" "#+BEGIN_latex latex
  \\begin{align*}
  ? 
  \\end{align*}
  #+END_latex"))

  (setq org-babel-default-header-args:jupyter-julia '((:async . "yes")
                                                      (:session . "jl")
                                                      (:kernel . "julia-1.3")
						      (:exports . "both")))

  ;;; display/update images in the buffer after I evaluate
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

  (setenv "PATH" (concat "/Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages" ":" (getenv "PATH")))

  (setq python-shell-interpreter "/Library/Frameworks/Python.framework/Versions/3.6/bin/python3")

  (add-to-list 'safe-local-variable-values
	       '(eval add-hook 'after-save-hook
		      (lambda () (org-babel-tangle))
		      nil t))

  (defun org-export-remove-prelim-headlines (tree backend info)
    "Remove headlines tagged \"prelim\" while retaining their
   contents before any export processing."
    (org-element-map tree org-element-all-elements
      (lambda (object)
	(when (and (equal 'headline (org-element-type object))
		   (member "prelim" (org-element-property :tags object)))
	  (mapc (lambda (el)
		  ;; recursively promote all nested headlines
		  (org-element-map el 'headline
		    (lambda (el)
		      (when (equal 'headline (org-element-type el))
			(org-element-put-property el
						  :level (1- (org-element-property :level el))))))
		  (org-element-insert-before el object))
		(cddr object))
	  (org-element-extract-element object)))
      info nil org-element-all-elements)
    tree)

  (add-hook 'org-export-filter-parse-tree-functions
	    'org-export-remove-prelim-headlines)

  ;; Change latex image sizes 
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))


  (defun my/org-mode-hook ()
    (set-face-attribute 'org-level-1 nil :height 1.25)
    (set-face-attribute 'org-level-2 nil :height 1.15)
    (set-face-attribute 'org-level-3 nil :height 1.05))
  (add-hook 'org-load-hook #'my/org-mode-hook)
  (add-hook 'org-mode-hook 'my/org-mode-hook)

  )

(use-package htmlize
  :ensure t
  :defer t)

(add-hook 'eshell-mode-hook
	  (lambda () 
	    (define-key eshell-mode-map (kbd "<tab>")
	      (lambda () (interactive) (pcomplete-std-complete)))))

(use-package julia-repl
  :ensure t
  :defer t
  :init
  (add-hook 'julia-mode-hook 'julia-repl-mode)
  ;;(add-hook 'julia-mode-hook 'company-mode)
  ;;(add-hook 'julia-mode-hook 'texfrag-mode)
  (setq julia-repl-executable-records
   '((default "~/julia/./julia")
     (default "~/julia/./julia")))

  (setq julia-repl-switches "-O3")

  (setenv "JULIA_NUM_THREADS" "4")
  ;; (my-leader-def
  ;;   :keymaps 'org-mode-map
  ;;   "s"  'julia-repl-send-region-or-line)

  ;; (my-leader-def
  ;;   :keymaps 'julia-mode-map
  ;;   "s"  'julia-repl-send-region-or-line)
)

(setq inferior-lisp-program "/usr/local/bin/sbcl")
(slime-setup '(slime-fancy))

(setq password-cache-expiry nil)

(defun cedar-shell ()
  (interactive)
  (let ((default-directory "/ssh:mprotter@cedar.computecanada.ca:"))
    (shell)))

(require 'tramp-sh nil t)

;; (use-package company-tabnine :ensure t)
;; (add-to-list 'company-backends #'company-tabnine)
;; ;; Trigger completion immediately.
;; (setq company-idle-delay 0)

;; ;; Number the candidates (use M-1, M-2 etc to select completions).
;; (setq company-show-numbers t)

;; ;; Use the tab-and-go frontend.
;; ;; Allows TAB to select and complete at the same time.
;; (company-tng-configure-default)
;; (setq company-frontends
;;       '(company-tng-frontend
;; 	company-pseudo-tooltip-frontend
;; 	company-echo-metadata-frontend))

(setq ispell-program-name "/usr/local/bin/aspell")

(menu-bar-mode 1)
(electric-pair-mode t)
(defvar latex-electric-pairs 
  '((\left . \right)) "Electric pairs for latex.")

(defun latex-add-electric-pairs ()
  (setq-local electric-pair-pairs 
	      (append electric-pair-pairs latex-electric-pairs))
  (setq-local electric-pair-text-pairs electric-pair-pairs))

(remove-hook 'latex-mode-hook 'org-add-electric-pairs)


;; Global company mode
(add-hook 'after-init-hook 'global-company-mode)

;; Set font
;; Set default font
;; (set-face-attribute 'default nil
;; 		      :family "SF Mono"
;; 		      :height 130
;; 		      :weight 'normal
;; 		      :width 'normal)

(add-hook 'emacs-mode-hook 'ac-capf-setup)

(set-face-attribute 
 'default t :family "DejaVu mono" :foundry "nil" :slant 'normal :weight 'normal :height 181 :width 'normal)

(set-fontset-font "fontset-default"  '(#x2800 . #x28FF) "DejaVu Sans")
