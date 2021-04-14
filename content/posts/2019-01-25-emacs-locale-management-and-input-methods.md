---
author: iarenzana
categories:
- emacs
date: "2019-01-25T11:09:00Z"
guid: https://arenzana.org/?p=352
id: 352
show_author_box:
- "0"
tags:
- emacs
- english
- spanish
- tech
title: Emacs Locale Management and Input Methods
url: /2019/01/emacs-locale-management-and-input-methods/
---
I was born in Spain, and have lived there most of my life. In fact, I just moved to the US 6 years ago. This means that a lot of my spoken and written communication is still in Spanish, mostly overseas with family and friends. Working with special characters non existent in the English language (think ñ, á, etc) is not as straight forward as it is on MacOS for instance, where `Alt + e + a` will result in á.

## Temporarily enable an input method

By default, Emacs doesn&#8217;t have an [input method]("https://www.emacswiki.org/emacs/InputMethods"). Which means that special characters will not be very convenient to insert. To be able to switch languages, you will need to set an input method. In my case, `latin-1-prefix` will be the chosen locale. To do this, run `M-x set-input-method` and then choose the locale. This will most likely affect your editing mode when special characters are no longer needed, therefore to disable the input method, issue `M-x toggle-input-method` or just `C-\`.

## Permanently enable an input method

This all works well when you want to write using a different locale temporarily, but it doesn&#8217;t work well when you want to have an input method enabled every time you&#8217;re in a mode. For instance, if I want to type text in Spanish every time I'm in `org-mode`, I would need to issue the <code>M-x set-input-method` command every time I open this mode. This is obviously an inconvenience, and the Emacs life is all about making the editor just the way you want it.

To permanently set an input method for a mode, we will need to add something like this to our init file.

{{< highlight lisp >}}
;; Set latin-1-prefix as default locale

(setq default-input-method "latin-1-prefix")
(defun activate-default-input-method ()
  (interactive)
  (activate-input-method default-input-method))
(add-hook 'org-mode-hook 'activate-default-input-method)
{{< / highlight >}}


Here we are indicating that `latin-1-prefix` will be our new `default-input-method` and the function will enable this method for `org-mode`. This way, every time we open `org-mode`, I will be ready to type in Spanish. This is a white-listing approach, where we select the modes that will have an input method applied, but we can also take the opposite approach. A blacklist method approach will enable an input method for ALL modes except for the ones indicated. This was the first approach I took, but soon realized that I have too many key bindings that would be disabled by the special character keys. Here&#8217;s an example of the blacklist approach.
    
{{< highlight lisp >}}
;; Set latin-1-prefix as default locale

(setq default-input-method "latin-1-prefix")
(defvar use-default-input-method t)
(make-variable-buffer-local 'use-default-input-method)
(defun activate-default-input-method ()
  (interactive)
  (if use-default-input-method
      (activate-input-method default-input-method)
    (inactivate-input-method)))
(add-hook 'after-change-major-mode-hook 'activate-default-input-method)
(add-hook 'minibuffer-setup-hook 'activate-default-input-method)
(defun inactivate-default-input-method ()
  (setq use-default-input-method nil))
;; Blacklisted modes
(add-hook 'c-mode-hook 'inactivate-default-input-method)
(add-hook 'go-mode-hook 'inactivate-default-input-method)
(add-hook 'markdown-mode-hook 'inactivate-default-input-method)
(add-hook 'sh-mode-hook 'inactivate-default-input-method)
{{< / highlight >}}

This way, we are enabling `latin-1-prefix` as the default input method for everything except for `c-mode`, `go-mode`, `markdown-mode`, and `sh-mode`. While these cover many of the options that I use on a regular basis, `dired` and other modes that I use very frequently would still be screwed up and the blacklist would grow too large. Whitelisting `org-mode` is enough for now. I might consider `message-mode` for writing emails in Spanish, which I seldom do, or `text-mode` (rarely used as well).

## Summary

Overall I feel very happy with this set up, but still needs some minor tweaking. As always, Emacs&#8217; flexibility makes customization extremely powerful. Easily overwhelming. Just like everything we&#8217;re doing, try settings out, keep your `.emacs` in source control and make changes without fear. Tweak as needed. Repeat.
