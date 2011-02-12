use("xml.ik")
use("css.ik")

GenX = Origin mimic do(
  baseDir = "#{System currentWorkingDirectory}/"
  writeOut = method(fname, contents,
    if(FileSystem exists?(baseDir + fname), FileSystem removeFile!(baseDir + fname))
    FileSystem withOpenFile(baseDir + fname, fn(out, out println(contents))))
  build = method("Method that renders an ik form from a file into a document. It tries to guess what kind of transform to apply based on the file extension of the file to write.", +todo,
    todo each(task,
      #[Generating "#{task key}" from "#{task value}"] println
      case(task key,
        #/.*.css$/, writeOut(task key, CSS render(CSS fromQuotedFile(task value))),
        else,       writeOut(task key, XML render(XML fromQuotedFile(task value))))))
)

