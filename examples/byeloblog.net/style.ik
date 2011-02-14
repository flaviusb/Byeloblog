; symbols are pseudoclasses
; $ is a class
; ? is (#)
; ^ is `uncamel
; | is , 
''(
$c | h1 | nav {
  ^textAlign :center, 
  ^verticalAlign :middle,
  display: :inline
}
h1 {
  ^fontFamily "Georgia, Times, sans-serif",
  ^fontSize   "200%"
}
nav {
  ^fontFamily "Verdana, serif"
}
nav ul {
  ^listStyleType :none,
  ^textAlign :left
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
