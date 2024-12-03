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

local bbeg = [[
\begin{{{2}{1}}}
    {3}
\end{{{4}{5}}}
]]
local function mkBegEnd(trigger, env, useStar, env2)
    local tStar
    if useStar or false then
        tStar = t '*';
    else
        tStar = t '';
    end
    return s(trigger, fmt(bbeg, { tStar, env, i(0), env2 or env, tStar }))
end

local bNewCmd = [[\newcommand{{\{1}}}{{{2}}}]]

local bNomen = [[\nomenclature{{${1}$}}{{{2}}}]]

ls.add_snippets("tex", {
    mkBegEnd('beg', i(1), false, rep(1)),
    mkBegEnd('equ', t "equation"),
    mkBegEnd('sequ', t "equation", true),
    mkBegEnd('ali', t "align"),
    mkBegEnd('sali', t "align", true),
    mkBegEnd('lem', t "lemma"),
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
})
