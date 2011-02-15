#Byeloblog

Byeloblog is a simple static site generator, in the vein of Tom Preston-Werner's [Jekyll](https://github.com/mojombo/jekyll).

##What?

Byelobog was a fakeloric Jekyll to Chernobog's Hyde in modern reinterpretations of pre Christian Slavic mythology; Byeloblog as a neologism was too much for me to resist.

##No really, What?

This is a combination of simple libraries written in [Ioke](http://ioke.org) for templating and generating xhtml and css, with some good default options and templates for blogs. It also contains a script using these libraries that builds out a website based on a simple configuration file and your data.

##But Why?

Assume that you want to blog like a hacker.  This means writing posts in Vim or Emacs, in some kind of high level form, and posting using the terminal.  You also want your data to live somewhere under version control.  Flat files are one possible kind of solution to this. To avoid crufting things up with the build apparatus, you want an existing system that can be installed external to your data. Keeping a single conf file in a high level language in your data can be excused as helping to document the format of your data, but you want something suitably close to [Omega](http://flaviusb.net/2011/01/08/%CE%A9.html); so, Byeloblog uses Ioke.

##Installing

Put the development branch somewhere convenient with

    cd $SOMEWHERE_CONVENIENT
    git clone git://github.com/flaviusb/Byeloblog.git

Alternatively, download as a tarball with

    wget https://github.com/flaviusb/Byeloblog/tarball/master

Then, extract it somewhere convenient.

##Use

If [Ioke](http://ioke.org) and the byeloblog.ik script are on your path, you can simply add a build.ik file describing your site layout to the root of a copy of your site data, and run
    byeloblog.ik

The format of the build.ik file, and more information on usage can be found at the [examples](http://byeloblog.net/examples "Examples") or [docs](http://byeloblog.net/documentation "Documentation") pages.
