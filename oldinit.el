(package-initialize)

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

(load-library "url-handlers")
(add-to-list 'load-path "~/.emacs.d/packages/evil-leader/")
(add-to-list 'load-path "~/.emacs.d/packages/evil/")
(add-to-list 'load-path "~/.emacs.d/packages/emacs-grammarly/")
(add-to-list 'load-path "~/.emacs.d/packages/")
(add-to-list 'load-path "~/.emacs.d/config/")


(defconst home-directory "/users/mason/")
(defconst emacs-directory (concat home-directory ".emacs.d/"))
(defconst config-directory (concat emacs-directory "config/"))

(require 'keyconfig)
(require 'helmconfig)
(require 'packageconfig)
(require 'themeconfig)
(require 'texconfig)
(require 'multi-term)


(global-undo-tree-mode)

;;---------------------------------------------------------------
; Emacs Grammarly
;;---------------------------------------------------------------
(require 'emacs-grammarly)
(global-set-key (kbd "C-c C-g") 'grammarly-save-region-and-run)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Enable company mode eveywhere(add-to-list 'load-path "~/.emacs.d/packages/")
(global-company-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Orgy stuff
    (require 'ob-ipython)
    (org-babel-do-load-languages
      'org-babel-load-languages
      '((ipython . t)
        ;; other languages..
        ))
    (setq ob-ipython-resources-dir "/Users/mason/Documents/ob_ipython_resources/")
    (define-key evil-normal-state-map (kbd "M-<return>") 'org-babel-execute-src-block)
    (define-key evil-insert-state-map (kbd "M-<return>") 'org-babel-execute-src-block)
    ;; don't prompt me to confirm everytime I want to evaluate a block
    (setq org-confirm-babel-evaluate nil)
    (add-to-list 'org-structure-template-alist
                 '("j"
		   "
#+BEGIN_SRC ipython :session :results raw drawer :kernel julia-0.6
?
#+END_SRC
"))

(exec-path-from-shell-initialize)
(setenv "PATH" (concat "/Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages" ":" (getenv "PATH")))

(setq python-shell-interpreter "/Library/Frameworks/Python.framework/Versions/3.6/bin/python3")


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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Don't add M-<backspace>'d words to kill ring
(defun backward-delete-word (arg)
    "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))
(global-set-key (kbd "A-<backspace>") 'backward-delete-word)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Make it so that sleected text gets deleted if I start typing
(delete-selection-mode 1)

;; (setq eshell-cmpl-cycle-completions nil)
;; (define-key eshell-mode-map (kbd "<tab>") 'completion-at-point) 
(add-hook 'eshell-mode-hook
          (lambda () 
            (define-key eshell-mode-map (kbd "<tab>")
              (lambda () (interactive) (pcomplete-std-complete)))))
 (add-hook 'julia-mode-hook 'auto-complete-mode)


;;Stuff to Make Julia-repl work
(add-to-list 'load-path "/Users/mason/julia-repl")
(require 'julia-repl)
(add-hook 'julia-mode-hook 'julia-repl-mode)
(julia-repl-set-executable "/users/mason/julia/./julia")

(require 'iterm)
;;(add-hook 'julia-mode-hook 'iterm)






(setq-default word-wrap t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mac-command-modifier (quote super))
 '(mac-option-modifier (quote (:ordinary meta :function meta :mouse meta)))
 '(org-startup-truncated nil)
 '(package-selected-packages
   (quote
    (2048-game multiple-cursors undo-tree wrap-region 0xc pdf-tools use-package ob-ipython company auctex julia-mode general 0blayout which-key guide-key helm doom-themes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

