mkurls = method("Make list of urls from a list", urls,
  baseMsg = nil
  first = true
  urls each(url,
    if(first,
      baseMsg = ''((url (loc "#{`url}"))). first = false,
      baseMsg last -> ''((url (loc "#{`url}")))))
  baseMsg
)
''(`doctype("xml")
urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") `mkurls(data[:urls]))
