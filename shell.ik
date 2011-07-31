Shell = Origin mimic with(
  baseDir: "#{System currentWorkingDirectory}/",
  out: method("Shell out to a subprocess with working directory pwd:, write stdin: to the standard input of the subprocess, and use printer: to alter the display printer.",
      printer: fn(x, "From subshell: #{x}" println), +cmds, pwd: baseDir, stdin: nil,
    pb = java:lang:ProcessBuilder new(java:lang:String[] from(cmds))
    pb directory(java:io:File new(pwd))
    pb redirectErrorStream(true)
    proc = pb start
    br = java:io:BufferedReader new(java:io:InputStreamReader new(proc getInputStream))
    it = nil
    bind(
      handle(Condition Error NativeException, fn(x, "Native Exception!" println. x println)),
      if(stdin != nil,
        let(stdinstream, java:io:BufferedWriter new(java:io:OutputStreamWriter new(proc getOutputStream)),
          stdinstream write(stdin, 0, stdin length))
      )
      loop(
        it = br readLine
        if(it == nil, break)
        printer(internal:createText(it))
      )
      let(res, internal:createNumber(proc waitFor), "Exit subshell with status #{res}" println. return res)))
)
