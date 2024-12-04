---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "tex"
local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local extras = require 'luasnip.extras'
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt

local function mkBegEnd(args)
    local bbeg = [[
        \begin{{{1}{2}}}
            {3}
        \end{{{4}{5}}}
        ]]
    local e1, e2, body
    if args.env then
        e1 = t(args.env)
        body = i(1)
        e2 = t(args.env)
    else
        e1 = i(1)
        body = i(2)
        e2 = rep(1)
    end
    local star
    if args.starred == true then star = '*'; else star = ''; end
    return s(args.trig, fmt(bbeg, { e1, t(star), body, e2, t(star) }))
end

local bNewCmd = [[\newcommand{{\{1}}}{{{2}}}]]
local bNomen = [[\nomenclature{{${1}$}}{{{2}}}]]

ls.add_snippets("tex", {
    mkBegEnd { trig = 'beg', },
    mkBegEnd { trig = 'equ', env = "equation" },
    mkBegEnd { trig = 'sequ', env = "equation", starred = true },
    mkBegEnd { trig = 'ali', env = "align" },
    mkBegEnd { trig = 'sali', env = "align", starred = true },
    mkBegEnd { trig = 'lem', env = "lemma" },
    mkBegEnd { trig = 'def', env = "defn" },
    mkBegEnd { trig = 'sdef', env = "defn", starred = true },
    mkBegEnd { trig = 'thm', env = "corollary" },
    mkBegEnd { trig = 'cor', env = "theorem" },
    mkBegEnd { trig = 'prop', env = "prop" },
    mkBegEnd { trig = 'sprop', env = "prop", starred = true },
    mkBegEnd { trig = 'note', env = "note" },
    mkBegEnd { trig = 'snote', env = "note", starred = true },
    mkBegEnd { trig = 'remk', env = "remk" },
    mkBegEnd { trig = 'sremk', env = "remk", starred = true },
    mkBegEnd { trig = 'exmp', env = "exmp" },
    mkBegEnd { trig = 'sexmp', env = "exmp", starred = true },
    s("newcommand", fmt(bNewCmd, { i(1, 'cmd_name'), i(2) })),
    s("nomencl-item", fmt(bNomen, { i(1), i(2, 'Description') })),
    s("sec", { t "\\section{", i(1), t { '}', '' }, i(0) }),
    s("sec-star", { t "\\section*{", i(1), t { '}', '' }, i(0) }),
    s("sse", { t "\\subsection{", i(1), t { '}', '' }, i(0) }),
    s("sse-star", { t "\\subsection*{", i(1), t { '}', '' }, i(0) }),
    s("sss", { t "\\subsubsection{", i(1), t { '}', '' }, i(0) }),
    s("sss-star", { t "\\subsubsection*{", i(1), t { '}', '' }, i(0) }),
    s("ss3", { t "\\subsubsubsection{", i(1), t { '}', '' }, i(0) }),
    s("ss3-star", { t "\\subsubsubsection*{", i(1), t { '}', '' }, i(0) }),
    s('lab', { t "\\label{", i(1), t "}" }),
})
