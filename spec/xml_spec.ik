use("ispec")
use("byel_helper.ik")

use("xml.ik")
describe(XML,
  it("should be able to render a basic document",
    (XML render('(a b c))) should == "<a><b><c /></b></a>"
  )
  it("should be able to render attributes",
    (XML render('(a b(a: :b, b: c) c))) should == #[<a><b a=":b" b="c"><c /></b></a>]
  )
  it("should be able to render text blocks",
    (XML render('(urlset url "http://example.com"))) should == "<urlset><url>http://example.com</url></urlset>"
    theMessage = Message fromText(#[''(`doctype("xml") foo(xmlns: "http://example.com/foobar") "There should be text here." bar "And also here")]) evaluateOn(XML, XML)
    (XML render(theMessage)) should == #[<?xml version="1.0" encoding="utf-8"?>\n<foo xmlns="http://example.com/foobar">There should be text here.<bar>And also here</bar></foo>]
  )
  describe("should autoclose elements in the right places", {pending: true})
)
