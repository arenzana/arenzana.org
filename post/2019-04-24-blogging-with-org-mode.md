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
<div id="outline-container-org0786e49" class="outline-2">
  <h2 id="org0786e49">
    Wait, what?
  </h2>
  
  <div id="text-org0786e49" class="outline-text-2">
    <p>
      My coworker makes infinite fun of me because I do everything in Emacs. He&#8217;s a proficient Vim user and uses it as a text editor like a master. Emacs, however, is almost a full operating system for me. Even though I haven&#8217;t figured out how to do video editing in Emacs (?), blogging is a task that&#8217;s possible to do with it.
    </p>
    
    <p>
      I run a self-hosted <a href="https://wordpress.org/">WordPress</a> instance on <a href="https://www.scaleway.com/en/">Scaleway</a>. This is an affordable set up that gives me extreme flexibility.
    </p>
  </div>
</div>

<div id="outline-container-org1ebca6e" class="outline-2">
  <h2 id="org1ebca6e">
    The setup
  </h2>
  
  <div id="text-org1ebca6e" class="outline-text-2">
    <p>
      As I described on my <a href="https://arenzana.org/2019/04/emacs-org-mode/">previous post</a>, I use <a href="https://github.com/org2blog/org2blog">org2blog</a> as the blogging package to post to WordPress. I have the following block on my <code>.emacs</code> file.
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
      Naturally, I don&#8217;t post my credentials as part of my <code>.emacs</code> since I keep it under version control. Instead, I store it under <code>${HOME}/.authinfo.gpg</code> like this:
    </p>
    
    <pre class="example">machine arenzana.org
  login admin
  password "mypassword"
</pre>
    
    <p>
      These credentials are called when loading the <code>netrc</code> package and <code>auth-source</code>.
    </p>
    
    <p>
      The Lisp block creates a new blog instance called <code>arenzanaorg</code> (in case you want to have more than one blog). Include the XML RPC endpoint, credentials, and some defaults. In addition to this, I enable code highlighting. This is actually not working very well for me, because the CSS uses a very bright yellow color to represent strings for the <code>emacs-lisp</code> language (as you can see on previous posts). Instead, I&#8217;m just using the <code>#+BEGIN_SRC    #+END_SRC</code> blocks (without specifying the language) to post code blocks. This gives grey blocks, but at least they&#8217;re readable. I&#8217;ve tried different options, without success. I&#8217;m not a front end developer, so to be honest, I&#8217;ve struggled working with all the CSS options for the HTML export option of org2blog.
    </p>
  </div>
</div>

<div id="outline-container-orgd68ef5e" class="outline-2">
  <h2 id="orgd68ef5e">
    The Workflow
  </h2>
  
  <div id="text-orgd68ef5e" class="outline-text-2">
    <p>
      The workflow is fairly simple for what I do. <code>M-x org2blog/wp-new-entry</code>. The first time you call this, it will prompt you to log in. Make sure you do so. Then it will open an <code>Org</code> buffer where you can edit the defaults and type away.
    </p>
    
    <p>
      Once I&#8217;m done, I issue <code>M-x org2blog/wp-post-buffer</code>. This will upload the draft and give me the option to display the preview, where I can see what things will look like prior to publishing. After I&#8217;m happy with the final edits, I issue <code>M-x org2blog/wp-post-bufffer-and-publish</code>. This will post directly to WordPress.
    </p>
  </div>
</div>

<div id="outline-container-orge93d316" class="outline-2">
  <h2 id="orge93d316">
    Caveats
  </h2>
  
  <div id="text-orge93d316" class="outline-text-2">
    <ul class="org-ul">
      <li>
        As I described above, syntax highlighting for emacs-lisp is not great and it doesn&#8217;t support Go (my language of choice).
      </li>
      <li>
        Attaching images to a blog post is something I do after the fact, once the draft is up. I haven&#8217;t figured out a good way to upload and link images to a post straight from org2blog.
      </li>
    </ul>
  </div>
</div>