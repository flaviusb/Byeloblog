use("xml.ik")
use("css.ik")
use("shell.ik")

GenX = Origin mimic do(
  baseDir = "#{System currentWorkingDirectory}/"
  writeOut = method(fname, contents, base: baseDir,
    if(FileSystem exists?(base + fname), FileSystem removeFile!(base + fname))
    FileSystem withOpenFile(base + fname, fn(out, out println(contents))))
  built = []
  baseURI = ""
  build = method("Method that renders an ik form from a file into a document. It tries to guess what kind of transform to apply based on the file extension of the file to write.", +todo, base: baseDir,
    todo each(task,
      fromFile = "". context = ""
      case(task key,
        Pair, context = task key key. fromFile = task key value,
        Text, context = "".           fromFile = task key)
      #[Generating "#{fromFile}" from "#{task value}"] println
      built << fromFile
      case(fromFile,
        #/.*.css$/, writeOut(base: base, fromFile, CSS render(CSS fromQuotedFile(task value))),
        else,       writeOut(base: base, fromFile, XML render(XML fromQuotedFile(task value, context: XML mimic with(data: context)))))))
  sitemap = method("Generate a google sitemap.xml based on the urls in built.", base: baseDir, name: "sitemap.xml", filter: #/html/,
    "Building sitemap: #{name}" println
    writeOut(base: base, name, XML render(XML fromQuotedFile((System currentDirectory) + "/lib/sitemap.ik", context: XML mimic with(data: {urls: built filter(uri, uri =~ filter) map(uri, baseURI + uri)})))))
  fromMD = method("Get a markdown file, process it, and return it", filename,
    pipe = []
    frompipe = fn(x, pipe << x)
    Shell out(printer: frompipe, "markdown", "-F", "0x4", filename)
    pipe join("\n") replaceAll(#/^"|([^\\])"/, #[$1\\"])))
)
