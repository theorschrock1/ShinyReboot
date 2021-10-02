# html2R

    Code
      html2R(
        "<div class=\"btn-group btn-group-toggle\" data-toggle=\"buttons\">\n  <label class=\"btn btn-secondary active\">\n    <input type=\"radio\" name=\"options\" id=\"option1\" checked> Active\n  </label>\n  <label class=\"btn btn-secondary\">\n    <input type=\"radio\" name=\"options\" id=\"option2\"> Radio\n  </label>\n  <label class=\"btn btn-secondary\">\n    <input type=\"radio\" name=\"options\" id=\"option3\"> Radio\n  </label>\n</div>")
    Output
      div(class = "btn-group btn-group-toggle", `data-toggle` = "buttons", 
          tags$label(class = "btn btn-secondary active", tags$input(type = "radio", 
              name = "options", id = "option1", checked = "checked"), 
              "Active"), tags$label(class = "btn btn-secondary", tags$input(type = "radio", 
              name = "options", id = "option2"), "Radio"), tags$label(class = "btn btn-secondary", 
              tags$input(type = "radio", name = "options", id = "option3"), 
              "Radio"))

---

    Code
      html2R(
        "<div class=\"form-group shiny-input-container shiny-input-radiogroup shiny-input-container-inline\">\n  <label class=\"control-label\" for=\"somevalue1\">Make a choice: </label>\n    \n    <div id=\"somevalue1\" class=\"radioGroupButtons\">\n      <div aria-label=\"...\" class=\"btn-group btn-group-container-sw\" data-toggle=\"buttons\" role=\"group\">\n        <div class=\"btn-group btn-group-toggle\" role=\"group\">\n          <button class=\"btn radiobtn btn-default active\">\n            <input type=\"radio\" autocomplete=\"off\" name=\"somevalue1\" value=\"A\" checked=\"checked\"/>\n              A\n            </button>\n              </div></div>\n                          </div>\n                          </div>")
    Output
      div(class = "form-group shiny-input-container shiny-input-radiogroup shiny-input-container-inline", 
          tags$label(class = "control-label", `for` = "somevalue1", 
              "Make a choice:"), div(id = "somevalue1", class = "radioGroupButtons", 
              div(`aria-label` = "...", class = "btn-group btn-group-container-sw", 
                  `data-toggle` = "buttons", role = "group", div(class = "btn-group btn-group-toggle", 
                      role = "group", tags$button(class = "btn radiobtn btn-default active", 
                        tags$input(type = "radio", autocomplete = "off", 
                          name = "somevalue1", value = "A", checked = "checked"), 
                        "A")))))

---

    Code
      html2R(
        "<div class=\"form-group shiny-input-container shiny-input-radiogroup shiny-input-container-inline\">\n  <label class=\"control-label\" for=\"somevalue1\">Make a choice: </label>\n    <br/>\n    <div id=\"somevalue1\" class=\"radioGroupButtons\">\n      <div aria-label=\"...\" class=\"btn-group btn-group-container-sw\" data-toggle=\"buttons\" role=\"group\">\n        <div class=\"btn-group btn-group-toggle\" role=\"group\">\n          <button class=\"btn radiobtn btn-default active\">\n            <input type=\"radio\" autocomplete=\"off\" name=\"somevalue1\" value=\"A\" checked=\"checked\"/>\n              A\n            </button>\n              </div></div>\n                          </div>\n                          </div>")
    Output
      div(class = "form-group shiny-input-container shiny-input-radiogroup shiny-input-container-inline", 
          tags$label(class = "control-label", `for` = "somevalue1", 
              "Make a choice:"), tags$br(), div(id = "somevalue1", 
              class = "radioGroupButtons", div(`aria-label` = "...", 
                  class = "btn-group btn-group-container-sw", `data-toggle` = "buttons", 
                  role = "group", div(class = "btn-group btn-group-toggle", 
                      role = "group", tags$button(class = "btn radiobtn btn-default active", 
                        tags$input(type = "radio", autocomplete = "off", 
                          name = "somevalue1", value = "A", checked = "checked"), 
                        "A")))))

