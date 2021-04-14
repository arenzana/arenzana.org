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

<div id="outline-container-org79568f0" class="outline-2">
  <h2 id="org79568f0">
    Find a Mode!
  </h2>
  
  <div id="text-org79568f0" class="outline-text-2">
    <p>
      The first thing I had to do was find a major mode for Go on emacs. It didn&#8217;t take me long to find <a href="https://github.com/dominikh/go-mode.el">go-mode</a>. Installation is not hard, as it&#8217;s available as a package in the MELPA repository. A simple <code>M-x package-install go-mode</code> sufficed. Configuring it was a bit harder.
    </p>
  </div>
</div>

<div id="outline-container-orge4ed6f7" class="outline-2">
  <h2 id="orge4ed6f7">
    Configuration
  </h2>
  
  <div id="text-orge4ed6f7" class="outline-text-2">
    <p>
      This is my <code>.emacs</code> configuration for Go.
    </p>
    
    <div class="org-src-container">
      <pre class="src src-emacs-lisp"><span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Load Go-specific language syntax</span>
<span style="color: #ff0000;">;;</span><span style="color: #ff0000;">For gocode use https://github.com/mdempsky/gocode</span>

<span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Custom Compile Command</span>
(<span style="color: #a020f0;">defun</span> <span style="color: #0000ff;">go-mode-setup</span> ()
  (linum-mode 1)
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump)
  (<span style="color: #a020f0;">setq</span> compile-command <span style="color: #ffff00;">"echo Building... && go build -v && echo Testing... && go test -v && echo Linter... && golint"</span>)
  (<span style="color: #a020f0;">setq</span> compilation-read-command nil)
  <span style="color: #ff0000;">;;  </span><span style="color: #ff0000;">(define-key (current-local-map) "\C-c\C-c" 'compile)</span>
  (local-set-key (kbd <span style="color: #ffff00;">"M-,"</span>) 'compile)
(add-hook 'go-mode-hook 'go-mode-setup)

<span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Load auto-complete</span>
(ac-config-default)
(<span style="color: #a020f0;">require</span> '<span style="color: #008b8b;">auto-complete-config</span>)
(<span style="color: #a020f0;">require</span> '<span style="color: #008b8b;">go-autocomplete</span>)

<span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Go rename</span>

(<span style="color: #a020f0;">require</span> '<span style="color: #008b8b;">go-rename</span>)

<span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Configure golint</span>
(add-to-list 'load-path (concat (getenv <span style="color: #ffff00;">"GOPATH"</span>)  <span style="color: #ffff00;">"/src/github.com/golang/lint/misc/emacs"</span>))
(<span style="color: #a020f0;">require</span> '<span style="color: #008b8b;">golint</span>)

<span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Smaller compilation buffer</span>
(<span style="color: #a020f0;">setq</span> compilation-window-height 14)
(<span style="color: #a020f0;">defun</span> <span style="color: #0000ff;">my-compilation-hook</span> ()
  (<span style="color: #a020f0;">when</span> (not (get-buffer-window <span style="color: #ffff00;">"*compilation*"</span>))
    (<span style="color: #a020f0;">save-selected-window</span>
      (<span style="color: #a020f0;">save-excursion</span>
        (<span style="color: #a020f0;">let*</span> ((w (split-window-vertically))
               (h (window-height w)))
          (select-window w)
          (switch-to-buffer <span style="color: #ffff00;">"*compilation*"</span>)
          (shrink-window (- h compilation-window-height)))))))
(add-hook 'compilation-mode-hook 'my-compilation-hook)

<span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Other Key bindings</span>
(global-set-key (kbd <span style="color: #ffff00;">"C-c C-c"</span>) 'comment-or-uncomment-region)

<span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Compilation autoscroll</span>
(<span style="color: #a020f0;">setq</span> compilation-scroll-output t)
</pre>
    </div>
  </div>
</div>

<div id="outline-container-org67de92c" class="outline-2">
  <h2 id="org67de92c">
    The Basics
  </h2>
  
  <div id="text-org67de92c" class="outline-text-2">
    <p>
      That&#8217;s a lot! Yeah, I know, but before you freak out, I&#8217;ll give you a run down of what each block is for (although the comments should help a lot).
    </p>
    
    <div class="org-src-container">
      <pre class="src src-emacs-lisp"><span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Load Go-specific language syntax</span>
<span style="color: #ff0000;">;;</span><span style="color: #ff0000;">For gocode use https://github.com/mdempsky/gocode</span>

<span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Goimports</span>
(<span style="color: #a020f0;">defun</span> <span style="color: #0000ff;">go-mode-setup</span> ()
  (go-eldoc-setup)
  (add-hook 'before-save-hook 'gofmt-before-save)) 
  (<span style="color: #a020f0;">setq</span> gofmt-command <span style="color: #ffff00;">"goimports"</span>)
  (add-hook 'before-save-hook 'gofmt-before-save))
(add-hook 'go-mode-hook 'go-mode-setup)
</pre>
    </div>
    
    <p>
      This block enables <code>go-mode</code> and makes sure it runs <code>gofmt</code> before saving. <code>gofmt</code> allows our code to be nice and tidy and to let <code>go-mode</code> take care of importing the required packages. Nifty, huh? Makes coding nicer.
    </p>
  </div>
</div>

<div id="outline-container-orge5d5bc7" class="outline-2">
  <h2 id="orge5d5bc7">
    Making life even easier
  </h2>
  
  <div id="text-orge5d5bc7" class="outline-text-2">
    <p>
      Some extra elements to make our lives easier. Not necessary, but nice to have.
    </p>
    
    <div class="org-src-container">
      <pre class="src src-emacs-lisp"><span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Custom Compile Command</span>
(<span style="color: #a020f0;">defun</span> <span style="color: #0000ff;">go-mode-setup</span> ()
  <span style="color: #ff0000;">;;  </span><span style="color: #ff0000;">(setq compile-command "go build -v && go test -v && go vet && golint && errcheck")</span>
  (linum-mode 1)
  (<span style="color: #a020f0;">setq</span> compile-command <span style="color: #ffff00;">"echo Building... && go build -v && echo Testing... && go test -v && echo Linter... && golint"</span>)
  (<span style="color: #a020f0;">setq</span> compilation-read-command nil)
  <span style="color: #ff0000;">;;  </span><span style="color: #ff0000;">(define-key (current-local-map) "\C-c\C-c" 'compile)</span>
  (local-set-key (kbd <span style="color: #ffff00;">"M-,"</span>) 'compile)
(add-hook 'go-mode-hook 'go-mode-setup)
</pre>
    </div>
    
    <p>
      This is a good one. Here I&#8217;m configuring <code>M-,</code> (Escape key + comma) to run <code>go build</code>, <code>go test</code>, and <code>golint</code>. Extremely simple way make sure our code compiles.
    </p>
  </div>
</div>

<div id="outline-container-org409f01f" class="outline-2">
  <h2 id="org409f01f">
    Autocomplete and Linting
  </h2>
  
  <div id="text-org409f01f" class="outline-text-2">
    <div class="org-src-container">
      <pre class="src src-emacs-lisp"><span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Load auto-complete</span>
(ac-config-default)
(<span style="color: #a020f0;">require</span> '<span style="color: #008b8b;">auto-complete-config</span>)
(<span style="color: #a020f0;">require</span> '<span style="color: #008b8b;">go-autocomplete</span>)

<span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Go rename</span>

(<span style="color: #a020f0;">require</span> '<span style="color: #008b8b;">go-rename</span>)

<span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Configure golint</span>
(add-to-list 'load-path (concat (getenv <span style="color: #ffff00;">"GOPATH"</span>)  <span style="color: #ffff00;">"/src/github.com/golang/lint/misc/emacs"</span>))
(<span style="color: #a020f0;">require</span> '<span style="color: #008b8b;">golint</span>)
</pre>
    </div>
    
    <p>
      Sets up <code>go-autocomplete</code> and <code>go-rename</code>. <code>go-rename</code> only is used if you want to do project-level renames. Just between us, I barely use it.
    </p>
    
    <p>
      The last block configures the path of the linter. Remember, Emacs is smart, but not <i>that</i> smart.
    </p>
  </div>
</div>

<div id="outline-container-org74f815d" class="outline-2">
  <h2 id="org74f815d">
    Beautify our editor
  </h2>
  
  <div id="text-org74f815d" class="outline-text-2">
    <div class="org-src-container">
      <pre class="src src-emacs-lisp"><span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Smaller compilation buffer</span>
(<span style="color: #a020f0;">setq</span> compilation-window-height 14)
(<span style="color: #a020f0;">defun</span> <span style="color: #0000ff;">my-compilation-hook</span> ()
  (<span style="color: #a020f0;">when</span> (not (get-buffer-window <span style="color: #ffff00;">"*compilation*"</span>))
    (<span style="color: #a020f0;">save-selected-window</span>
      (<span style="color: #a020f0;">save-excursion</span>
        (<span style="color: #a020f0;">let*</span> ((w (split-window-vertically))
               (h (window-height w)))
          (select-window w)
          (switch-to-buffer <span style="color: #ffff00;">"*compilation*"</span>)
          (shrink-window (- h compilation-window-height)))))))
(add-hook 'compilation-mode-hook 'my-compilation-hook)
</pre>
    </div>
    
    <p>
      All of this to make the compilation buffer smaller than a default buffer.
    </p>
    
    <div class="org-src-container">
      <pre class="src src-emacs-lisp"><span style="color: #ff0000;">;;</span><span style="color: #ff0000;">Other Key bindings</span>
(global-set-key (kbd <span style="color: #ffff00;">"C-c C-c"</span>) 'comment-or-uncomment-region)
</pre>
    </div>
    
    <p>
      How about a simple command to comment out big blocks of code? <code>C-c C-c</code>. Also, <code>compilation-scroll-output</code> simply scrolls the compilation buffer all the way to the end.
    </p>
  </div>
</div>

<div id="outline-container-orgd5a8385" class="outline-2">
  <h2 id="orgd5a8385">
    What&#8217;s left?
  </h2>
  
  <div id="text-orgd5a8385" class="outline-text-2">
    <p>
      This is my current set up. It works really well for my needs, but it might not be yours. Something I&#8217;ll work on is to integrate <code>delve</code> (golang debugger) into the editor, but I suppose I&#8217;m quite old school.
    </p>
    
    <p>
      I also have <a href="https://magit.vc/">Magit</a> integrated into my workflow, but that&#8217;s a topic for a different episode. To be honest, I don&#8217;t miss anything from Sublime (or Atom or MS Code), plus it already makes use of my favorite editor. A simple <code>.emacs</code> file gives me all the customization that I need and I know I always have MY set up everywhere.
    </p>
  </div>
</div>