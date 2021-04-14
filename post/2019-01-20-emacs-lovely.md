---
author: iarenzana
categories:
- emacs
date: "2019-01-20T20:19:00Z"
guid: https://arenzana.org/?p=342
id: 342
tags:
- devops
- emacs
- tech
title: Emacs, Lovely
url: /2019/01/emacs-lovely/
---
For the last few months I&#8217;ve been tinkering with Emacs at a deeper level. I got started with it at my first job as an intern 15 years ago and have not looked back ever since. To be completely honest, I don&#8217;t remember how I learned. All my colleagues used it and I got started with some basic modes thanks to them. I suppose I had better memory 15 years ago! 

For those who don&#8217;t know, Emacs is a text editor created by Richard Stallman, David Moon, and Guy Steele in 1976. It&#8217;s available for nearly every platform known to man and can be customized to infinity. A friend jokes about how if Emacs was an operating system, that&#8217;s the one I&#8217;d run. 

Reality is, to be able to get around Emacs you just need to learn a few things, such as dired commands, open, close buffer, save, search, etc. But it can go so much further! Did you know that you can find out the lunar phases with `M-x lunar-phases`? 

<div id="outline-container-org2f6414c" class="outline-2">
  <h2 id="org2f6414c">
    How Emacs works for me
  </h2>
  
  <div class="outline-text-2" id="text-org2f6414c">
    <p>
      Alright, fair enough, the lunar phases tip is not strong of a reason to switch to Emacs (or to even try it). But this editor, to me, has been the perfect fit for several purposes. Here&#8217;s a few:
    </p>
    
    <ul class="org-ul">
      <li>
        Thanks to <code>org-mode</code>, I write a journal, take notes, have my TO-DO list, write technical documentation, and manage JIRA tickets.
      </li>
      <li>
        <code>go-mode</code> is an excellent Go IDE that I use every day.
      </li>
      <li>
        <code>shell-mode</code> to use the shell while you&#8217;re writing code.
      </li>
      <li>
        <code>twittering-mode</code> :blush:
      </li>
    </ul>
    
    <p>
      I code all my software and do all my writing using Emacs. It works well for me. I wish multi-language support was more straight forward and, while I have figured it out for the most part and feel comfortable with it, setting it up wasn&#8217;t trivial.
    </p>
  </div>
</div>

<div id="outline-container-org227d1d4" class="outline-2">
  <h2 id="org227d1d4">
    Where it falls short for me
  </h2>
  
  <div class="outline-text-2" id="text-org227d1d4">
    <p>
      Emacs, however, is not for everyone. First of all, I tend to recommend <code>vim</code> to newbies thanks to its wide support. But that&#8217;s not the point. Emacs hasn&#8217;t been perfect for me (so far) for a few things:
    </p>
    
    <ul class="org-ul">
      <li>
        Raltime Communications. I use <a href="https://telegram.org/">Telegram</a> and <a href="https://slack.com/">Slack</a> on a daily basis; while there are modes for both on Emacs, they are not great or as convenient as the native alternatives or other command line options.
      </li>
      <li>
        Email. I have tried and made it work. I&#8217;ve used <code>gnus</code>,=mu4e=, and <code>notmuch</code>. While <code>notmuch</code> worked the best for me, handling 3 accounts and a somewhat large index made Emacs sluggish and unresponsive. I&#8217;ll stick to <a href="https://www.thunderbird.net">Thunderbird</a> for now.
      </li>
    </ul>
    
    <p>
      Again, these didn&#8217;t work for me, but your mileage may vary.
    </p>
  </div>
</div>

<div id="outline-container-org284d06c" class="outline-2">
  <h2 id="org284d06c">
    Best resources
  </h2>
  
  <div class="outline-text-2" id="text-org284d06c">
    <p>
      The beauty of this community is how responsive and supportive it is. Here are some of the best resources I&#8217;ve found for all things Emacs:
    </p>
    
    <ul class="org-ul">
      <li>
        <a href="https://stackoverflow.com/">Stackoverflow</a>. Duh!
      </li>
      <li>
        <a href="https://www.reddit.com/r/emacs/">/r/emacs</a> to learn how other people are using the editor.
      </li>
      <li>
        The original <a href="https://www.gnu.org/software/emacs/manual/pdf/emacs.pdf">Emacs Manual</a> by Mr. Stallman himself. Consider purchasing the <a href="https://shop.fsf.org/books/gnu-emacs-manual-18th-edition-v-261">printed version</a> and support the FSF.
      </li>
      <li>
        The <a href="https://orgmode.org/manual">org-mode manual</a> for all things <code>org-mode</code>.
      </li>
      <li>
        <a href="https://www.masteringemacs.org/">Mastering Emacs</a> is an amazing resource. Similar to the Emacs Manual but easy to read and more practical. Worth every penny.
      </li>
    </ul>
  </div>
</div>

<div id="outline-container-orgf2d484b" class="outline-2">
  <h2 id="orgf2d484b">
    Where to go from here
  </h2>
  
  <div class="outline-text-2" id="text-orgf2d484b">
    <p>
      My plan is to publish my <code>.emacs</code> file and explain it part by part, so stay tuned for more Emacs goodness.
    </p>
  </div>
</div>