nav    = GenX fromMD("nav.md")
header = GenX fromMD("header.md")
fileModified = method("Shell out to get file modification timestamp.", fileName,
  time = ""
  mktime = fn(x, time = x)
  Shell out(printer: mktime, "stat", "-c", "%y", fileName)
  time replace(#/([0-9]{4}-[0-9][0-9]-[0-9][0-9]) (.*)\..*([-+Z].*)/, "$1T$2$3")
)
index_data = {
  title:    "Byeloblog",
  header:   header,
  nav:      nav,
  body:     GenX fromMD("index.md"),
  modified: fileModified("index.md")
}
about_data = {
  title:    "About Byeloblog",
  header:   header,
  nav:      nav,
  body:     GenX fromMD("about.md"),
  modified: fileModified("about.md")
}
; This context variable stops unneccesary shelling out when we don't care about a files modification date
nomod = {
  modified: ""
}
examples_data = {
  title:  "Examples of a fictional sibling of an elder god...",
  header: header,
  nav:    nav,
  body:   ""
}
docs_data = {
  title:    "Documentation",
  header:   header,
  nav:      nav,
  body:     GenX fromMD("docs.md"),
  modified: fileModified("docs.md")  
}
base = "/var/www/byeloblog.net/htdocs/"
;base = ""
GenX baseURI = "http://byeloblog.net/"
GenX build(base: base,
  (index_data    => "index.html")         => "index.ik",
  (about_data    => "about.html")         => "index.ik",
  (examples_data => "examples.html")      => "index.ik",
  (docs_data     => "documentation.html") => "index.ik",
  (nomod         => "reset.css")          => "reset.ik",
  (nomod         => "style.css")          => "style.ik")
GenX deployRaw(base: base,
  "tentacle-tophat.png")
GenX sitemap(base: base)