---

    Code
      html2R(
        "<nav id=\"navbar-example3\" class=\"navbar navbar-light bg-light\">\n  <a class=\"navbar-brand\" href=\"#\">Navbar</a>\n  <nav class=\"nav nav-pills flex-column\">\n    <a class=\"nav-link\" href=\"#item-1\">Item 1</a>\n    <nav class=\"nav nav-pills flex-column\">\n      <a class=\"nav-link ml-3 my-1\" href=\"#item-1-1\">Item 1-1</a>\n      <a class=\"nav-link ml-3 my-1\" href=\"#item-1-2\">Item 1-2</a>\n    </nav>\n    <a class=\"nav-link\" href=\"#item-2\">Item 2</a>\n    <a class=\"nav-link\" href=\"#item-3\">Item 3</a>\n    <nav class=\"nav nav-pills flex-column\">\n      <a class=\"nav-link ml-3 my-1\" href=\"#item-3-1\">Item 3-1</a>\n      <a class=\"nav-link ml-3 my-1\" href=\"#item-3-2\">Item 3-2</a>\n    </nav>\n  </nav>\n</nav>\n\n<div data-spy=\"scroll\" data-target=\"#navbar-example3\" data-offset=\"0\">\n  <h4 id=\"item-1\">Item 1</h4>\n  <p>...</p>\n  <h5 id=\"item-1-1\">Item 1-1</h5>\n  <p>...</p>\n  <h5 id=\"item-1-2\">Item 1-2</h5>\n  <p>...</p>\n  <h4 id=\"item-2\">Item 2</h4>\n  <p>...</p>\n  <h4 id=\"item-3\">Item 3</h4>\n  <p>...</p>\n  <h5 id=\"item-3-1\">Item 3-1</h5>\n  <p>...</p>\n  <h5 id=\"item-3-2\">Item 3-2</h5>\n  <p>...</p>\n</div>")
    Output
      tagList(tags$nav(id = "navbar-example3", class = "navbar navbar-light bg-light", 
          tags$a(class = "navbar-brand", href = "#", "Navbar"), tags$nav(class = "nav nav-pills flex-column", 
              tags$a(class = "nav-link", href = "#item-1", "Item 1"), 
              tags$nav(class = "nav nav-pills flex-column", tags$a(class = "nav-link ml-3 my-1", 
                  href = "#item-1-1", "Item 1-1"), tags$a(class = "nav-link ml-3 my-1", 
                  href = "#item-1-2", "Item 1-2")), tags$a(class = "nav-link", 
                  href = "#item-2", "Item 2"), tags$a(class = "nav-link", 
                  href = "#item-3", "Item 3"), tags$nav(class = "nav nav-pills flex-column", 
                  tags$a(class = "nav-link ml-3 my-1", href = "#item-3-1", 
                      "Item 3-1"), tags$a(class = "nav-link ml-3 my-1", 
                      href = "#item-3-2", "Item 3-2")))), div(`data-spy` = "scroll", 
          `data-target` = "#navbar-example3", `data-offset` = "0", 
          tags$h4(id = "item-1", "Item 1"), tags$p("..."), tags$h5(id = "item-1-1", 
              "Item 1-1"), tags$p("..."), tags$h5(id = "item-1-2", 
              "Item 1-2"), tags$p("..."), tags$h4(id = "item-2", "Item 2"), 
          tags$p("..."), tags$h4(id = "item-3", "Item 3"), tags$p("..."), 
          tags$h5(id = "item-3-1", "Item 3-1"), tags$p("..."), tags$h5(id = "item-3-2", 
              "Item 3-2"), tags$p("...")))

