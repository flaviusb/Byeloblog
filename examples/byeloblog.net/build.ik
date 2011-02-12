nav = GenX fromMD("nav.md")
index_data = {
  header: GenX fromMD("index_header.md"),
  nav:    nav,
  body:   GenX fromMD("index.md")
}
  
base = "/var/www/byeloblog.net/htdocs/"
GenX build(base: base,
  (index_data => "index.html") => "index.ik",
  "reset.css"                  => "reset.ik",
  "style.css"                  => "style.ik")
