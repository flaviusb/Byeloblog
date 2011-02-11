Shell = Origin mimic with(
  out: method(printer: fn(x, "From subshell: #{x}" println), +cmds,
    pb = java:lang:ProcessBuilder new(java:lang:String[] from(cmds))
    pb directory(java:io:File new(baseDir))
    pb redirectErrorStream(true)
    proc = pb start
    br = java:io:BufferedReader new(java:io:InputStreamReader new(proc getInputStream))
    it = nil
    bind(
      handle(Condition Error NativeException, fn(x, "Native Exception!" println. x println)),
      loop(
        it = br readLine
        if(it == nil, break)
        printer(internal:createText(it))
      )
      "Exit subshell with status #{proc waitFor}" println))
)