---

    Code
      html2R(
        "<div id=\"list-example\" class=\"list-group\">\n  <a class=\"list-group-item list-group-item-action\" href=\"#list-item-1\">Item 1</a>\n  <a class=\"list-group-item list-group-item-action\" href=\"#list-item-2\">Item 2</a>\n  <a class=\"list-group-item list-group-item-action\" href=\"#list-item-3\">Item 3</a>\n  <a class=\"list-group-item list-group-item-action\" href=\"#list-item-4\">Item 4</a>\n</div>\n<div data-spy=\"scroll\" data-target=\"#list-example\" data-offset=\"0\" class=\"scrollspy-example\">\n  <h4 id=\"list-item-1\">Item 1</h4>\n  <p>...</p>\n  <h4 id=\"list-item-2\">Item 2</h4>\n  <p>...</p>\n  <h4 id=\"list-item-3\">Item 3</h4>\n  <p>...</p>\n  <h4 id=\"list-item-4\">Item 4</h4>\n  <p>...</p>\n</div>")
    Output
      tagList(div(id = "list-example", class = "list-group", tags$a(class = "list-group-item list-group-item-action", 
          href = "#list-item-1", "Item 1"), tags$a(class = "list-group-item list-group-item-action", 
          href = "#list-item-2", "Item 2"), tags$a(class = "list-group-item list-group-item-action", 
          href = "#list-item-3", "Item 3"), tags$a(class = "list-group-item list-group-item-action", 
          href = "#list-item-4", "Item 4")), div(`data-spy` = "scroll", 
          `data-target` = "#list-example", `data-offset` = "0", class = "scrollspy-example", 
          tags$h4(id = "list-item-1", "Item 1"), tags$p("..."), tags$h4(id = "list-item-2", 
              "Item 2"), tags$p("..."), tags$h4(id = "list-item-3", 
              "Item 3"), tags$p("..."), tags$h4(id = "list-item-4", 
              "Item 4"), tags$p("...")))

---

    Code
      html2R(
        "<button type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#exampleModal\">\n  Launch demo modal\n</button>\n\n  <div class=\"modal fade\" id=\"exampleModal\" tabindex=\"-1\" aria-labelledby=\"exampleModalLabel\" aria-hidden=\"true\">\n  <div class=\"modal-dialog\">\n  <div class=\"modal-content\">\n  <div class=\"modal-header\">\n  <h5 class=\"modal-title\" id=\"exampleModalLabel\">Modal title</h5>\n  <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">\n  <span aria-hidden=\"true\">&times;</span>\n  </button>\n  </div>\n  <div class=\"modal-body\">\n  ...\n</div>\n  <div class=\"modal-footer\">\n  <button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Close</button>\n  <button type=\"button\" class=\"btn btn-primary\">Save changes</button>\n  </div>\n  </div>\n  </div>\n  </div>")
    Output
      tagList(tags$button(type = "button", class = "btn btn-primary", 
          `data-toggle` = "modal", `data-target` = "#exampleModal", 
          "Launch demo modal"), div(class = "modal fade", id = "exampleModal", 
          tabindex = "-1", `aria-labelledby` = "exampleModalLabel", 
          `aria-hidden` = "true", div(class = "modal-dialog", div(class = "modal-content", 
              div(class = "modal-header", tags$h5(class = "modal-title", 
                  id = "exampleModalLabel", "Modal title"), tags$button(type = "button", 
                  class = "close", `data-dismiss` = "modal", `aria-label` = "Close", 
                  tags$span(`aria-hidden` = "true", "&times;"))), div(class = "modal-body", 
                  "..."), div(class = "modal-footer", tags$button(type = "button", 
                  class = "btn btn-secondary", `data-dismiss` = "modal", 
                  "Close"), tags$button(type = "button", class = "btn btn-primary", 
                  "Save changes"))))))

---

    Code
      html2R(
        "<div class=\"modal-body\">\n  <div class=\"container-fluid\">\n    <div class=\"row\">\n      <div class=\"col-md-4\">.col-md-4</div>\n      <div class=\"col-md-4 ml-auto\">.col-md-4 .ml-auto</div>\n    </div>\n    <div class=\"row\">\n      <div class=\"col-md-3 ml-auto\">.col-md-3 .ml-auto</div>\n      <div class=\"col-md-2 ml-auto\">.col-md-2 .ml-auto</div>\n    </div>\n    <div class=\"row\">\n      <div class=\"col-md-6 ml-auto\">.col-md-6 .ml-auto</div>\n    </div>\n    <div class=\"row\">\n      <div class=\"col-sm-9\">\n        Level 1: .col-sm-9\n        <div class=\"row\">\n          <div class=\"col-8 col-sm-6\">\n            Level 2: .col-8 .col-sm-6\n          </div>\n          <div class=\"col-4 col-sm-6\">\n            Level 2: .col-4 .col-sm-6\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>")
    Output
      div(class = "modal-body", div(class = "container-fluid", div(class = "row", 
          div(class = "col-md-4", ".col-md-4"), div(class = "col-md-4 ml-auto", 
              ".col-md-4 .ml-auto")), div(class = "row", div(class = "col-md-3 ml-auto", 
          ".col-md-3 .ml-auto"), div(class = "col-md-2 ml-auto", ".col-md-2 .ml-auto")), 
          div(class = "row", div(class = "col-md-6 ml-auto", ".col-md-6 .ml-auto")), 
          div(class = "row", div(class = "col-sm-9", div(class = "row", 
              div(class = "col-8 col-sm-6", "Level 2: .col-8 .col-sm-6"), 
              div(class = "col-4 col-sm-6", "Level 2: .col-4 .col-sm-6"))))))

