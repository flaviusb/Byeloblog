nav    = GenX fromMD("nav.md")
header = GenX fromMD("header.md")
index_data = {
  title:  "Byeloblog",
  header: header,
  nav:    nav,
  body:   GenX fromMD("index.md")
}
about_data = {
  title:  "About Byeloblog",
  header: header,
  nav:    nav,
  body:   GenX fromMD("about.md")
}
examples_data = {
  title:  "Examples of a fictional sibling of an elder god...",
  header: header,
  nav:    nav,
  body:   ""
}
docs_data = {
  title:  "Documentation",
  header: header,
  nav:    nav,
  body:   GenX fromMD("docs.md")
}
smap_data = {
  urls: [ "http://byeloblog.net/", "http://byeloblog.net/about", "http://byeloblog.net/examples", "http://byeloblog.net/documentation" ]
}
base = "/var/www/byeloblog.net/htdocs/"
;base = ""
GenX build(base: base,
  (index_data    => "index.html")         => "index.ik",
  (about_data    => "about.html")         => "index.ik",
  (examples_data => "examples.html")      => "index.ik",
  (docs_data     => "documentation.html") => "index.ik",
  (smap_data     => "sitemap.xml")        => "sitemap.ik",
  "reset.css"                             => "reset.ik",
  "style.css"                             => "style.ik")
