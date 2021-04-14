---
author: iarenzana
categories:
- Blog
date: "2019-06-28T15:37:00Z"
guid: https://arenzana.org/?p=399
id: 399
tags:
- devops
- tech
title: Artisanal Web Hosting
url: /2019/06/artisanal-web-hosting/
---
<div id="outline-container-org4840735" class="outline-2">
  <h2 id="org4840735">
    Summary
  </h2>
  
  <div class="outline-text-2" id="text-org4840735">
    <p>
      I have an operations background. My first company taught me most of what I know about how to run software and server operations. Fast-forward 15 years and we are now all about the cloud, VPSs, and Kubernetes. I love <a href="https://arenzana.org/2019/04/blogging-with-org-mode/">the cloud</a>. Up until a few weeks ago, my blog has been hosted at <a href="http://scaleway.com/">Scaleway</a>, which has worked great for me. Today I run it on my own server where (for better or for worse) everything is managed by me.
    </p>
  </div>
</div>

<div id="outline-container-org8dbb15f" class="outline-2">
  <h2 id="org8dbb15f">
    Why
  </h2>
  
  <div class="outline-text-2" id="text-org8dbb15f">
    <p>
      One thing I was not happy about was Google Analytics. To keep my uptime I want to know the number of page loads and system load in order to optimize and scale. I know, I should probably be using a CDN to mitigate some of these issues, but I don&#8217;t feel I&#8217;m there just yet. Google Analytics is one of those services that is not known to be privacy friendly, and if you are here, I respect you and your time. I don&#8217;t include ads and I try to keep the tracking as limited as possible disabling social crap, etc. For my purposes, I don&#8217;t need Google analytics. A web server logs all of the information I need for scaling purposes. All I needed was to access those logs (which I already had access to) and store the data in a database, create a dashboard, and kiss Google Analytics goodbye.
    </p>
    
    <p>
      I know, I could&#8217;ve used AWS or Google Cloud to do this; but the cost over time would have been prohibitive. Self-hosting seems like the right answer at the moment.
    </p>
    
    <p>
      The game plan:
    </p>
    
    <ol class="org-ol">
      <li>
        With the help of my company, I got a new server and some data center space (power, networking, and a rack). I know, this is the most tricky part as not everyone works for a telco that can provide these things. The point of this post is not to justify the financial advantage of self-hosting vs the cloud, but to point out the elements we overlook by leaving it up to the cloud to do some of the heavy lifting.
      </li>
      <li>
        I installed ESXi on the server to run all my infrastructure. I have done this before, so I felt fairly comfortable reproducing this.
      </li>
      <li>
        I used VyOS for all the networking and firewall needs. This was the trickiest part. I hate networking. I still do and the networking concepts, to be honest, just beat me. Somehow though, with basic subnetting and routing skills, you can actually get surprisingly far.
      </li>
      <li>
        I used <a href="https://www.terraform.io/">Terraform</a> to define all my (CentOS 7) infrastructure and <a href="https://www.ansible.com/">Ansible</a> to automate/standarize the configuration of every element in my little cloud.
      </li>
      <li>
        NGINX to host my site (quite straight forward).
      </li>
      <li>
        Run an Elastic stack (really, just <a href="https://www.elastic.co/products/beats">Beats</a>, <a href="https://www.elastic.co/products/elasticsearch">Elasticsearch</a>, and <a href="https://www.elastic.co/products/kibana">Kibana</a>) for data processing. From system auditing, to security, log parsing, and metrics. This stack is the central unit that gives me visibility into what&#8217;s happening inside my system. This includes NGINX log analysis.
      </li>
    </ol>
  </div>
</div>

<div id="outline-container-orgc5c0271" class="outline-2">
  <h2 id="orgc5c0271">
    tl;dr
  </h2>
  
  <div class="outline-text-2" id="text-orgc5c0271">
    <p>
      Over the next few weeks I&#8217;ll be writing about my experience <span class="underline">moving away from the cloud</span>. The work it involved, where I believe it&#8217;s better than the cloud, and where I believe the cloud is superior. I will talk about what&#8217;s left in my set up and how I&#8217;m planning on tackling it.
    </p>
    
    <p>
      They say the journey is as important as the destination itself and, in this case, I must agree. I have learned a lot through the process. Perhaps someone will learn something from my experience. That will make it all worth it!
    </p>
  </div>
</div>