---

    Code
      html2R(
        "<button type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#exampleModal\" data-whatever=\"@mdo\">Open modal for @mdo</button>\n<button type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#exampleModal\" data-whatever=\"@fat\">Open modal for @fat</button>\n<button type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#exampleModal\" data-whatever=\"@getbootstrap\">Open modal for @getbootstrap</button>\n\n<div class=\"modal fade\" id=\"exampleModal\" tabindex=\"-1\" aria-labelledby=\"exampleModalLabel\" aria-hidden=\"true\">\n  <div class=\"modal-dialog\">\n    <div class=\"modal-content\">\n      <div class=\"modal-header\">\n        <h5 class=\"modal-title\" id=\"exampleModalLabel\">New message</h5>\n        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">\n          <span aria-hidden=\"true\">&times;</span>\n        </button>\n      </div>\n      <div class=\"modal-body\">\n        <form>\n          <div class=\"form-group\">\n            <label for=\"recipient-name\" class=\"col-form-label\">Recipient:</label>\n            <input type=\"text\" class=\"form-control\" id=\"recipient-name\">\n          </div>\n          <div class=\"form-group\">\n            <label for=\"message-text\" class=\"col-form-label\">Message:</label>\n            <textarea class=\"form-control\" id=\"message-text\"></textarea>\n          </div>\n        </form>\n      </div>\n      <div class=\"modal-footer\">\n        <button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Close</button>\n        <button type=\"button\" class=\"btn btn-primary\">Send message</button>\n      </div>\n    </div>\n  </div>\n</div>")
    Output
      tagList(tags$button(type = "button", class = "btn btn-primary", 
          `data-toggle` = "modal", `data-target` = "#exampleModal", 
          `data-whatever` = "@mdo", "Open modal for @mdo"), tags$button(type = "button", 
          class = "btn btn-primary", `data-toggle` = "modal", `data-target` = "#exampleModal", 
          `data-whatever` = "@fat", "Open modal for @fat"), tags$button(type = "button", 
          class = "btn btn-primary", `data-toggle` = "modal", `data-target` = "#exampleModal", 
          `data-whatever` = "@getbootstrap", "Open modal for @getbootstrap"), 
          div(class = "modal fade", id = "exampleModal", tabindex = "-1", 
              `aria-labelledby` = "exampleModalLabel", `aria-hidden` = "true", 
              div(class = "modal-dialog", div(class = "modal-content", 
                  div(class = "modal-header", tags$h5(class = "modal-title", 
                      id = "exampleModalLabel", "New message"), tags$button(type = "button", 
                      class = "close", `data-dismiss` = "modal", `aria-label` = "Close", 
                      tags$span(`aria-hidden` = "true", "&times;"))), 
                  div(class = "modal-body", tags$form(div(class = "form-group", 
                      tags$label(`for` = "recipient-name", class = "col-form-label", 
                        "Recipient:"), tags$input(type = "text", class = "form-control", 
                        id = "recipient-name")), div(class = "form-group", 
                      tags$label(`for` = "message-text", class = "col-form-label", 
                        "Message:"), tags$textarea(class = "form-control", 
                        id = "message-text")))), div(class = "modal-footer", 
                      tags$button(type = "button", class = "btn btn-secondary", 
                        `data-dismiss` = "modal", "Close"), tags$button(type = "button", 
                        class = "btn btn-primary", "Send message"))))))

