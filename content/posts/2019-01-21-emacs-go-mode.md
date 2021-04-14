---
author: iarenzana
categories:
- emacs
date: "2019-01-21T20:55:00Z"
guid: https://arenzana.org/?p=345
id: 345
show_author_box:
- "0"
tags:
- emacs
- golang
- tech
title: Emacs Go Mode
url: /2019/01/emacs-go-mode/
---
You will notice how much I use &#8220;me&#8221; and &#8220;I&#8221; on this post. This because your emacs configuration is extremely personal. You are creating a &#8220;dream editor&#8221;, and the options that I pick might not be of your preference. Feel free to make it your own!

Back on topic. I started writing Go in late 2015. At first, I used [Sublime Text](https://www.sublimetext.com/), which I like a lot, but I was a little jealous of those using [vim-go](https://github.com/fatih/vim-go) and I figured there would be a way to make myself at home writing Go in Emacs. This is how the adventure began.

## Find a Mode!

The first thing I had to do was find a major mode for Go on emacs. It didn&#8217;t take me long to find [go-mode]("https://github.com/dominikh/go-mode.el"). Installation is not hard, as it&#8217;s available as a package in the MELPA repository. A simple `M-x package-install go-mode` sufficed. Configuring it was a bit harder.

## Configuration

## This is my `.emacs` configuration for Go.
    </p>

{{< highlight lisp >}}
;;Load Go-specific language syntax
;;For gocode use https://github.com/mdempsky/gocode

;;Custom Compile Command
(defun go-mode-setup ()
  (linum-mode 1)
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump)
  (setq compile-command "echo Building... && go build -v && echo Testing... && go test -v && echo Linter... && golint")
  (setq compilation-read-command nil)
  ;;  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (local-set-key (kbd "M-,") 'compile)
(add-hook 'go-mode-hook 'go-mode-setup)

;;Load auto-complete
(ac-config-default)
(require 'auto-complete-config)
(require 'go-autocomplete)

;;Go rename

(require 'go-rename)

;;Configure golint
(add-to-list 'load-path (concat (getenv "GOPATH")  "/src/github.com/golang/lint/misc/emacs"))
(require 'golint)

;;Smaller compilation buffer
(setq compilation-window-height 14)
(defun my-compilation-hook ()
  (when (not (get-buffer-window "*compilation*"))
    (save-selected-window
      (save-excursion
        (let* ((w (split-window-vertically))
               (h (window-height w)))
          (select-window w)
          (switch-to-buffer "*compilation*")
          (shrink-window (- h compilation-window-height)))))))
(add-hook 'compilation-mode-hook 'my-compilation-hook)

;;Other Key bindings
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

;;Compilation autoscroll
(setq compilation-scroll-output t)

{{< / highlight >}}

## The Basics
That’s a lot! Yeah, I know, but before you freak out, I’ll give you a run down of what each block is for (although the comments should help a lot).

{{< highlight lisp >}}
;;Load Go-specific language syntax
;;For gocode use https://github.com/mdempsky/gocode

;;Goimports
(defun go-mode-setup ()
  (go-eldoc-setup)
  (add-hook 'before-save-hook 'gofmt-before-save)) 
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))
(add-hook 'go-mode-hook 'go-mode-setup)
{{< / highlight >}}

This block enables `go-mode` and makes sure it runs `gofmt` before saving. `gofmt` allows our code to be nice and tidy and to let `go-mode` take care of importing the required packages. Nifty, huh? Makes coding nicer.

## Making life even easier
Some extra elements to make our lives easier. Not necessary, but nice to have.
 
{{< highlight lisp >}}
 (defun go-mode-setup ()
  ;;  (setq compile-command "go build -v && go test -v && go vet && golint && errcheck")
  (linum-mode 1)
  (setq compile-command "echo Building... && go build -v && echo Testing... && go test -v && echo Linter... && golint")
  (setq compilation-read-command nil)
  ;;  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (local-set-key (kbd "M-,") 'compile)
(add-hook 'go-mode-hook 'go-mode-setup)
{{< / highlight >}}

This is a good one. Here I&#8217;m configuring `M-,` (Escape key + comma) to run `go build`, `go test`, and `golint`. Extremely simple way make sure our code compiles.

## Autocomplete and Linting

{{< highlight lisp >}}
;;Load auto-complete
(ac-config-default)
(require 'auto-complete-config)
(require 'go-autocomplete)

;;Go rename

(require 'go-rename)

;;Configure golint
(add-to-list 'load-path (concat (getenv "GOPATH")  "/src/github.com/golang/lint/misc/emacs"))
(require 'golint)
{{< / highlight >}}

Sets up `go-autocomplete` and `go-rename`. `go-rename` only is used if you want to do project-level renames. Just between us, I barely use it.

The last block configures the path of the linter. Remember, Emacs is smart, but not *that* smart.

## Beautify our editor

{{< highlight lisp >}}
;;Smaller compilation buffer
(setq compilation-window-height 14)
(defun my-compilation-hook ()
  (when (not (get-buffer-window "*compilation*"))
    (save-selected-window
      (save-excursion
        (let* ((w (split-window-vertically))
               (h (window-height w)))
          (select-window w)
          (switch-to-buffer "*compilation*")
          (shrink-window (- h compilation-window-height)))))))
(add-hook 'compilation-mode-hook 'my-compilation-hook)
{{< / highlight >}}

All of this to make the compilation buffer smaller than a default buffer.

{{< highlight lisp >}}
;;Other Key bindings
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
{{< / highlight >}}

How about a simple command to comment out big blocks of code? `C-c C-c`. Also, `compilation-scroll-output` simply scrolls the compilation buffer all the way to the end.

## What's Left

This is my current set up. It works really well for my needs, but it might not be yours. Something I&#8217;ll work on is to integrate `delve` (golang debugger) into the editor, but I suppose I&#8217;m quite old school.

I also have [Magit]("https://magit.vc/") integrated into my workflow, but that&#8217;s a topic for a different episode. To be honest, I don&#8217;t miss anything from Sublime (or Atom or MS Code), plus it already makes use of my favorite editor. A simple `.emacs` file gives me all the customization that I need and I know I always have MY set up everywhere.
