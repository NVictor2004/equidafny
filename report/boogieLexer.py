from pygments.lexer import RegexLexer, words, bygroups
from pygments.token import *

KEYWORDS = ("var", "procedure", "modifies", "if", "call", "requires", "ensures")
OPERATORS = ("<=", "<", ":=", "+", "*", "==")

class CustomLexer(RegexLexer):
    name = 'Boogie'
    filenames = ['*.bpl']

    tokens = {
        'root': [
            (r"\s+", Whitespace),
            (words(KEYWORDS, suffix=r'\b'), Keyword),
            (words(OPERATORS), Operator),
            (r"int", Keyword.Type),
            (r"\d+", Number),
            (r"\b([A-Za-z_?\'][A-Za-z0-9_?\']*)(\()", bygroups(Name.Function, Punctuation)),
            (r"\b[A-Za-z_?\'][A-Za-z0-9_?\']*\b", Name),
            (r"[\.\(\)\[\]\{\},;:]", Punctuation),
        ]
    }
