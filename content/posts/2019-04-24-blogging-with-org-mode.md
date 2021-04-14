---
author: iarenzana
categories:
- emacs
date: "2019-04-24T20:13:00Z"
guid: https://arenzana.org/?p=388
id: 388
show_author_box:
- "0"
tags:
- blogging
- emacs
- tech
title: Blogging with org-mode
url: /2019/04/blogging-with-org-mode/
---

## Wait, what?

My coworker makes infinite fun of me because I do everything in Emacs. He&#8217;s a proficient Vim user and uses it as a text editor like a master. Emacs, however, is almost a full operating system for me. Even though I haven&#8217;t figured out how to do video editing in Emacs (?), blogging is a task that&#8217;s possible to do with it.

I run a self-hosted <a href="https://wordpress.org/">WordPress</a> instance on <a href="https://www.scaleway.com/en/">Scaleway</a>. This is an affordable set up that gives me extreme flexibility.


## The setup

As I described on my <a href="https://arenzana.org/2019/04/emacs-org-mode/">previous post</a>, I use <a href="https://github.com/org2blog/org2blog">org2blog</a> as the blogging package to post to WordPress. I have the following block on my `.emacs` file.

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

Naturally, I don&#8217;t post my credentials as part of my `.emacs` since I keep it under version control. Instead, I store it under `${HOME}/.authinfo.gpg` like this:

{{< highlight emacs-lisp >}}
machine arenzana.org
  login admin
  password "mypassword"
{{< / highlight >}}

The Lisp block creates a new blog instance called `arenzanaorg` (in case you want to have more than one blog). Include the XML RPC endpoint, credentials, and some defaults. In addition to this, I enable code highlighting. This is actually not working very well for me, because the CSS uses a very bright yellow color to represent strings for the `emacs-lisp` language (as you can see on previous posts). Instead, I&#8217;m just using the `#+BEGIN_SRC    #+END_SRC` blocks (without specifying the language) to post code blocks. This gives grey blocks, but at least they&#8217;re readable. I&#8217;ve tried different options, without success. I&#8217;m not a front end developer, so to be honest, I&#8217;ve struggled working with all the CSS options for the HTML export option of org2blog.

## The Workflow

The workflow is fairly simple for what I do. `M-x org2blog/wp-new-entry`. The first time you call this, it will prompt you to log in. Make sure you do so. Then it will open an `Org` buffer where you can edit the defaults and type away.

Once I&#8217;m done, I issue `M-x org2blog/wp-post-buffer`. This will upload the draft and give me the option to display the preview, where I can see what things will look like prior to publishing. After I&#8217;m happy with the final edits, I issue `M-x org2blog/wp-post-bufffer-and-publish`. This will post directly to WordPress.

## Caveats

As I described above, syntax highlighting for emacs-lisp is not great and it doesn&#8217;t support Go (my language of choice).

Attaching images to a blog post is something I do after the fact, once the draft is up. I haven&#8217;t figured out a good way to upload and link images to a post straight from org2blog.
