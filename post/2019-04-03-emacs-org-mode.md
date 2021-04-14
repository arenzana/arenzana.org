---
asalah_custom_description:
- ""
asalah_enable_sliding_sidebar:
- "0"
asalah_show_meta:
- "0"
asalah_show_share:
- "0"
asalah_show_title:
- "0"
asalah_sidebar_position:
- "0"
asalah_sticky_menu:
- "0"
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

<div id="outline-container-org508b507" class="outline-2">
  <h2 id="org508b507">
    My use cases
  </h2>
  
  <div id="text-org508b507" class="outline-text-2">
  </div>
  
  <div id="outline-container-org4aca8a0" class="outline-3">
    <h3 id="org4aca8a0">
      Logbook/TODO-list
    </h3>
    
    <div id="text-org4aca8a0" class="outline-text-3">
      <p>
        This is a little bit special. I use <code>org-mode</code> as a project tracker. Yes, we use JIRA and I actually integrate it <a href="https://www.emacswiki.org/emacs/OrgJiraMode">with Emacs</a>, but pure org-mode for my personal notes and logbook is a better fit for me.
      </p>
      
      <p>
        <img loading="lazy" class="alignnone size-full wp-image-359" src="https://arenzana.org/wp-content/uploads/2019/03/Screen-Shot-2019-03-09-at-15.36.21.png" alt="" width="791" height="327" />
      </p>
      
      <p>
        As you can see, I keep track of my tasks using <code>org-mode</code>, but also add notes to the tasks if necessary. For development purposes, I also keep a log of problems that I have encountered and resolutions for these problems. That way I can go back to these notes in the future if needed. I keep this data saved as <code>todo.gpg</code> that gets encrypted and decrypted when opening and saving.
      </p>
    </div>
  </div>
  
  <div id="outline-container-org297ca1a" class="outline-3">
    <h3 id="org297ca1a">
      Agenda
    </h3>
    
    <div id="text-org297ca1a" class="outline-text-3">
      <p>
        <code>org-mode</code> also works well when you want to combine your to-do list with your calendar. If, like me, you have your calendar on Google Calendar, you should check out <a href="https://github.com/myuhe/org-gcal.el">org-gcal</a>. For the most part, I always have a terminal tab with the agenda up and refresh it periodically to have the latest appointments and task schedules and deadlines.
      </p>
    </div>
  </div>
  
  <div id="outline-container-orgeaaf198" class="outline-3">
    <h3 id="orgeaaf198">
      Journal
    </h3>
    
    <div id="text-orgeaaf198" class="outline-text-3">
      <p>
        Great practice and excellent substitute for therapy. Store thoughts, experiences and ideas. Highly recommended. I use the wonderful <a href="https://github.com/bastibe/org-journal">org-journal</a> package for this.
      </p>
    </div>
  </div>
  
  <div id="outline-container-org6b43b48" class="outline-3">
    <h3 id="org6b43b48">
      Blogging
    </h3>
    
    <div id="text-org6b43b48" class="outline-text-3">
      <p>
        I write this blog using <code>org-mode</code> 🙂 (thanks <a href="https://github.com/org2blog/org2blog">org2blog</a>). I can&#8217;t imagine writing it in any other way.
      </p>
    </div>
  </div>
  
  <div id="outline-container-org4642fb0" class="outline-3">
    <h3 id="org4642fb0">
      RSS List
    </h3>
    
    <div id="text-org4642fb0" class="outline-text-3">
      <p>
        I just replaced my RSS reader of choice with <a href="https://github.com/skeeto/elfeed">elfeed</a>. It&#8217;s a simple emacs-based RSS reader. Fast, no frills and straightforward. To keep a list of my RSS feeds, I imported an OPML into <a href="https://github.com/remyhonig/elfeed-org">elfeed-org</a> and now keep all my RSS feeds in one beautiful org-file that I can easily manage and sync.
      </p>
      
      <p>
        There&#8217;s plenty of reasons to use <code>org-mode</code>. I have used it for email, but honestly, I have been unable to find a suitable workflow for it. Longform writing is something I would like to spend more time doing, and <code>org-mode</code> seems like a great platform to get started with to do it.
      </p>
    </div>
  </div>
