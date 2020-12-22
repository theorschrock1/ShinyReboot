# create_ace_token

    Code
      create_ace_token(name = "variables", values = c("V(1)", "V(2)", "V(3)"),
      escape = TRUE)
    Output
      $token
      [1] "variables"
      
      $regex
      V\(1\)|V\(2\)|V\(3\)
      

---

    Code
      create_ace_token(name = "functions", values = paste0(c("SUM", "MIN", "MAX"),
      followed_by("\\(")), escape = FALSE)
    Output
      $token
      [1] "functions"
      
      $regex
      SUM(?=\()|MIN(?=\()|MAX(?=\()
      

