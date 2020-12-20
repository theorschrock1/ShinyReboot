# check_valid_code

    Code
      check_valid_code("SUM(X)", null.ok = FALSE)
    Output
      [1] TRUE

---

    Code
      check_valid_code("SUMX)", null.ok = FALSE)
    Output
      Missing open parenthises `(`

---

    Code
      check_valid_code("SUM(X){", null.ok = FALSE)
    Output
      Missing closed curly bracket `}`

---

    Code
      check_valid_code("SUM(X){}", null.ok = FALSE)
    Output
      [1] TRUE

---

    Code
      check_valid_code("SUM(X){\"}", null.ok = FALSE)
    Output
      Missing or unclosed quotation mark.

---

    Code
      check_valid_code("SUM(X{\"]", null.ok = FALSE)
    Output
      Missing closed parenthises `)`. Missing closed curly bracket `}`. Missing open square bracket `[`. Missing or unclosed quotation mark.

