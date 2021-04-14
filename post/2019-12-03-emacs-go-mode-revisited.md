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
date: "2019-12-03T08:49:00Z"
guid: https://arenzana.org/?p=403
id: 403
show_author_box:
- "0"
tags:
- emacs
- golang
- tech
title: Emacs Go Mode &#8211; Revisited
url: /2019/12/emacs-go-mode-revisited/
---
A few months ago [I went over](https://arenzana.org/2019/01/emacs-go-mode/) how to set up Emacs for Go development. Since then, I have honestly not changed a single thing about it. Until this week.

<div id="outline-container-orgdbd751c" class="outline-2">
  <h2 id="orgdbd751c">
    Background
  </h2>
  
  <div id="text-orgdbd751c" class="outline-text-2">
    <p>
      Here&#8217;s the thing. Something I have changed too much over the last few months has been the vendoring mechanism I use for my Go projects. From <a href="https://github.com/Masterminds/glide">Glide</a>, I moved to <a href="https://github.com/golang/dep">go dep</a>, and a couple of months ago, I started the migration to the <a href="https://github.com/golang/go/wiki/Modules">Go Modules</a>, Golang&#8217;s potential long-term solution to the package management mess the community has been living with since the inception of the language 10 years ago (<a href="https://blog.golang.org/10years">Happy Birthday Go!</a>).
    </p>
    
    <p>
      Go Modules changes a lot of things about the taxonomy of your projects: vendor management, GOPATH, <code>go get</code>, etc. Just like me and my vendor management journey, <code>gomode</code> has also gone through several iterations from <a href="https://github.com/nsf/gocode">here</a>, to <a href="https://github.com/mdempsky/gocode">here</a>, and <a href="https://github.com/stamblerre/gocode">here</a>.
    </p>
    
    <p>
      It was time to start looking at something else with more long term support.
    </p>
  </div>
</div>

<div id="outline-container-org5750378" class="outline-2">
  <h2 id="org5750378">
    LSP time
  </h2>
  
  <div id="text-org5750378" class="outline-text-2">
    <p>
      LSP (Language Server Provider) promises to do away with all these issues by implementing a &#8220;driver&#8221; with a common editor interface and adapting to the languages as they evolve. <a href="https://www.youtube.com/watch?v=5Re6BHEOT_k">Rebecca Stambler&#8217;s &#8220;Go, please stop breaking my editor&#8221;</a> is a must-watch if you&#8217;re interested in the topic.
    </p>
    
    <p>
      To work on Go using emacs, the most logical recipe would be <a href="https://github.com/emacs-lsp/lsp-mode">lsp-mode</a>, <a href="https://github.com/golang/tools/blob/master/gopls/README.md">gopls</a>, and <a href="https://github.com/dominikh/go-mode.el">go-mode</a>. <code>gopls</code> is the LSP-compatible language server, <code>lsp-mode</code> is the Emacs interface for LSP servers, and <code>go-mode</code> is, well, the major mode for Go (discussed <a href="https://arenzana.org/2019/01/emacs-go-mode/">in my previous article</a>).
    </p>
  </div>
</div>

<div id="outline-container-orgbc979e0" class="outline-2">
  <h2 id="orgbc979e0">
    Go, please
  </h2>
  
  <div id="text-orgbc979e0" class="outline-text-2">
    <p>
      In the video (May 2019), Rebecca points out that <code>gopls</code> is still in alpha and warns us to proceed with caution. Currently, (December 2019) it feels more like a beta, so not too bad, but still not perfect. <code>gopls</code> is, however, the future for Emacs to become a solid Golang editor. This is because it&#8217;s the only language tool (beside&#8217;s Rebecca&#8217;s <code>gocode</code> that&#8217;s in maintenance mode) that fully supports Go modules that is in active development.
    </p>
    
    <p>
      All I had to do to install it was this:
    </p>
    
    <div class="org-src-container">
      <pre id="nil" class="src src-bash">go get golang.org/x/tools/gopls@latest
</pre>
    </div>
    
    <p>
      It&#8217;s important to check out the latest version since the tool is evolving quite quickly right now.
    </p>
    
    <p>
      What happens in the editor is that Emacs spawns an instance of the server when <code>go-mode</code> is enabled on a buffer. After this, <code>lsp-mode</code> will attempt to connect to it. The advantage of using a server rather than a command is that it&#8217;s much quicker to respond and interface with Emacs (it does feel snappier once the server comes up, which is also fairly quick). The disadvantages are the security concerns of running a server on a laptop; but to be fair, this is not supposed to be a long-running/permanent process.
    </p>
    
    <p>
      On my Emacs config, I just added the following lines:
    </p>
    
    <pre id="nil" class="example">(setq lsp-gopls-staticcheck t)
(setq lsp-eldoc-render-all t)
(setq lsp-gopls-complete-unimported t)
</pre>
    
    <p>
      I just wanted those elements to be active, but feel free to edit to taste.
    </p>
  </div>
</div>

<div id="outline-container-org8b8ab03" class="outline-2">
  <h2 id="org8b8ab03">
    lsp-mode
  </h2>
  
  <div id="text-org8b8ab03" class="outline-text-2">
    <p>
      <code>lsp-mode</code> will need to be added to our Emacs set up. I copied most of this from the <code>gopls</code> + <code>lsp-mode</code> set up guides adjusting it to my needs and adding a couple of things.
    </p>
    
    <pre id="nil" class="example">(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

;;Set up before-save hooks to format buffer and add/delete imports.
;;Make sure you don't have other gofmt/goimports hooks enabled.

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;;Optional - provides fancier overlays.

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :init
)

;;Company mode is a standard completion package that works well with lsp-mode.
;;company-lsp integrates company mode completion with lsp-mode.
;;completion-at-point also works out of the box but doesn't support snippets.

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

(use-package company-lsp
  :ensure t
  :commands company-lsp)

;;Optional - provides snippet support.

(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

;;lsp-ui-doc-enable is false because I don't like the popover that shows up on the right
;;I'll change it if I want it back


(setq lsp-ui-doc-enable nil
      lsp-ui-peek-enable t
      lsp-ui-sideline-enable t
      lsp-ui-imenu-enable t
      lsp-ui-flycheck-enable t)

</pre>
    
    <p>
      Here, I:
    </p>
    
    <ol class="org-ol">
      <li>
        Enable <code>lsp-mode</code>.
      </li>
      <li>
        Add hooks for package imports and buffer formatting on save.
      </li>
      <li>
        Enable <code>lsp-ui</code> (to display <code>go-eldoc</code> info, etc).
      </li>
      <li>
        Company for overlays.
      </li>
      <li>
        <code>yasnippet</code> for snippet support.
      </li>
      <li>
        Some options for <code>lsp-ui</code>.
      </li>
    </ol>
    
    <p>
      In the options I disabled <code>lsp-ui-doc-enable</code> because it displayed docs on both the mini buffer and on an overlay located to the right of the buffer. I found it too distracting and decided to disable the overlay and leave the mini buffer help.
    </p>
  </div>
</div>

<div id="outline-container-org8581794" class="outline-2">
  <h2 id="org8581794">
    Old Go Mode
  </h2>
  
  <div id="text-org8581794" class="outline-text-2">
    <p>
      So what&#8217;s left of my original Go mode configuration? Well, the custom compilation stuff, line numbers, etc are still there:
    </p>
    
    <pre id="nil" class="example">(defun custom-go-mode ()
  (display-line-numbers-mode 1))

(use-package go-mode
:defer t
:ensure t
:mode ("\\.go\\'" . go-mode)
:init
  (setq compile-command "echo Building... && go build -v && echo Testing... && go test -v && echo Linter... && golint")  
  (setq compilation-read-command nil)
  (add-hook 'go-mode-hook 'custom-go-mode)
:bind (("M-," . compile)
("M-." . godef-jump)))

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

(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
(setq compilation-scroll-output t)
</pre>
    
    <p>
      I&#8217;m not calling any of the goimports, gocode, etc as I used to, since <code>gopls</code> takes care of it all.
    </p>
  </div>
</div>

<div id="outline-container-org449d788" class="outline-2">
  <h2 id="org449d788">
    Summary
  </h2>
  
  <div id="text-org449d788" class="outline-text-2">
    <p>
      Besides speed, there&#8217;s not a whole lot of difference between my previous and my current setups, really. The real advantage I see is that I&#8217;m future-proofing my setup by adopting officially-supported procedures. Just like going to Go Modules: my workflow is not improved, but this seems to be the direction the community is going and it will be easier for me to adopt it now than in the future.
    </p>
  </div>
</div>

<div id="outline-container-orgccff095" class="outline-2">
  <h2 id="orgccff095">
    Caveats
  </h2>
  
  <div id="text-orgccff095" class="outline-text-2">
    <p>
      The first time you open a <code>.go</code> file, you will be prompted for the root of the project. It will find <code>go.mod</code> and suggest that directory as the root. It&#8217;s an extra step, but not a big deal. The interface makes it simple enough.
    </p>
    
    <p>
      This root path might have been the issue I initially hit where Emacs would color everything red on save. I couldn&#8217;t figure out what the problem was (I assumed it was a problem with my GOPATH and Modules), but removing my <code>.emacs.d</code> directory and having it recreated fixed it on my Mac. I never had the problem on my Fedora laptop.
    </p>
  </div>
</div>