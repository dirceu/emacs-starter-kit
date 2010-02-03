;; This is needed for Erlang mode setup
(setq erlang-root-dir "/opt/local/lib/erlang")
(setq load-path (cons "/opt/local/lib/erlang/lib/tools-2.6.5/emacs" load-path))
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

;; Change theme
(color-theme-twilight)

;; Add keybindings
(global-set-key (kbd "TAB") 'yas/expand)

(add-hook 'ruby-mode-hook
  (lambda ()
    (define-key ruby-mode-map (kbd "A-r") 'ruby-compilation-this-buffer)
    (define-key ruby-mode-map (kbd "A-R") 'ruby-compilation-this-test)
    (define-key ruby-mode-map (kbd "A-i") 'inf-ruby)))

(add-hook 'python-mode-hook
  (lambda ()
    (define-key python-mode-map (kbd "A-r") 'python-send-buffer)
    (define-key python-mode-map (kbd "A-i") 'run-python)))

(add-hook 'erlang-mode-hook
  (lambda ()
    (define-key erlang-mode-map (kbd "A-r") 'inferior-erlang-compile)
    (define-key erlang-mode-map (kbd "A-i") 'inferior-erlang-display-buffer)
    (define-key erlang-extended-mode-map (kbd "M-/") 'hippie-expand)))

;; Disable tabbar
(tabbar-mode 0)

;; Load textmate.el
(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
(require 'textmate)
(textmate-mode)