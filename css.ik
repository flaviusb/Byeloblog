CSS = Origin mimic do(
  ; namerep is used unquoted inside a doublequoted message to add in names for messages that break under shuffling rules
  namerep = method(x, y, x name = y. x)
  uncamel = method("To work around the shuffling rules for Messages, uncamel takes a camel cased message name and converts it into a hyphen separated message name",
    x, x name = (x name asText replace(#/([A-Z])/, "-$1") lower). x)
  comment = method(it, temp = 'internal:createText. temp << "\n/*\n#{it}\n*/\n". temp)
  rem     = fn(it, temp = 'internal:createText. temp << (it replaceAll(#/(^|(\n))/, "$1//")). temp)
  cell(:^) = dsyntax("Convert camelcase name to hyphen split name in place",
    [camel]
    camel name = (camel name asText replace(#/([A-Z])/, "-$1") lower)
    textify = 'internal:createText
    textify << camel name asText
    if(camel next,
      pairen = '(=>)
      pairen << camel next
      textify -> pairen
    )
    textify)
  makeprop = method("Make an individual css property from a key => value pair", prop, context: CSS,
    "  #{prop key}: #{prop value};\n"
  )
  attr = method("Print a selector attribute as part of an attribute list",
  k, v,
  " #{k}=\"#{v}\"")

  render = method(quoted, context: CSS,
    first = true
    uf = fn(x, ret = unless(first, ", ", "") + x. first = false. ret)
    quoted flatMap(msg,
      case(msg name,
        :^,                     uf(internal:createText(uncamel(msg arguments[0]))),
        :internal:createText,   uf(internal:createText(msg arguments [0])),
        :internal:createNumber, uf(internal:createNumber(msg arguments [0]) asText),
        :{},                    proplist = msg evaluateOn(context, context)
                                " {\n#{proplist flatMap(prop, makeprop(prop, context))}}"
        :"",                    uf("[#{msg arguments flatMap(attr, (attr name) + (internal:createText(attr next arguments[0])))}]")
        :$,                     uf("." + (msg arguments[0] name)),
        :$^,                    uf("." + internal:createText(uncamel(msg arguments[0]))),
        :?,                     uf("#" + (msg arguments[0] name)),
        :?^,                    uf("#" + internal:createText(uncamel(msg arguments[0]))),
        else,                   uf(msg name + if(msg arguments length > 0,
                                  "[#{msg arguments map(arg,
                                    cond(
                                      arg keyword?, (arg name asText)[0...-1]+"="+(arg next asText),
                                      arg name == :"{}", adict = arg evaluateOn(Ground, Ground). adict map(x, attr(x key, x value)) join(", "),
                                      ""
                                    )) join(", ")}]"))
      ))
  )

  fromFile = method("Read a file in CSS render compatible form, and turn it into a Message",
    filename,
    Message fromText(FileSystem readFully(filename)))    
  fromQuotedFile = method("Read a file in CSS render compatible quoted form, turn it into a Message, then eval it into the final message",
    filename,
    Message fromText(FileSystem readFully(filename)) evaluateOn(CSS, CSS))
)