---

    Code
      html2R(
        "<nav class=\"navbar navbar-expand-lg navbar-light bg-light\">\n  <a class=\"navbar-brand\" href=\"#\">Navbar</a>\n  <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarSupportedContent\" aria-controls=\"navbarSupportedContent\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\n    <span class=\"navbar-toggler-icon\"></span>\n  </button>\n\n  <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">\n    <ul class=\"navbar-nav mr-auto\">\n      <li class=\"nav-item active\">\n        <a class=\"nav-link\" href=\"#\">Home <span class=\"sr-only\">(current)</span></a>\n      </li>\n      <li class=\"nav-item\">\n        <a class=\"nav-link\" href=\"#\">Link</a>\n      </li>\n      <li class=\"nav-item dropdown\">\n        <a class=\"nav-link dropdown-toggle\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n          Dropdown\n        </a>\n        <div class=\"dropdown-menu\" aria-labelledby=\"navbarDropdown\">\n          <a class=\"dropdown-item\" href=\"#\">Action</a>\n          <a class=\"dropdown-item\" href=\"#\">Another action</a>\n          <div class=\"dropdown-divider\"></div>\n          <a class=\"dropdown-item\" href=\"#\">Something else here</a>\n        </div>\n      </li>\n      <li class=\"nav-item\">\n        <a class=\"nav-link disabled\" href=\"#\" tabindex=\"-1\" aria-disabled=\"true\">Disabled</a>\n      </li>\n    </ul>\n    <form class=\"form-inline my-2 my-lg-0\">\n      <input class=\"form-control mr-sm-2\" type=\"search\" placeholder=\"Search\" aria-label=\"Search\">\n      <button class=\"btn btn-outline-success my-2 my-sm-0\" type=\"submit\">Search</button>\n    </form>\n  </div>\n</nav>")
    Output
      tags$nav(class = "navbar navbar-expand-lg navbar-light bg-light", 
          tags$a(class = "navbar-brand", href = "#", "Navbar"), tags$button(class = "navbar-toggler", 
              type = "button", `data-toggle` = "collapse", `data-target` = "#navbarSupportedContent", 
              `aria-controls` = "navbarSupportedContent", `aria-expanded` = "false", 
              `aria-label` = "Toggle navigation", tags$span(class = "navbar-toggler-icon")), 
          div(class = "collapse navbar-collapse", id = "navbarSupportedContent", 
              tags$ul(class = "navbar-nav mr-auto", tags$li(class = "nav-item active", 
                  tags$a(class = "nav-link", href = "#", tags$span(class = "sr-only", 
                      "(current)"))), tags$li(class = "nav-item", tags$a(class = "nav-link", 
                  href = "#", "Link")), tags$li(class = "nav-item dropdown", 
                  tags$a(class = "nav-link dropdown-toggle", href = "#", 
                      id = "navbarDropdown", role = "button", `data-toggle` = "dropdown", 
                      `aria-haspopup` = "true", `aria-expanded` = "false", 
                      "Dropdown"), div(class = "dropdown-menu", `aria-labelledby` = "navbarDropdown", 
                      tags$a(class = "dropdown-item", href = "#", "Action"), 
                      tags$a(class = "dropdown-item", href = "#", "Another action"), 
                      div(class = "dropdown-divider"), tags$a(class = "dropdown-item", 
                        href = "#", "Something else here"))), tags$li(class = "nav-item", 
                  tags$a(class = "nav-link disabled", href = "#", tabindex = "-1", 
                      `aria-disabled` = "true", "Disabled"))), tags$form(class = "form-inline my-2 my-lg-0", 
                  tags$input(class = "form-control mr-sm-2", type = "search", 
                      placeholder = "Search", `aria-label` = "Search"), 
                  tags$button(class = "btn btn-outline-success my-2 my-sm-0", 
                      type = "submit", "Search"))))

