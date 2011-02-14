; symbols are pseudoclasses
; $ is a class
; ? is (#)
; ^ is `uncamel
; | is , 
''(
$c | h1 {
  display: :table,
  margin: "10px auto"
}
h1 {
  ^fontFamily "Georgia, Times, sans-serif",
  ^fontSize   "200%"
}
nav {
  ^fontFamily     "Verdana, serif",
  ^marginBottom   "1.75em"
}
nav ul {
  ^listStyleType :none,
  ^textAlign :center
}
nav ul li {
  ^marginRight "20px",
  display: :inline
}
nav ul li a | h1 a {
  ^textDecoration :none,
  color: :black
}
a:hover { ^textDecoration :underline, color: :blue }
)
