#!/usr/bin/env ioke

System loadPath << (System currentDirectory)
use("xml.ik")
use("css.ik")
use("shell.ik")
use("genx.ik")

if(System programArguments empty?,
  if(FileSystem exists?("build.ik"),
    use((System currentWorkingDirectory) + "/build.ik"),
    "No build.ik defined in #{System currentWorkingDirectory}" println),
  use((System programArguments [0])))