---

    Code
      html2R(
        "<div class=\"btn-toolbar\" role=\"toolbar\" aria-label=\"Toolbar with button groups\">\n  <div class=\"btn-group mr-2\" role=\"group\" aria-label=\"First group\">\n    <button type=\"button\" class=\"btn btn-secondary\">1</button>\n    <button type=\"button\" class=\"btn btn-secondary\">2</button>\n    <button type=\"button\" class=\"btn btn-secondary\">3</button>\n    <button type=\"button\" class=\"btn btn-secondary\">4</button>\n  </div>\n  <div class=\"btn-group mr-2\" role=\"group\" aria-label=\"Second group\">\n    <button type=\"button\" class=\"btn btn-secondary\">5</button>\n    <button type=\"button\" class=\"btn btn-secondary\">6</button>\n    <button type=\"button\" class=\"btn btn-secondary\">7</button>\n  </div>\n  <div class=\"btn-group\" role=\"group\" aria-label=\"Third group\">\n    <button type=\"button\" class=\"btn btn-secondary\">8</button>\n  </div>\n</div>")
    Output
      div(class = "btn-toolbar", role = "toolbar", `aria-label` = "Toolbar with button groups", 
          div(class = "btn-group mr-2", role = "group", `aria-label` = "First group", 
              tags$button(type = "button", class = "btn btn-secondary", 
                  "1"), tags$button(type = "button", class = "btn btn-secondary", 
                  "2"), tags$button(type = "button", class = "btn btn-secondary", 
                  "3"), tags$button(type = "button", class = "btn btn-secondary", 
                  "4")), div(class = "btn-group mr-2", role = "group", 
              `aria-label` = "Second group", tags$button(type = "button", 
                  class = "btn btn-secondary", "5"), tags$button(type = "button", 
                  class = "btn btn-secondary", "6"), tags$button(type = "button", 
                  class = "btn btn-secondary", "7")), div(class = "btn-group", 
              role = "group", `aria-label` = "Third group", tags$button(type = "button", 
                  class = "btn btn-secondary", "8")))

---

    Code
      html2R(
        "<div class=\"card\" style=\"width: 18rem;\">\n  <div class=\"card-body\">\n    <h5 class=\"card-title\">Card title</h5>\n    <h6 class=\"card-subtitle mb-2 text-muted\">Card subtitle</h6>\n    <p class=\"card-text\">Some quick example text to build on the card title and make up the bulk of the cards content.</p>\n  <a href=\"#\" class=\"card-link\">Card link</a>\n  <a href=\"#\" class=\"card-link\">Another link</a>\n  </div>\n  </div>")
    Output
      div(class = "card", style = "width: 18rem;", div(class = "card-body", 
          tags$h5(class = "card-title", "Card title"), tags$h6(class = "card-subtitle mb-2 text-muted", 
              "Card subtitle"), tags$p(class = "card-text", "Some quick example text to build on the card title and make up the bulk of the cards content."), 
          tags$a(href = "#", class = "card-link", "Card link"), tags$a(href = "#", 
              class = "card-link", "Another link")))

---

    Code
      html2R(
        "<div class=\"accordion\" id=\"accordionExample\">\n  <div class=\"card\">\n    <div class=\"card-header\" id=\"headingOne\">\n      <h2 class=\"mb-0\">\n        <button class=\"btn btn-link btn-block text-left\" type=\"button\" data-toggle=\"collapse\" data-target=\"#collapseOne\" aria-expanded=\"true\" aria-controls=\"collapseOne\">\n          Collapsible Group Item #1\n        </button>\n      </h2>\n    </div>\n\n    <div id=\"collapseOne\" class=\"collapse show\" aria-labelledby=\"headingOne\" data-parent=\"#accordionExample\">\n      <div class=\"card-body\">\n        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably havent heard of them accusamus labore sustainable VHS.\n</div>\n  </div>\n  </div>\n  <div class=\"card\">\n  <div class=\"card-header\" id=\"headingTwo\">\n  <h2 class=\"mb-0\">\n  <button class=\"btn btn-link btn-block text-left collapsed\" type=\"button\" data-toggle=\"collapse\" data-target=\"#collapseTwo\" aria-expanded=\"false\" aria-controls=\"collapseTwo\">\n  Collapsible Group Item #2\n</button>\n  </h2>\n  </div>\n  <div id=\"collapseTwo\" class=\"collapse\" aria-labelledby=\"headingTwo\" data-parent=\"#accordionExample\">\n  <div class=\"card-body\">\n  Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably havent heard of them accusamus labore sustainable VHS.\n      </div>\n    </div>\n  </div>\n  <div class=\"card\">\n    <div class=\"card-header\" id=\"headingThree\">\n      <h2 class=\"mb-0\">\n        <button class=\"btn btn-link btn-block text-left collapsed\" type=\"button\" data-toggle=\"collapse\" data-target=\"#collapseThree\" aria-expanded=\"false\" aria-controls=\"collapseThree\">\n          Collapsible Group Item #3\n        </button>\n      </h2>\n    </div>\n    <div id=\"collapseThree\" class=\"collapse\" aria-labelledby=\"headingThree\" data-parent=\"#accordionExample\">\n      <div class=\"card-body\">\n        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably havent heard of them accusamus labore sustainable VHS.\n</div>\n  </div>\n  </div>\n  </div>")
    Output
      div(class = "accordion", id = "accordionExample", div(class = "card", 
          div(class = "card-header", id = "headingOne", tags$h2(class = "mb-0", 
              tags$button(class = "btn btn-link btn-block text-left", 
                  type = "button", `data-toggle` = "collapse", `data-target` = "#collapseOne", 
                  `aria-expanded` = "true", `aria-controls` = "collapseOne", 
                  "Collapsible Group Item #1"))), div(id = "collapseOne", 
              class = "collapse show", `aria-labelledby` = "headingOne", 
              `data-parent` = "#accordionExample", div(class = "card-body", 
                  "Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably havent heard of them accusamus labore sustainable VHS."))), 
          div(class = "card", div(class = "card-header", id = "headingTwo", 
              tags$h2(class = "mb-0", tags$button(class = "btn btn-link btn-block text-left collapsed", 
                  type = "button", `data-toggle` = "collapse", `data-target` = "#collapseTwo", 
                  `aria-expanded` = "false", `aria-controls` = "collapseTwo", 
                  "Collapsible Group Item #2"))), div(id = "collapseTwo", 
              class = "collapse", `aria-labelledby` = "headingTwo", 
              `data-parent` = "#accordionExample", div(class = "card-body", 
                  "Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably havent heard of them accusamus labore sustainable VHS."))), 
          div(class = "card", div(class = "card-header", id = "headingThree", 
              tags$h2(class = "mb-0", tags$button(class = "btn btn-link btn-block text-left collapsed", 
                  type = "button", `data-toggle` = "collapse", `data-target` = "#collapseThree", 
                  `aria-expanded` = "false", `aria-controls` = "collapseThree", 
                  "Collapsible Group Item #3"))), div(id = "collapseThree", 
              class = "collapse", `aria-labelledby` = "headingThree", 
              `data-parent` = "#accordionExample", div(class = "card-body", 
                  "Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably havent heard of them accusamus labore sustainable VHS."))))

