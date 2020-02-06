---
layout: post
title: Using Flutter to Generate Static Blog with Markdown for GitHub Pages
categories:
  - blog
author:
  - Mehmet Oguz Derin
---


Have you ever had a hardship reading a blog post due to the design of the platform? I get to have such moments, but the task of building a social platform for a blog is hard on its own. Flutter solves many problems of building user interfaces, let's see what it can offer if we want to blog with Markdown on GitHub Pages. But beware, this post is a demonstration of a proof-of-concept.


# Why Not Jekyll or `${youNameIt}`?

Of course, Jekyll, Hugo, and other static site generators are at a point that they are robust and matured. And Jekyll's file format serves as the guide for this work's blogging format. But at the moment, it is not convenient to try to contain a blog in a Flutter application that integrates tightly into a static generation pipeline due to a multitude of reasons. And with many software projects, for the sake of exploration of possibilities with Dart and Flutter.


# Why Flutter?

With the increasing digitalization of our everyday lives and the fueling developments, the days where the expectation from a blog is just wall of text is over. And besides expectations, the increasing complexity of topics leads the authors to find a way to create more customized content, whether it be machine learning or game design. Sometimes a static visualization helps, sometimes an interactive one. It all boils down to experimentation during the development of the content. Flutter substantially cuts the time from design ideation to app production by providing many design components and patterns on top of the Dart language, reducing boilerplate and increasing productivity. Coupled with developer tools and a compiler that builds to many platforms from a single codebase with efficient compilation, it is a compelling choice as a toolkit to create a blog in 2020, at least from the UX design perspective. Even though it is the early days of the web for Flutter, the speed of iteration and the community makes it suitable to give a shot at least.


# Building the Blog

Desire is to go from a set of Jekyll blog post formatted Markdown files to metadata that makes it possible to use them from Flutter to a Flutter web build that works in GitHub Pages in a way that preserves the URL scheme from Jekyll. The main bottleneck here is the generation of the web build. Long story short, GitHub Pages only supports redirection of unknown URLs only to a `404.html` due to relatable reasons, and it is not desirable to have your website redirected from a 404 page. Flutter inherently doesn't have a way to accomplish this by tweaking settings, and it probably won't for a long time. So I had to fall back to code generation to take my Markdown files, reflect them to Dart code and generate a build that fits the needs of GitHub Pages.


# Osaka

Osaka is the name of code generation package that I have built specifically to overcome this challenge, it looks for your posts under `assets/posts` folder, generates a reflection file named `lib/posts_build.dart` and produces necessary data to help GitHub Pages navigate its way around the project. I add `osaka` to development dependencies, create a suiting `web/index_post.html` and run the commands in `README.md` of Osaka to have the machinery of my blog working.


# Designing the Blog

Since the building process is no longer a question, it is time to do what the author wants to do. Just design, iterate, build, and repeat until it is satisfactory enough to publish. For this blog, I have just created a simple two-page sketch that contains enough to display this blog post, and within fifteen minutes, I had a (spaghetti coded) implementation working without problems. This speed is empowering for a person like me, next time I am building a blog, I no longer have to worry about a way to stretch it to my imagination, mainly thanks to the Flutter.


# Socializing Posts

Analytics and post comments are a reality of today's internet, and a welcomed one. For this blog, I have integrated Google Analytics, and the process has been a trivial modification to HTML files under the `web` directory. I skipped integrating a comment system because I am not sure which is today's best fit for a static blog. Still, for anyone interested in doing so, `HtmlElementView` will provide a way to integrate one easily.


# Problems

In this proof-of-concept work, named routing feature of Flutter has been given up. Right now, named routing in web adds an undesired `#` to the URL, creating inconsistent links. But this issue is noticed, and navigation will become much smoother after resolution.

As of today, builder support of Flutter is broken, at least on my Windows machine. Thus, we have to run custom build commands before and after. But even if that's resolved, the code generation mechanism for Dart is highly restricted, and it needs to have some flexibility in folder selection of outputs to accurately track the generated files.

The hacks in blog code will cause indirection for targeting other platforms, but resolutions are on the way, and abstraction can trivially handle the problems.

No JavaScript rendering of pages is currently (and likely forever) a dream, built application heavily relies on JavaScript to function and adapt to the window.


# Discussion

Despite the indirections and going back to building a wall-of-text blog, blogging with Flutter is fun and promising, inviting a sea of thought into the mind of the dreamer. Also, unless you are strictly going for Jekyll + GitHub Pages, this level of indirection and even more is expected. I think Flutter on the web as a blogging system will empower the content creators to the author at another level as Flutter itself and web standards develop. You can view the source code for this blog at [dscturk_github_io on GitHub](https://github.com/dscturk/dscturk_github_io) and find [Osaka at pub.dev](https://pub.dev/packages/osaka) and contact me as [@mehmetoguzderin on Twitter](https://twitter.com/mehmetoguzderin) or [Mehmet Oguz Derin on LinkedIn](https://www.linkedin.com/in/mehmetoguzderin), I would love to hear your feedback and improve according to it!