; symbols are pseudoclasses
; $ is a class
; ? is (#)
; ^ is `uncamel
; | is , 
''(
$c | h1 | nav {
  ^textAlign :center, 
  ^verticalAlign :middle,
  float: :left
}
h1 {
  ^fontFamily "Georgia, Times, sans-serif",
  ^fontSize   "200%"
}
nav {
  ^fontFamily "Verdana, serif",
  clear: :right
}
nav ul {
  ^listStyleType :none
}
nav ul li {
  ^marginRight "20px",
  display: :inline
}
nav ul li a {
  ^textDecoration :none,
  color: :black
}
a:hover { ^textDecoration :underline, color: :blue }
)