---

    Code
      html2R(
        "<div id=\"carouselExampleIndicators\" class=\"carousel slide\" data-ride=\"carousel\">\n  <ol class=\"carousel-indicators\">\n    <li data-target=\"#carouselExampleIndicators\" data-slide-to=\"0\" class=\"active\"></li>\n    <li data-target=\"#carouselExampleIndicators\" data-slide-to=\"1\"></li>\n    <li data-target=\"#carouselExampleIndicators\" data-slide-to=\"2\"></li>\n  </ol>\n  <div class=\"carousel-inner\">\n    <div class=\"carousel-item active\">\n      <img src=\"...\" class=\"d-block w-100\" alt=\"...\">\n    </div>\n    <div class=\"carousel-item\">\n      <img src=\"...\" class=\"d-block w-100\" alt=\"...\">\n    </div>\n    <div class=\"carousel-item\">\n      <img src=\"...\" class=\"d-block w-100\" alt=\"...\">\n    </div>\n  </div>\n  <a class=\"carousel-control-prev\" href=\"#carouselExampleIndicators\" role=\"button\" data-slide=\"prev\">\n    <span class=\"carousel-control-prev-icon\" aria-hidden=\"true\"></span>\n    <span class=\"sr-only\">Previous</span>\n  </a>\n  <a class=\"carousel-control-next\" href=\"#carouselExampleIndicators\" role=\"button\" data-slide=\"next\">\n    <span class=\"carousel-control-next-icon\" aria-hidden=\"true\"></span>\n    <span class=\"sr-only\">Next</span>\n  </a>\n  </div>")
    Output
      div(id = "carouselExampleIndicators", class = "carousel slide", 
          `data-ride` = "carousel", tags$ol(class = "carousel-indicators", 
              tags$li(`data-target` = "#carouselExampleIndicators", 
                  `slide-to` = "0", class = "active"), tags$li(`data-target` = "#carouselExampleIndicators", 
                  `slide-to` = "1"), tags$li(`data-target` = "#carouselExampleIndicators", 
                  `slide-to` = "2")), div(class = "carousel-inner", 
              div(class = "carousel-item active", tags$img(src = "...", 
                  class = "d-block w-100", alt = "...")), div(class = "carousel-item", 
                  tags$img(src = "...", class = "d-block w-100", alt = "...")), 
              div(class = "carousel-item", tags$img(src = "...", class = "d-block w-100", 
                  alt = "..."))), tags$a(class = "carousel-control-prev", 
              href = "#carouselExampleIndicators", role = "button", 
              `data-slide` = "prev", tags$span(class = "carousel-control-prev-icon", 
                  `aria-hidden` = "true"), tags$span(class = "sr-only", 
                  "Previous")), tags$a(class = "carousel-control-next", 
              href = "#carouselExampleIndicators", role = "button", 
              `data-slide` = "next", tags$span(class = "carousel-control-next-icon", 
                  `aria-hidden` = "true"), tags$span(class = "sr-only", 
                  "Next")))

