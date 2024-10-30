(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -synctex=1")
 '(auto-revert-remote-files t)
 '(company-dabbrev-ignore-case nil)
 '(company-minimum-prefix-length 3)
 '(custom-safe-themes
   '("9d9fda57c476672acd8c6efeb9dc801abea906634575ad2c7688d055878e69d6" "8891c81848a6cf203c7ac816436ea1a859c34038c39e3cf9f48292d8b1c86528" "6b289bab28a7e511f9c54496be647dc60f5bd8f9917c9495978762b99d8c96a0" "57f95012730e3a03ebddb7f2925861ade87f53d5bbb255398357731a7b1ac0e0" "ce3e6c12b48979ce89754884d913c7ecc8a7956543d8b09ef13abfab6af9aa35" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))
 '(doc-view-continuous t)
 '(doc-view-resolution 288)
 '(eat-enable-yank-to-terminal t)
 '(enable-remote-dir-locals t)
 '(julia-indent-offset 4)
 '(julia-snail-executable "julia")
 '(julia-snail-multimedia-enable t)
 '(julia-snail-popup-display-eval-results nil)
 '(julia-snail-show-error-window nil)
 '(julia-snail-terminal-type :eat)
 '(jupyter-executable "jupyter")
 '(ns-alternate-modifier '(:ordinary meta :function meta :mouse meta))
 '(ns-command-modifier 'super)
 '(org-file-apps
   '((auto-mode . emacs)
	 ("\\.mm\\'" . default)
	 ("\\.x?html?\\'" . default)
	 ("\\.pdf\\'" . emacs)))
 '(org-html-htmlize-output-type 'inline-css)
 '(org-startup-folded t)
 '(org-startup-truncated nil)
 '(package-selected-packages
   '(eat jupyter all-the-icons neotree ligature ligatures ob-async ob-julia-vterm julia-vterm quarto-mode quarto code-cells multi-vterm vterm smartparens smartparens-config autopair htmlize magit magit-popup auto-package-update fira-code-mode company-auctex auto-complete-auctex ac-capf quelpa-use-package quelpa zones fireplace auctex-latexmk company-tabnine julia-repl projectile company-lsp lsp-ui lsp-mode atom-one-dark-theme markdown-mode solarized-theme rainbow-delimiters ein slime isend-mode texfrag 2048-game multiple-cursors undo-tree 0xc pdf-tools use-package company auctex general 0blayout which-key guide-key helm doom-themes))
 '(safe-local-variable-values
   '((julia-snail-repl-buffer . "*julia-scrap*")
	 (julia-snail-executable . "julia")
	 (julia-snail-extra-args . "--project --threads=6")
	 (julia-snail-executable . "julia +1.11")
	 (julia-snail-repl-buffer . "*julia-OhMyThreads*")
	 (julia-snail-port . 10051)
	 (julia-snail-extra-args . "--project")
	 (julia-snail-repl-buffer . "*julia Mars*")
	 (julia-snail-port . 10050)
	 (org-confirm-babel-evaluate)
	 (TeX-command-extra-options . "-shell-escape")
	 (eval add-hook 'after-save-hook
		   (lambda nil
			 (org-babel-tangle))
		   nil t)))
 '(shell-file-name "/bin/zsh")
 '(tab-width 4)
 '(warning-suppress-types '((org-element-cache))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-document-info-keyword ((t (:inherit light-pink)))))

(setq mac-option-modifier 'meta)


