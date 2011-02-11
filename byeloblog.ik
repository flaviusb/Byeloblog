#!/usr/bin/env ioke

;System currentWorkingDirectory println

use("xml.ik")
use("shell.ik")
use("genx.ik")

if(FileSystem exists?("build.ik"),
  use((System currentWorkingDirectory) + "/build.ik"),
  "No build.ik defined in #{System currentWorkingDirectory}" println)
