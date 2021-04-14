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
date: "2020-06-25T07:36:44Z"
guid: https://arenzana.org/?p=425
id: 425
show_author_box:
- "0"
tags:
- emacs
- tech
title: Emacs Server &#8211; Why and why not?
url: /2020/06/emacs-server-why-and-why-not/
---
<div id="outline-container-orgef1a64a" class="outline-2">
  <h2 id="orgef1a64a">
    What
  </h2>
  
  <div id="text-orgef1a64a" class="outline-text-2">
    <p>
      Unknown to many of us, under the hood emacs was designed as a client/server architecture; which means, Emacs core runs as a daemon and you attach clients to it. Normally, we run both when we type <code>emacs</code>, but the execution of both the client and the server is transparent to the user. Before you attempt to do something fancy, this architecture is somewhat limited to localhost (1), which means that you can&#8217;t quite &#8220;remote into&#8221; an emacs running on a different host. In a world where we have <a href="https://github.com/tmux/tmux/wiki">tmux</a>, <a href="https://mosh.org/">mosh</a>, and other multiplexers and mobile connectivity technologies, there may not seem like there&#8217;s much room for running emacs as a server, but we will see some advantages to this approach.
    </p>
  </div>
</div>

<div id="outline-container-orgb4d835c" class="outline-2">
  <h2 id="orgb4d835c">
    Why and How
  </h2>
  
  <div id="text-orgb4d835c" class="outline-text-2">
    <p>
      I tend to use <code>tmux</code> as my multiplexer and I run a session on my laptop as soon as I start working. This session will only die when the machine goes down for a reboot or when shutting it down. The advantage of running tmux is (besides being able to upgrade iTerm without losing all my sessions) is that it keeps my brain trained to work on a remote box (I used to work in operations, being a sysadmin truly does something to your brain). Inside this tmux session, I run Emacs by typing <code>e</code>, which is an alias on my <code>~/.zshrc</code> as follows:
    </p>
    
    <pre id="nil" class="example">alias e="emacsclient -a '' -t" </pre>
    
    <p>
      You will notice that this alias uses a different command, <code>emacsclient</code>. Running this command will not run a full instance of Emacs, but will attempt to attach to a currently running session on localhost. If a server is not running, one will be started. You can also start Emacs as a daemon by running <code>emacs --daemon</code>. No client will be attached to it if you run it this way.
    </p>
    
    <p>
      If you have been following this blog, you will know how much I enjoy customizing Emacs. This passion for customization has driven my Emacs to take almost 3 seconds to start from cold (2). And even though I&#8217;ve done my best to improve the performance of this operation (remove unnecessary customization, use of <code>use-package</code>, some performance tuning, etc), there&#8217;s too much overhead at start time.
    </p>
  </div>
</div>

<figure id="attachment_428" aria-describedby="caption-attachment-428" style="width: 574px" class="wp-caption aligncenter"><img loading="lazy" src="https://arenzana.org/wp-content/uploads/2020/06/Screen-Shot-2020-06-24-at-21.21.48.png" class="size-full wp-image-428" alt=".emacs.org file" width="574" height="807" srcset="https://arenzana.org/wp-content/uploads/2020/06/Screen-Shot-2020-06-24-at-21.21.48.png 574w, https://arenzana.org/wp-content/uploads/2020/06/Screen-Shot-2020-06-24-at-21.21.48-213x300.png 213w, https://arenzana.org/wp-content/uploads/2020/06/Screen-Shot-2020-06-24-at-21.21.48-285x400.png 285w, https://arenzana.org/wp-content/uploads/2020/06/Screen-Shot-2020-06-24-at-21.21.48-220x310.png 220w, https://arenzana.org/wp-content/uploads/2020/06/Screen-Shot-2020-06-24-at-21.21.48-146x205.png 146w" sizes="(max-width: 574px) 100vw, 574px" /><figcaption id="caption-attachment-428" class="wp-caption-text">Highest level of my .emacs.org file</figcaption></figure>

<div id="outline-container-orgb4d835c" class="outline-2">
  <div id="text-orgb4d835c" class="outline-text-2">
    <p>
      By running a server first, my configuration gets loaded once, and when I attach the client, the configuration is loaded in memory. The operation of starting a client (what I actually interface with) is a matter of milliseconds. In addition to this when I close the client and reattach it, my Emacs still contains the same open buffers, running processes, etc. This means that, if you want to actually close Emacs and all of its open buffers, you need to make sure you close all of them <code>C-x C-B</code> and then <code>d</code> on every entry to close.
    </p>
  </div>
</div>

<div id="outline-container-org65c5001" class="outline-2">
  <h2 id="org65c5001">
    Conclusion
  </h2>
  
  <div id="text-org65c5001" class="outline-text-2">
    <p>
      The value I derive from this workflow resides in performance improvements. It saves me time and, why not, frustrations. It can be argued that value can be found from an Emacs-as-a-server architecture even if your <code>~/.emacs</code> is not too complex, but in my opinion, if that&#8217;s your situation, there&#8217;s no need to add any extra &#8220;complexity&#8221; associated to separating the client and server operations.
    </p>
    
    <p>
      Special thanks to the always great Irreal for <a href="https://irreal.org/blog/?p=4887%5C">this article</a> that served as a good starting guide.
    </p>
    
    <p>
      (1) While it&#8217;s technically possible to connect to a TCP socket, this is not meant to be a remote connectivity tool.
    </p>
    
    <p>
      (2) Listen, email loading, RSS, Twitter, journals, and development environments don&#8217;t come without a cost.
    </p>
  </div>
</div>