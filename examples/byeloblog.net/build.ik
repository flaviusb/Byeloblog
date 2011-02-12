index_data = {
  header: GenX fromMD("index_header.md"),
  nav:    GenX fromMD("index_nav.md"),
  body:   GenX fromMD("index.md")
}

GenX build(
  (index_data => "index.html") => "index.ik",
  "reset.css"                  => "reset.ik",
  "style.css"                  => "style.ik")
