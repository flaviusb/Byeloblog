XML = Origin mimic do(
  ; namerep is used unquoted inside a doublequoted message to add in names for messages that break under shuffling rules
  namerep = method(x, y, x name = y. x)
  uncamel = method("To work around the shuffling rules for Messages, uncamel takes a camel cased message name and converts it into a hyphen separated message name",
    x, x name = (x name asText replaceAll(#/([A-Z])/, "-$1") lower). x)

  repbody = method("Replace the current cell of a message, leaving prev and next pointers intact.", src, rep,
    src arguments = rep arguments. src name = rep name.
    src)

  doctype = method(type,
    case(type,
      "xml",   '(#[<?xml version="1.0" encoding="utf-8"?>\n]),
      "xhtml", '"<!DOCTYPE html>\n"))
  ; some common entities
  comment = method(it, temp = 'internal:createText. temp << "\n<!--\n#{it}\n-->\n". temp)
  rem     = fn(it, temp = 'internal:createText. temp << "<!--#{it}-->". temp)

  attr = method("Print an attribute inline",
    k, v,
    " #{k}=\"#{v}\"")

  arg2txt = method("Coerce an argument which may be a bare string, an internal:createText, or an internal:concatenateText into a useful Text", arg,
    case(arg name,
      :internal:createText,       (arg arguments [0]),
      :internal:createNumber,     (internal:createNumber(arg arguments [0]) asText),
      :internal:concatenateText,  arg evaluateOn(XML, XML),
      else,                       arg name asText)
  )

  render = method(quoted,
    stack = []
    render:tag = fn(tag,
      "<"+(tag name)+(tag arguments flatMap(arg, 
          cond(
            arg keyword?,       #[ #{arg2txt(arg)[0...-1]}="#{arg2txt(arg next)}"],
            arg name == :"{}",  adict = arg evaluateOn(XML, XML). adict flatMap(x, attr(x key, x value)),
            ""
          )) || "") + if((tag next != nil) && ((tag next name != :".") || (stack length == 0)), stack push!("</#{tag name}>"). ">"," />"))
    ; first, the rewriting step
    temp = quoted flatMap(msg,
      case(msg name,
        :internal:createText,       internal:createText(msg arguments [0]),
        :internal:createNumber,     (internal:createNumber(msg arguments [0]) asText),
        :internal:concatenateText,  msg evaluateOn(XML, XML),
        :"",                        render(msg arguments [0]),
        :".",                       if(stack length > 1, stack pop!, ""),
        :^,                         render:tag(repbody(msg, uncamel(msg mimic arguments [0]))),
        ://,                        "<-- #{render(msg arguments [0])} -->",
        else,                       render:tag(msg))
    )
    temp + (stack reverse join)
  )

  fromFile = method("Read a file in XML render compatible form, and turn it into a Message",
    filename,
    Message fromText(FileSystem readFully(filename)))    
  fromQuotedFile = method("Read a file in XML render compatible quoted form, turn it into a Message, then eval it into the final message",
    filename, context: XML,
    Message fromText(FileSystem readFully(filename)) evaluateOn(context, context))
)
