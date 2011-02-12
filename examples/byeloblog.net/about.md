Byeloblog is a simple static site generator, in the vein of Tom Preston-Werner's [Jekyll](https://github.com/mojombo/jekyll).

##What?

Byelobog was a fakeloric Jekyll to Chernobog's Hyde in modern reinterpretations of pre Christian Slavic mythology; Byeloblog as a neologism was too much for me to resist.

##No really, What?

This is a combination of simple libraries written in [Ioke](http://ioke.org) for templating and generating xhtml and css, with some good default options and templates for blogs. It also contains a script using these libraries that builds out a website based on a simple configuration file and your data.

##But Why?

Assume that you want to blog like a hacker.  This means writing posts in Vim or Emacs, in some kind of high level form, and posting using the terminal.  You also want your data to live somewhere under version control.  Flat files are one possible kind of solution to this. To avoid crufting things up with the build apparatus, you want an existing system that can be installed external to your data.  You also probably want to do something original and possibly stupid; to aid this, the configuration language should be turing complete. Keeping a single conf file in a high level language in your data can be excused as helping to document the format of your data, but you want something suitably close to [Omega](http://flaviusb.net/2011/01/08/%CE%A9.html); so, Byeloblog uses Ioke.

