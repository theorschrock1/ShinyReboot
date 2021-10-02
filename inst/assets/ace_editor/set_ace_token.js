Shiny.addCustomMessageHandler('ace-clear-selection',function(id){
editor = ace.edit(id);
console.log('ace-clear-selection');
editor.selection.clearSelection();

});

Shiny.addCustomMessageHandler('set-ace-tokens',function(params){
console.log(params.id);
console.log(params.tokens);
var tokens=params.tokens;

this.editor = ace.edit(params.id);
var session = this.editor.session;
this.language = this.language || 'r';

var RHighlightRules = ace.require("ace/mode/r_highlight_rules").RHighlightRules;

session.setMode('ace/mode/' + this.language, function() {
    session.$mode.$highlightRules= new RHighlightRules();
    var rules = session.$mode.$highlightRules.getRules();
    for (var stateName in rules) {
        if (Object.prototype.hasOwnProperty.call( rules, stateName)) {
    tokens.map(token=> rules[stateName].unshift(token));
        }
    }
    // force recreation of tokenizer
    session.$mode.$tokenizer = null;
    session.bgTokenizer.setTokenizer(session.$mode.getTokenizer());
    // force re-highlight whole document
    session.bgTokenizer.start(0);
});

});


