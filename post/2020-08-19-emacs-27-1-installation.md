---
author: iarenzana
categories:
- emacs
date: "2020-08-19T01:30:00Z"
guid: https://arenzana.org/?p=433
id: 433
tags:
- emacs
- tech
title: Emacs 27.1 Installation
url: /2020/08/emacs-27-1-installation/
---
This is for you as much as this is for me, since I want to remember some stuff I do and the blog sometimes serves as a public knowledge base. 

Regarding 27.1, there&#8217;s plenty of great resources [here](https://www.masteringemacs.org/article/whats-new-in-emacs-27-1) and [here](https://emacsredux.com/blog/2020/08/13/emacs-27-1/), so I won&#8217;t go over them. 

Simple installation considering you have Development Tools and TLS libraries installed for your distro: 

<div class="org-src-container">
  <label class="org-src-name"><em></em></label></p> 
  
  <pre class="src src-sh" id="nil">wget http://ftp.gnu.org/gnu/emacs/emacs-27.1.tar.gz
./configure --with-json
make
make install
</pre>
</div>

I&#8217;m only adding native JSON support since it&#8217;s the number one (or [number two](https://arenzana.org/2019/12/emacs-go-mode-revisited/) after language servers) feature in Emacs 27. Since the loading order in 27 changes, I&#8217;m adding support for previous versions with the following in my `.emacs.org` file: 

<div class="org-src-container">
  <label class="org-src-name"><em></em></label></p> 
  
  <pre class="src src-emacs-lisp" id="nil">(<span style="color: #a020f0;">when</span> (&lt; emacs-major-version 27)
  (package-initialize))
</pre>
</div>

Additionally, I had to run `go get golang.org/x/tools/gopls@latest` in order for gopls to not crash. Other than that, it seems like this version hasn&#8217;t broken any other elements of my set up; but it might still be a little bit too early to tell!