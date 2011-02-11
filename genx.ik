use("xml.ik")

GenX = Origin mimic do(
  baseDir = "#{System currentWorkingDirectory}/"
  writeOut = method(fname, contents,
    if(FileSystem exists?(baseDir + fname), FileSystem removeFile!(baseDir + fname))
    FileSystem withOpenFile(baseDir + fname, fn(out, out println(contents))))
  renderQFile = method(fname,
    XML render(XML fromQuotedFile(fname)))
  build = method(+todo,
    todo each(task,
      #[Generating "#{task key}" from "#{task value}"] println
      writeOut(task key, XML render(XML fromQuotedFile(task value)))))
)

