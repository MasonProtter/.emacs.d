;;; julia-repl-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "julia-repl" "julia-repl.el" (0 0 0 0))
;;; Generated autoloads from julia-repl.el

(autoload 'julia-repl "julia-repl" "\
Raise the Julia REPL inferior buffer, creating one if it does not exist.

This is the standard entry point for using this package.

\(fn)" t nil)

(autoload 'julia-repl-mode "julia-repl" "\
Minor mode for interacting with a Julia REPL running inside a term.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "julia-repl" '("julia-repl-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; julia-repl-autoloads.el ends here
