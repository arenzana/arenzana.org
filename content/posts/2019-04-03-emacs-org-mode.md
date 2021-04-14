---
author: iarenzana
categories:
- emacs
date: "2019-04-03T11:05:00Z"
guid: https://arenzana.org/?p=382
id: 382
show_author_box:
- "0"
tags:
- emacs
- org-mode
- tech
title: Emacs Org-mode
url: /2019/04/emacs-org-mode/
---
It&#8217;s hard to introduce [org-mode](https://orgmode.org). Most emacs users are familiar with it or have, at least, used it at some point or another. I personally have only been using it for about six months, but it has taken a pivotal role in my daily workflows. I will describe how I use it and how I have configured it. As always, feel free to tweak it to fit your needs.

##  My use cases

### Logbook/TODO-list

This is a little bit special. I use `org-mode` as a project tracker. Yes, we use JIRA and I actually integrate it [with Emacs]("https://www.emacswiki.org/emacs/OrgJiraMode), but pure org-mode for my personal notes and logbook is a better fit for me.

<img loading="lazy" class="alignnone size-full wp-image-359" src="https://arenzana.org/wp-content/uploads/2019/03/Screen-Shot-2019-03-09-at-15.36.21.png" alt="" width="791" height="327" />

As you can see, I keep track of my tasks using `org-mode`, but also add notes to the tasks if necessary. For development purposes, I also keep a log of problems that I have encountered and resolutions for these problems. That way I can go back to these notes in the future if needed. I keep this data saved as `todo.gpg` that gets encrypted and decrypted when opening and saving.

### Agenda

`org-mode` also works well when you want to combine your to-do list with your calendar. If, like me, you have your calendar on Google Calendar, you should check out [org-gcal]("https://github.com/myuhe/org-gcal.el"). For the most part, I always have a terminal tab with the agenda up and refresh it periodically to have the latest appointments and task schedules and deadlines.

### Journal

Great practice and excellent substitute for therapy. Store thoughts, experiences and ideas. Highly recommended. I use the wonderful [org-journal]("https://github.com/bastibe/org-journal") package for this.

### Blogging

I write this blog using `org-mode` 🙂 (thanks [org2blog]("https://github.com/org2blog/org2blog")). I can&#8217;t imagine writing it in any other way.

### RSS List
I just replaced my RSS reader of choice with [elfeed]("https://github.com/skeeto/elfeed"). It&#8217;s a simple emacs-based RSS reader. Fast, no frills and straightforward. To keep a list of my RSS feeds, I imported an OPML into [elfeed-org]("https://github.com/remyhonig/elfeed-org") and now keep all my RSS feeds in one beautiful org-file that I can easily manage and sync.

There&#8217;s plenty of reasons to use `org-mode`. I have used it for email, but honestly, I have been unable to find a suitable workflow for it. Longform writing is something I would like to spend more time doing, and `org-mode` seems like a great platform to get started with to do it.

## My configuration

{{< highlight emacs-lisp >}}
(setenv "GPG_AGENT_INFO" nil)
(setq epg-gpg-program "/usr/local/bin/gpg2")
(require 'epa-file)

(require 'password-cache)

(setq password-cache-expiry (* 15 60))
(setq epa-file-cache-passphrase-for-symmetric-encryption t)
{{< / highlight >}}

First of all, I load GPG for encryption/decryption of gpg files. I set a generous expiration because this is my work desktop and I always keep it locked.

{{< highlight emacs-lisp >}}
(require 'org-install)
(package-initialize)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cr" 'org-gcal-sync)
{{< / highlight >}}

I load `org-mode` and set the shortcuts to store links (it&#8217;s easier this way for me ?), capture (for agenda, work TODO, etc) and pull up the agenda.

{{< highlight emacs-lisp >}}
(setq org-directory "~/Documents/org/")
(setq org-default-notes-file "~/Documents/org/scrapbook.gpg")
(setq org-agenda-files (list "~/Documents/org/todo.gpg" "~/Documents/org/work_cal.org" "~/Documents/org/personal_cal.org"))
{{< / highlight >}}

{{< highlight emacs-lisp >}}
{{< / highlight >}}
    

Here I&#8217;m setting the directory structure. `org-directory` sets the default `org-mode` directory for file storage. Notes are created with `org-default-notes-file`, and `org-agenda-files` lists all the files loaded by default in the Agenda.

{{< highlight emacs-lisp >}}
(add-hook 'org-mode-hook #'(lambda ()
			     (visual-line-mode)
			     (org-indent-mode)))
(add-hook 'org-mode-hook #'toggle-word-wrap)

(defun my/org-mode-hook ()
  "My `org-mode' hook"
  (set-face-attribute 'org-document-info-keyword nil :foreground "yellow")
  (set-face-attribute 'org-document-info nil :foreground "cornflower blue")
  (set-face-attribute 'org-document-title nil :foreground "cornflower blue"))
(add-hook 'org-mode-hook 'my/org-mode-hook)
{{< / highlight >}}

Some color tweaks and line-wrapping. `org-mode` doesn&#8217;t wrap lines by default, but that has an easy fix.

{{< highlight emacs-lisp >}}
(setq org-todo-keywords
	  '((sequence "TODO(t)" "PENDING(p!)" "WAIT(w@)" "VERIFY(v)" "|" "DONE(d!)" "CANCELED(c@)")
	     (sequence "REPORT(r@)" "BUG(b@)" "KNOWNCAUSE(k@)" "|" "FIXED(f!)")))

(global-set-key (kbd "C-c s") 
		(lambda () (interactive) (find-file "~/Documents/org/scrapbook.gpg")))
(global-set-key (kbd "C-c w") 
		(lambda () (interactive) (find-file "~/Documents/org/todo.gpg")))

(setq org-log-done 'time)
(setq org-list-allow-alphabetical t)
{{< / highlight >}}

Define files for notes and for the to-do list. Here we also define the to-do sequences and indicate whether I want them timestamped (!) or timestamped and with a comment (@).

{{< highlight emacs-lisp >}}
(setq org-capture-templates
'(("n" "Personal Note" entry (file "~/Documents/org/scrapbook.gpg")
   "* PERSONAL NOTE %?\n%U\n" :empty-lines 1)
  ("w" "Work Note" entry (file "~/Documents/org/scrapbook.gpg")
   "* WORK NOTE %?\n%U\n" :empty-lines 1)
  ("j" "Journal" entry
   (file+datetree "~/Documents/org/journal.gpg")
   "**** %U%?\n%a" :tree-type week))
)
{{< / highlight >}}

Define the capture modes. I only have personal and work notes and journal capture.

{{< highlight emacs-lisp >}}
(eval-after-load "org"
  '(require 'ox-md nil t))
{{< / highlight >}}

`org-agenda` will only load the next 4 days. I don’t need any more than that.

{{< highlight emacs-lisp >}}
(setq org-agenda-span 4)
{{< / highlight >}}

{{< highlight emacs-lisp >}}
(require 'org2blog-autoloads)
(require 'netrc)

(require 'auth-source)
(let (credentials)
	(add-to-list 'auth-sources "~/.authinfo")
	(setq credentials (auth-source-user-and-password "arenzana.org"))
	(setq org2blog/wp-blog-alist
	      `(("arenzanaorg"
		 :url "https://arenzana.org/xmlrpc.php"
		 :username ,(car credentials)
		 :password ,(cadr credentials)
		 :default-title "Hello World"
		 :default-categories ("emacs")
		 :tags-as-categories nil))))

(setq org2blog/wp-use-sourcecode-shortcode nil)
;; removed light="true"
(setq org2blog/wp-sourcecode-default-params nil)
;; target language needs to be in here
(setq org2blog/wp-sourcecode-langs
      '("actionscript3" "bash" "coldfusion" "cpp" "csharp" "css" "delphi"
	"erlang" "fsharp" "diff" "groovy" "javascript" "java" "javafx" "matlab"
	"objc" "perl" "php" "text" "powershell" "python" "ruby" "scala" "sql"
	"vb" "xml" "go" "sh" "emacs-lisp" "lisp" "lua"))

;; this will use emacs syntax higlighting in your #+BEGIN_SRC
;; <language> <your-code> #+END_SRC code blocks.
(setq org-src-fontify-natively t)
{{< / highlight >}}

For `org-2blog` We begin by loading it and `.netrc`. In my case, I&#8217;m using `.authinfo` that I keep encrypted as well. It stores my blog credentials. Since I only have one blog, I just add it as `arenzanaorg` to the wordpress blog list, set some defaults, and then set some source code defaults. I got most of this configuration from <a [here]("http://blog.binchen.org/posts/how-to-use-org2blog-effectively-as-a-programmer.html"). Great resource!

{{< highlight emacs-lisp >}}
(require 'org-gcal)
(load-library "~/.gcal.el.gpg")
(setq org-gcal-file-alist '(("iarenzana@gmail.com" .  "~/Documents/org/personal_cal.org")
("iarenzana@indigital.net" . "~/Documents/org/work_cal.org")))
{{< / highlight >}}

<img loading="lazy" class="alignnone size-full wp-image-385" src="https://arenzana.org/wp-content/uploads/2019/04/Screen-Shot-2019-04-03-at-11.30.34-AM.png" alt="" width="919" height="210" />

`org-gcal` is the package I use to pull [Google Calendar]("https://calendar.google.com") data into Emacs and, ultimately, `org-agenda`. Earlier in the set up I created a shortcut for `org-gcal-sync` to update the calendars on demand. After that, I just press `r` in `org-agenda` to refresh the buffer and the new events show up . In order to not publish API keys to any repository, I keep this information in a `.gcal.el.gpg` file stored in my home directory. This is what the structure of that file looks like:
	  
{{< highlight emacs-lisp >}}
;; -*- epa-file-encrypt-to: ("user@example.com") -*-

(setq org-gcal-client-id "clientid"
      org-gcal-client-secret "secretkey")
{{< / highlight >}}

Make sure you substitute the email address with your PGP key&#8217;s email and both `clientid` and `secretid` with the ones generated at <a href="https://cloud.google.com/">Google Cloud</a> for your calendar. To do this, create a new oauth key pair.


## Caveats

There&#8217;s a few things that still bother me that I want to tackle. First of them is the `yellow` output of my blog&#8217;s HTML code source. I&#8217;m disabling colors by not specifying `emacs-lisp` as the language, but this is a bad work around. I have been unable to correctly format the HTML template for this, so I will need to keep researching.

Also, every time I open emacs I&#8217;m prompted for `.gcal.el.gpg`&#8216;s password. I&#8217;d like to delay this until I call `org-gcal`.

## Summary

I know I&#8217;ve flown over my `org-mode` set up, but going in depth would take a lot more posts (which I may write). For now this is a short introduction to how I use the package and some of the possibilities that might bring ideas on how to improve your workflows.
