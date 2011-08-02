mkurls = method("Make list of urls from a list", urls,
  baseMsg = nil
  first = true
  urls each(url,
    if(first,
      baseMsg = ''((url (loc "#{`url[:file]}") `if(url[:modified] && url[:modified] != "", ''(lastmod "#{`url[:modified]}"), '("")))). first = false,
      baseMsg last -> ''((url (loc "#{`url[:file]}") `if(url[:modified] && url[:modified] != "", ''(lastmod "#{`url[:modified]}"), '(""))))))
  baseMsg
)
''(`doctype("xml")
urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") `mkurls(data[:urls]))
