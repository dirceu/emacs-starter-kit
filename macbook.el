;; This is needed for Erlang mode setup
(setq erlang-root-dir "/opt/local/lib/erlang")
(setq load-path (cons "/opt/local/lib/erlang/lib/tools-2.6.5.1/emacs" load-path))
(setq exec-path (cons "/opt/local/lib/erlang/bin" exec-path))
(require 'erlang-start)

;; This is needed for Distel setup
(let ((distel-dir "~/.emacs.d/vendor/distel/elisp"))
  (unless (member distel-dir load-path)
    ;; Add distel-dir to the end of load-path
    (setq load-path (append load-path (list distel-dir)))))

(require 'distel)
(distel-setup)

;; Some Erlang customizations
(add-hook 'erlang-mode-hook
	  (lambda ()
	    ;; when starting an Erlang shell in Emacs, default in the node name
	    (setq inferior-erlang-machine-options '("-sname" "emacs"))
	    ;; add Erlang functions to an imenu menu
	    (imenu-add-to-menubar "imenu")))

;; Disable tabbar
(tabbar-mode 0)

;; Load textmate.el
(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
(require 'textmate)
(textmate-mode)

;; More customizations (from github.com/topfunky/emacs-starter-kit)
(setq default-tab-width 4)
(setq tab-width 4)

;; Remove scrollbars and make hippie expand
;; work nicely with yasnippet
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(require 'hippie-exp)
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        ))
 
(defun indent-or-complete ()
  (interactive)
  (if (and (looking-at "$") (not (looking-back "^\\s-*")))
      (hippie-expand nil)
    (indent-for-tab-command)))
(add-hook 'find-file-hooks (function (lambda ()
                                       (local-set-key (kbd "TAB") 'indent-or-complete))))
                                       
;; Activate theme
(load "~/.emacs.d/vendor/topfunky-theme.el")
(color-theme-topfunky)
