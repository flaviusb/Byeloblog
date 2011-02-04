XML = Origin mimic do(
  ; namerep is used unquoted inside a doublequoted message to add in names for messages that break under shuffling rules
  namerep = method(x, y, x name = y. x)

  doctype = method(type,
    case(type,
      "xml",   '(#[<?xml version="1.0" encoding="utf-8"?>\n]),
      "xhtml", '"<!DOCTYPE html>\n"))
  comment = method(it, temp = 'internal:createText. temp << "\n<!--\n#{it}\n-->\n". temp)
  rem     = fn(it, temp = 'internal:createText. temp << "<!--#{it}-->". temp)

  attr = method("Print an attribute inline",
    k, v,
    " #{k}=\"#{v}\"")

  render = method(quoted,
    stack = []
    temp = quoted flatMap(msg,
      case(msg name,
        :internal:createText,   internal:createText(msg arguments [0]),
        :internal:createNumber, (internal:createNumber(msg arguments [0]) asText),
        :"",                    render(msg arguments [0]),
        :".",                   if(stack length > 1, stack pop!, ""),
        else, "<"+(msg name)+(msg arguments flatMap(arg, 
          cond(
            arg keyword?, " "+(arg name asText)[0...-1]+"="+(arg next asText),
            arg name == :"{}", adict = arg evaluateOn(Ground, Ground). adict flatMap(x, attr(x key, x value)),
            ""
          )) || "") + if((msg next != nil) && ((msg next name != :".") || (stack length == 0)), stack push!("</#{msg name}>"). ">"," />"))
    )
    temp + (stack reverse join)
  )

  fromFile = method("Read a file in XML render compatible form, and turn it into a Message",
    filename,
    Message fromText(FileSystem readFully(filename)))    
  fromQuotedFile = method("Read a file in XML render compatible quoted form, turn it into a Message, then eval it into the final message",
    filename,
    Message fromText(FileSystem readFully(filename)) evaluateOn(XML, XML))
)
