nav = GenX fromMD("nav.md")
index_data = {
  title:  "Byeloblog",
  header: GenX fromMD("index_header.md"),
  nav:    nav,
  body:   GenX fromMD("index.md")
}
about_data = {
  title:  "About Byeloblog",
  header: GenX fromMD("about_header.md"),
  nav:    nav,
  body:   GenX fromMD("about.md")
}
base = "/var/www/byeloblog.net/htdocs/"
GenX build(base: base,
  (index_data => "index.html") => "index.ik",
  (about_data => "about.html") => "index.ik",
  "reset.css"                  => "reset.ik",
  "style.css"                  => "style.ik")