</div>

<div id="outline-container-orgdc25963" class="outline-2">
  <h2 id="orgdc25963">
    My configuration
  </h2>
  
  <div id="text-orgdc25963" class="outline-text-2">
    <pre class="example">(setenv "GPG_AGENT_INFO" nil)
(setq epg-gpg-program "/usr/local/bin/gpg2")
(require 'epa-file)

(require 'password-cache)

(setq password-cache-expiry (* 15 60))
(setq epa-file-cache-passphrase-for-symmetric-encryption t)
</pre>
    
    <p>
      First of all, I load GPG for encryption/decryption of gpg files. I set a generous expiration because this is my work desktop and I always keep it locked.
    </p>
    
    <pre class="example">(require 'org-install)
(package-initialize)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cr" 'org-gcal-sync)
</pre>
    
    <p>
      I load <code>org-mode</code> and set the shortcuts to store links (it&#8217;s easier this way for me ?), capture (for agenda, work TODO, etc) and pull up the agenda.
    </p>
    
    <pre class="example">(setq org-directory "~/Documents/org/")
(setq org-default-notes-file "~/Documents/org/scrapbook.gpg")
(setq org-agenda-files (list "~/Documents/org/todo.gpg" "~/Documents/org/work_cal.org" "~/Documents/org/personal_cal.org"))
</pre>
    
    <p>
      Here I&#8217;m setting the directory structure. <code>org-directory</code> sets the default <code>org-mode</code> directory for file storage. Notes are created with <code>org-default-notes-file</code>, and <code>org-agenda-files</code> lists all the files loaded by default in the Agenda.
    </p>
    
    <pre class="example">(add-hook 'org-mode-hook #'(lambda ()
			     (visual-line-mode)
			     (org-indent-mode)))
(add-hook 'org-mode-hook #'toggle-word-wrap)

(defun my/org-mode-hook ()
  "My `org-mode' hook"
  (set-face-attribute 'org-document-info-keyword nil :foreground "yellow")
  (set-face-attribute 'org-document-info nil :foreground "cornflower blue")
  (set-face-attribute 'org-document-title nil :foreground "cornflower blue"))
(add-hook 'org-mode-hook 'my/org-mode-hook)
</pre>
    
    <p>
      Some color tweaks and line-wrapping. <code>org-mode</code> doesn&#8217;t wrap lines by default, but that has an easy fix.
    </p>
    
    <pre class="example">(setq org-todo-keywords
	  '((sequence "TODO(t)" "PENDING(p!)" "WAIT(w@)" "VERIFY(v)" "|" "DONE(d!)" "CANCELED(c@)")
	     (sequence "REPORT(r@)" "BUG(b@)" "KNOWNCAUSE(k@)" "|" "FIXED(f!)")))

(global-set-key (kbd "C-c s") 
		(lambda () (interactive) (find-file "~/Documents/org/scrapbook.gpg")))
(global-set-key (kbd "C-c w") 
		(lambda () (interactive) (find-file "~/Documents/org/todo.gpg")))

(setq org-log-done 'time)
(setq org-list-allow-alphabetical t)
</pre>
    
    <p>
      Define files for notes and for the to-do list. Here we also define the to-do sequences and indicate whether I want them timestamped (!) or timestamped and with a comment (@).
    </p>
    
    <pre class="example">(setq org-capture-templates
'(("n" "Personal Note" entry (file "~/Documents/org/scrapbook.gpg")
   "* PERSONAL NOTE %?\n%U\n" :empty-lines 1)
  ("w" "Work Note" entry (file "~/Documents/org/scrapbook.gpg")
   "* WORK NOTE %?\n%U\n" :empty-lines 1)
  ("j" "Journal" entry
   (file+datetree "~/Documents/org/journal.gpg")
   "**** %U%?\n%a" :tree-type week))
)
</pre>
    
    <p>
      Define the capture modes. I only have personal and work notes and journal capture.
    </p>
    
    <pre class="example">(eval-after-load "org"
  '(require 'ox-md nil t))
</pre>
    
    <p>
      Markdown export. We use markdown at work a lot. It makes my life easier if I have direct conversion to markdown.
    </p>
    
    <pre class="example">(setq org-agenda-span 4)
</pre>
    
    <p>
      <code>org-agenda</code> will only load the next 4 days. I don&#8217;t need any more than that.
    </p>
    
    <pre class="example">(require 'org2blog-autoloads)
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
;; &lt;language&gt; &lt;your-code&gt; #+END_SRC code blocks.
(setq org-src-fontify-natively t)
</pre>
    
    <p>
      For <code>org-2blog</code> We begin by loading it and <code>.netrc</code>. In my case, I&#8217;m using <code>.authinfo</code> that I keep encrypted as well. It stores my blog credentials. Since I only have one blog, I just add it as <code>arenzanaorg</code> to the wordpress blog list, set some defaults, and then set some source code defaults. I got most of this configuration from <a href="http://blog.binchen.org/posts/how-to-use-org2blog-effectively-as-a-programmer.html">here</a>. Great resource!
    </p>
    
    <pre class="example">(require 'org-gcal)
(load-library "~/.gcal.el.gpg")
(setq org-gcal-file-alist '(("iarenzana@gmail.com" .  "~/Documents/org/personal_cal.org")
("iarenzana@indigital.net" . "~/Documents/org/work_cal.org")))
</pre>
    
    <p>
      <img loading="lazy" class="alignnone size-full wp-image-385" src="https://arenzana.org/wp-content/uploads/2019/04/Screen-Shot-2019-04-03-at-11.30.34-AM.png" alt="" width="919" height="210" />
    </p>
    
    <p>
      <code>org-gcal</code> is the package I use to pull <a href="https://calendar.google.com">Google Calendar</a> data into Emacs and, ultimately, <code>org-agenda</code>. Earlier in the set up I created a shortcut for <code>org-gcal-sync</code> to update the calendars on demand. After that, I just press <code>r</code> in <code>org-agenda</code> to refresh the buffer and the new events show up . In order to not publish API keys to any repository, I keep this information in a <code>.gcal.el.gpg</code> file stored in my home directory. This is what the structure of that file looks like:
    </p>
    
    <pre class="example">;; -*- epa-file-encrypt-to: ("user@example.com") -*-

(setq org-gcal-client-id "clientid"
      org-gcal-client-secret "secretkey")
</pre>
    
    <p>
      Make sure you substitute the email address with your PGP key&#8217;s email and both <code>clientid</code> and <code>secretid</code> with the ones generated at <a href="https://cloud.google.com/">Google Cloud</a> for your calendar. To do this, create a new oauth key pair.
    </p>
  </div>
</div>

<div id="outline-container-orgdf6a609" class="outline-2">
  <h2 id="orgdf6a609">
    Caveats
  </h2>
  
  <div id="text-orgdf6a609" class="outline-text-2">
    <p>
      There&#8217;s a few things that still bother me that I want to tackle. First of them is the <code>yellow</code> output of my blog&#8217;s HTML code source. I&#8217;m disabling colors by not specifying <code>emacs-lisp</code> as the language, but this is a bad work around. I have been unable to correctly format the HTML template for this, so I will need to keep researching.
    </p>
    
    <p>
      Also, every time I open emacs I&#8217;m prompted for <code>.gcal.el.gpg</code>&#8216;s password. I&#8217;d like to delay this until I call <code>org-gcal</code>.
    </p>
  </div>
</div>

<div id="outline-container-org97b4c5f" class="outline-2">
  <h2 id="org97b4c5f">
    Summary
  </h2>
  
  <div id="text-org97b4c5f" class="outline-text-2">
    <p>
      I know I&#8217;ve flown over my <code>org-mode</code> set up, but going in depth would take a lot more posts (which I may write). For now this is a short introduction to how I use the package and some of the possibilities that might bring ideas on how to improve your workflows.
    </p>
  </div>
</div>