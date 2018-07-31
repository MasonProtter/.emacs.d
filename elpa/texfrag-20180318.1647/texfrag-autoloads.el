;;; texfrag-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "texfrag" "texfrag.el" (0 0 0 0))
;;; Generated autoloads from texfrag.el
:

(autoload 'texfrag-mode "texfrag" "\
Preview LaTeX fragments in current buffer with the help of the
`preview' package.

\(fn &optional ARG)" t nil)

(defvar texfrag-global-mode nil "\
Non-nil if Texfrag-Global mode is enabled.
See the `texfrag-global-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `texfrag-global-mode'.")

(custom-autoload 'texfrag-global-mode "texfrag" nil)

(autoload 'texfrag-global-mode "texfrag" "\
Toggle Texfrag mode in all buffers.
With prefix ARG, enable Texfrag-Global mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Texfrag mode is enabled in all buffers where
`texfrag-global-mode-fun' would do it.
See `texfrag-mode' for more information on Texfrag mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "texfrag" '("texfrag-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; texfrag-autoloads.el ends here
