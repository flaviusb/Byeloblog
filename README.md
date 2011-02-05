#Byeloblog

Byeloblog is a simple static site generator, in the vein of Tom Preston-Werner's [Jekyll](https://github.com/mojombo/jekyll).

##What?

Byelobog was a fakeloric Jekyll to Chernobog's Hyde in modern reinterpretations of pre Christian Slavic mythology; Byeloblog as a neologism was too much for me to resist.

##No really, What?

This is a combination of simple libraries written in [Ioke](http://ioke.org) for templating and generating xhtml and css, with some good default options and templates for blogs. It also contains a script using these libraries that builds out a website based on a simple configuration file and your data.

Assume that you have some content, as files in a version control system of some kind. Rather than messing the content or version history up with a whole lot of stuff specific to your current method of site generation, you can store 

##But Why?

Assume that you want to blog like a hacker. This means writing posts in Vim or Emacs, thus the content must be in flat files, in some kind of source form.  Your data lives under version control somewhere, and

##Installing

Put the development branch somewhere convenient with

    cd $SOMEWHERE_CONVENIENT
    git clone git://github.com/flaviusb/Byeloblog.git

Alternatively, download as a tarball with

    wget https://github.com/flaviusb/Byeloblog/tarball/master

Then, extract it somewhere convenient.

##Use

If [Ioke](http://ioke.org) and the byeloblog.ik script are on your path, you can simply add a conf.ik file describing your site layout to the root of a copy of your site data, and run
    byeloblog.ik


