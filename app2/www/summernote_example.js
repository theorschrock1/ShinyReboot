$('#hi').summernote({
              hint: {
                  mentions: ['jayden', 'sam', 'alvin', 'david'],
                  match: /\B@(\w*)$/,
                  search: function (keyword, callback) {
                      callback($.grep(this.mentions, function (item) {
                          return item.indexOf(keyword) === 0;
                      }));
                  },
                  content: function (item) {
                   var htmlString= `<span contenteditable='false'> <code>&lt;${item}&gt;</code></span>&nbsp;`;
                   $('#hi').summernote('pasteHTML',htmlString);


                    return "";
                  }
              }
          });

 $('#testinTi').focus(function(){
                  console.log("Hi");
                });
