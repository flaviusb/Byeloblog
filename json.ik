; Some anaphoric control sequences
; Here be gryphons and scabrous wyrms
arip = dsyntax(#[Anaphorically iterate through a seq, returning "body" executed against the value of "it" that passes "test".],
  [>theSeq, test, body]
  ''let(theSeq, `theSeq, go, true, while(theSeq next? && go, `let(gs, genSym, ''let(cell(`gs), theSeq next, let(it, cell(`gs), if(`test, go = false. let(it, cell(`gs), `body))))))),
  [>theSeq, newassign, test, body, fail]
  ''let(theSeq, `theSeq, go, true, while(theSeq next? && go, `let(gs, genSym, ''let(cell(`gs), theSeq next, let(it, cell(`gs), let(cell(`gs), `newassign, let(it, cell(`gs), if(`test, go = false. let(it, cell(`gs), `body)))))))) || `fail)
)

DefaultBehavior FlowControl letrec = macro(
  newObject = mimic 
  call arguments each(arg, 
    if(arg keyword?,
      let(foo, arg,
        Reflector other:cell(self, foo name asText [](0 ..(0 -(2)))) = (''(method(+a, +:b,
          ; Make inactivateable for the moment
          if(a empty? && b empty?, return Reflector other:cell(surroundingContext, currentMessage name))
          Reflector other:cell(self, "#{`(foo name asText [](0 ..(0 -(2))))}") = ''(`(foo next)) evaluateOn(self)
          ("#{`(foo name asText [](0 ..(0 -(2))))}" + "(" + a join(", ") + b join(", ") + ")") println
          Reflector other:send(self, "#{`(foo name asText [](0 ..(0 -(2))))}", * a, * b))) evaluateOn(self))  ), 
        newObject doMessage(arg)))
  newObject)

; Note: Parsers should be inactivatable eg fn, Parser Combinators should be activatable eg fnx, method

Parser = Origin mimic with(
  ; Parsers take a parse position and a data structure, and return a parse position and a data structure or nil
  ; seq => and and alt => or are combinators
  data: "",
  alt: method("Return a result from the first parser in parsers to return a result; if none do, return nil.", +parsers,
    return fn(pos, struct,
      iter = parsers seq
      ret = nil
      loop(
        unless(iter next?, break)
        parser = iter next
        ret    = parser(pos, struct)
        if(ret, break)
      )
      ret)),
  ; A No op
  nop: fn(pos, struct, [pos, struct]),
  opt: method("If the child parser is unsuccessful, return the parse position and data unchanged rather than nil.", parser, return alt(parser, nop)),
  star: method("Apply the child parser as many times as it can be applied; return input unchanged if it cannot be applied.", parser, 
    return fn(pos, struct,
      acc = [pos, struct]
      loop(if(parser(*acc), 
        ; Test whether we have moved. While it is possible that parsers are doing in place modification, this construct terminates to avoid star(nop) non-termination
        if(it[0] == acc[0], break).
        ;Either accumulate, or break
        acc = it, break))
      acc)),
  many1: method("Apply the child parser as many times as it can be applied. If it cannot be applied at all, return nil.", parser, aseq(parser, star(parser))),
  aseq: method("Apply the child parsers one after the other. If any fail, return nil.", +parsers,
    return fn(position, struct,
      acc = [position, struct]
      parsers each(parser, if(acc, acc = parser(*acc). acc println))
      acc)),
  wrapped: method("Add a behavior around a parser", parser, mod,
    return fn(pos, struct,
      if(parser(pos, struct),
        it[1] = mod(it[1], data[pos...it[0]])
        it, nil))),
  lit: method("Match a Text or Regexp.", alit,
    return fn(idx, astb,
      case(alit,
        Text,   if(data[idx...(idx +(alit length))] == alit,
          [(idx + (alit length)), astb],
          nil),
        Regexp, if(data[idx..-1] =~ alit, [idx + (it end), astb],
          nil)))))

JSONParser = Parser mimic letrec(
  wraplit: method(parser, converter,
    return wrapped(parser, fn(struct, newdata,
      let(ret, converter(newdata),
        if(ret == nil,
          ret,
          case(struct,
            Pair,  (struct key => ret),
            List,  struct + [ret],
            else,  ret)))))),
  escapes: lit(#/^\\("|(\\)|(\/)|b|f|n|r|t|[0-9]{4})/),
  escaped: star(alt(lit(#/^[^\\"]/), escapes)),
  string:  aseq(lit(#["]), wraplit(escaped, fn(str, str)), lit(#["])),
  number:  wraplit(lit(#/^[-+]?[0-9]+(\.[0-9]*)?/), fn(str, str toDecimal)),
  ws:      lit(#/^[ \n]*/),
  jlist:   aseq(wrapped(lit("["), fn(x, y, [])), opt(aseq(aseq(ws, thing), star(aseq(ws, lit(","), ws, thing)))), ws, lit("]")),
  thing:   alt(number, string))
;  expression = list or dict or literal
;  dict = ...
;
;JSONParser data =  FileSystem readFully...
;jsonresult = JSONParser expression(0, Dict)

