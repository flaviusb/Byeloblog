; symbols are pseudoclasses
; $ is a class
; ? is (#)
; ^ is `uncamel
; | is , 
''(
$c | h1 | nav {
  ^textAlign :center, 
  display: "block", 
  ^verticalAlign :middle,
  float: left
}
h1 {
  ^fontFamily "Georgia, Times, sans-serif",
  ^fontSize   "200%"
}
nav {
  ^fontFamily "Verdana, serif"
}
nav ul {
  ^listStyle :none
}
nav ul li {
  ^marginRight "40px"
}
nav ul li a {
  display: :block,
  ^textDecoration :none,
  color: :black
}
a:hover { ^textDecoration :underline, color: :blue }
)
