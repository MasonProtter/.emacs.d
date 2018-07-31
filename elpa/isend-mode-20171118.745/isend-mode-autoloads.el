;;; isend-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "isend-mode" "isend-mode.el" (0 0 0 0))
;;; Generated autoloads from isend-mode.el

(let ((loads (get 'isend 'custom-loads))) (if (member '"isend-mode" loads) nil (put 'isend 'custom-loads (cons '"isend-mode" loads))))

(defvar isend-forward-line t "\
If non-nil, `isend-send' advances by one line after sending content.")

(custom-autoload 'isend-forward-line "isend-mode" t)

(defvar isend-skip-empty-lines t "\
If non-nil, `isend-send' skips empty lines (i.e. lines containing only spaces).

Note that this is effective only for sending single lines. To strip whitespace
from sent regions use `isend-strip-empty-lines'.")

(custom-autoload 'isend-skip-empty-lines "isend-mode" t)

(defvar isend-strip-empty-lines nil "\
If non-nil, `isend-send' strips empty lines (i.e. lines containing only spaces).

Note that this works when sending an entire region. If enabled, all lines containing
whitespace only will be stripped from the region before it is sent.")

(custom-autoload 'isend-strip-empty-lines "isend-mode" t)

(defvar isend-delete-indentation nil "\
If non-nil, `isend-send' deletes indentation in regions sent.

Note that this only works when sending a region (as opposed to a
single line). Relative indentation with respect to the first line
in the region is preserved.

This is useful to send e.g. Python blocks.")

(custom-autoload 'isend-delete-indentation "isend-mode" t)

(defvar isend-end-with-empty-line nil "\
If non-nil, `isend-send' appends an empty line to everything you send.

This is useful, for example, when working with python code,
in which whitespace terminates definitions.")

(custom-autoload 'isend-end-with-empty-line "isend-mode" t)

(defvar isend-send-line-function 'insert-buffer-substring "\
Function used by `isend-send' to send a single line.

This function takes as argument the name of a buffer containing
the text to be sent.

Possible values include:
- `insert-buffer-substring' (default)
- `isend--ipython-cpaste'
- `isend--ipython-paste'")

(custom-autoload 'isend-send-line-function "isend-mode" t)

(defvar isend-send-region-function 'insert-buffer-substring "\
Function used by `isend-send' to send a region.

This function takes as argument the name of a buffer containing
the text to be sent.

Possible values include:
- `insert-buffer-substring' (default)
- `isend--ipython-cpaste'
- `isend--ipython-paste'")

(custom-autoload 'isend-send-region-function "isend-mode" t)

(defvar isend-mark-defun-function 'mark-defun "\
Function used by `isend-defun' to select a function definition.

This function should take no argument.

Possible values include:
- `mark-defun' (default)
- `isend--python-mark-defun'")

(custom-autoload 'isend-mark-defun-function "isend-mode" t)

(autoload 'isend-default-shell-setup "isend-mode" "\


\(fn)" nil nil)

(autoload 'isend-default-python-setup "isend-mode" "\


\(fn)" nil nil)

(autoload 'isend-default-ipython-setup "isend-mode" "\


\(fn)" nil nil)

(autoload 'isend-associate "isend-mode" "\
Set the buffer to which commands will be sent using `isend-send'.
This should usually be something like '*ansi-term*' or '*terminal*'.

\(fn BUFFERNAME)" t nil)

(defalias 'isend 'isend-associate)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "isend-mode" '("isend-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; isend-mode-autoloads.el ends here
