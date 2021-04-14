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

<div id="outline-container-orgdd23b5e" class="outline-2">
  <h2 id="orgdd23b5e">
    Temporarily enable an input method
  </h2>
  
  <div id="text-orgdd23b5e" class="outline-text-2">
    <p>
      By default, Emacs doesn&#8217;t have an <a href="https://www.emacswiki.org/emacs/InputMethods">input method</a>. Which means that special characters will not be very convenient to insert. To be able to switch languages, you will need to set an input method. In my case, <code>latin-1-prefix</code> will be the chosen locale. To do this, run <code>M-x set-input-method</code> and then choose the locale. This will most likely affect your editing mode when special characters are no longer needed, therefore to disable the input method, issue <code>M-x toggle-input-method</code> or just <code>C-\</code>.
    </p>
  </div>
</div>

<div id="outline-container-orga88a543" class="outline-2">
  <h2 id="orga88a543">
    Permanently enable an input method
  </h2>
  
  <div id="text-orga88a543" class="outline-text-2">
    <p>
      This all works well when you want to write using a different locale temporarily, but it doesn&#8217;t work well when you want to have an input method enabled every time you&#8217;re in a mode. For instance, if I want to type text in Spanish every time I&#8217;m in <code>org-mode</code>, I would need to issue the <code>M-x set-input-method</code> command every time I open this mode. This is obviously an inconvenience, and the Emacs life is all about making the editor just the way you want it.
    </p>
    
    <p>
      To permanently set an input method for a mode, we will need to add something like this to our init file.
    </p>
    
    <div class="org-src-container">
      <pre class="src src-elisp"><span style="color: #ff0000;">;; </span><span style="color: #ff0000;">Set latin-1-prefix as default locale</span>

(<span style="color: #a020f0;">setq</span> default-input-method <span style="color: #ffff00;">"latin-1-prefix"</span>)
(<span style="color: #a020f0;">defun</span> <span style="color: #0000ff;">activate-default-input-method</span> ()
  (<span style="color: #a020f0;">interactive</span>)
  (activate-input-method default-input-method))
(add-hook 'org-mode-hook 'activate-default-input-method)
</pre>
    </div>
    
    <p>
      Here we are indicating that <code>latin-1-prefix</code> will be our new <code>default-input-method</code> and the function will enable this method for <code>org-mode</code>. This way, every time we open <code>org-mode</code>, I will be ready to type in Spanish. This is a white-listing approach, where we select the modes that will have an input method applied, but we can also take the opposite approach. A blacklist method approach will enable an input method for ALL modes except for the ones indicated. This was the first approach I took, but soon realized that I have too many key bindings that would be disabled by the special character keys. Here&#8217;s an example of the blacklist approach.
    </p>
    
    <div class="org-src-container">
      <pre class="src src-elisp"><span style="color: #ff0000;">;; </span><span style="color: #ff0000;">Set latin-1-prefix as default locale</span>

(<span style="color: #a020f0;">setq</span> default-input-method <span style="color: #ffff00;">"latin-1-prefix"</span>)
(<span style="color: #a020f0;">defvar</span> <span style="color: #a0522d;">use-default-input-method</span> t)
(make-variable-buffer-local 'use-default-input-method)
(<span style="color: #a020f0;">defun</span> <span style="color: #0000ff;">activate-default-input-method</span> ()
  (<span style="color: #a020f0;">interactive</span>)
  (<span style="color: #a020f0;">if</span> use-default-input-method
      (activate-input-method default-input-method)
    (inactivate-input-method)))
(add-hook 'after-change-major-mode-hook 'activate-default-input-method)
(add-hook 'minibuffer-setup-hook 'activate-default-input-method)
(<span style="color: #a020f0;">defun</span> <span style="color: #0000ff;">inactivate-default-input-method</span> ()
  (<span style="color: #a020f0;">setq</span> use-default-input-method nil))
<span style="color: #ff0000;">;; </span><span style="color: #ff0000;">Blacklisted modes</span>
(add-hook 'c-mode-hook 'inactivate-default-input-method)
(add-hook 'go-mode-hook 'inactivate-default-input-method)
(add-hook 'markdown-mode-hook 'inactivate-default-input-method)
(add-hook 'sh-mode-hook 'inactivate-default-input-method)
</pre>
    </div>
    
    <p>
      This way, we are enabling <code>latin-1-prefix</code> as the default input method for everything except for <code>c-mode</code>, <code>go-mode</code>, <code>markdown-mode</code>, and <code>sh-mode</code>. While these cover many of the options that I use on a regular basis, <code>dired</code> and other modes that I use very frequently would still be screwed up and the blacklist would grow too large. Whitelisting <code>org-mode</code> is enough for now. I might consider <code>message-mode</code> for writing emails in Spanish, which I seldom do, or <code>text-mode</code> (rarely used as well).
    </p>
  </div>
</div>

<div id="outline-container-org7564215" class="outline-2">
  <h2 id="org7564215">
    Summary
  </h2>
  
  <div id="text-org7564215" class="outline-text-2">
    <p>
      Overall I feel very happy with this set up, but still needs some minor tweaking. As always, Emacs&#8217; flexibility makes customization extremely powerful. Easily overwhelming. Just like everything we&#8217;re doing, try settings out, keep your <code>.emacs</code> in source control and make changes without fear. Tweak as needed. Repeat.
    </p>
  </div>
</div>