---

    Code
      html2R(
        "<div>\n<div class='btn-group'>\n  <select id=\"picker1\" class=\"selectpicker\" \n  data-style=\"btn btn-outline-dark btn-sm rounded-0 border-right-0\">\n    <optgroup label=\"Picnic\">\n      <option>Mustard</option>\n      <option>Ketchup</option>\n      <option>Relish</option>\n    </optgroup>\n  </select>\n  <select id=\"picker2\" class=\"selectpicker\" data-style=\"btn btn-outline-dark btn-sm rounded-0\" data-width='fit'>\n    <optgroup label=\"Camping\">\n      <option>Tent</option>\n      <option>Flashlight</option>\n      <option>Toilet Paper</option>\n    </optgroup>\n  </select>\n  <button class=\"btn btn-outline-dark btn-sm rounded-0\"></button>\n</div>\n</div>")
    Output
      div(div(class = "btn-group", tags$select(id = "picker1", class = "selectpicker", 
          `data-style` = "btn btn-outline-dark btn-sm rounded-0 border-right-0", 
          tags$optgroup(label = "Picnic", tags$option("Mustard"), tags$option("Ketchup"), 
              tags$option("Relish"))), tags$select(id = "picker2", 
          class = "selectpicker", `data-style` = "btn btn-outline-dark btn-sm rounded-0", 
          `data-width` = "fit", tags$optgroup(label = "Camping", tags$option("Tent"), 
              tags$option("Flashlight"), tags$option("Toilet Paper"))), 
          tags$button(class = "btn btn-outline-dark btn-sm rounded-0")))

---

    Code
      html2R(
        "<form class=\"form-signin\">\n  <h1 class=\"h3 mb-3 font-weight-normal\">Please sign in</h1>\n  <label for=\"inputEmail\" class=\"sr-only\">Email address</label>\n  <input type=\"email\" id=\"inputEmail\" class=\"form-control\" placeholder=\"Email address\" required autofocus>\n  <label for=\"inputPassword\" class=\"sr-only\">Password</label>\n  <input type=\"password\" id=\"inputPassword\" class=\"form-control\" placeholder=\"Password\" required>\n  <div class=\"checkbox mb-3\">\n  <label>\n  <input type=\"checkbox\" value=\"remember-me\"> Remember me\n</label>\n  </div>\n  <button class=\"btn btn-lg btn-primary btn-block\" type=\"submit\">Sign in</button>\n  <p class=\"mt-5 mb-3 text-muted\">2017-2020</p>\n  </form>")
    Output
      tags$form(class = "form-signin", tags$h1(class = "h3 mb-3 font-weight-normal", 
          "Please sign in"), tags$label(`for` = "inputEmail", class = "sr-only", 
          "Email address"), tags$input(type = "email", id = "inputEmail", 
          class = "form-control", placeholder = "Email address", required = "required", 
          autofocus = "autofocus"), tags$label(`for` = "inputPassword", 
          class = "sr-only", "Password"), tags$input(type = "password", 
          id = "inputPassword", class = "form-control", placeholder = "Password", 
          required = "required"), div(class = "checkbox mb-3", tags$label(tags$input(type = "checkbox", 
          value = "remember-me"), "Remember me")), tags$button(class = "btn btn-lg btn-primary btn-block", 
          type = "submit", "Sign in"), tags$p(class = "mt-5 mb-3 text-muted", 
          "2017-2020"))

---

    Code
      html2R("<div id='one' class='robot' data-dropdown_letters='1'>dsfssI</div>")
    Output
      div(id = "one", class = "robot", `data-dropdown_letters` = "1", 
          "dsfssI")

