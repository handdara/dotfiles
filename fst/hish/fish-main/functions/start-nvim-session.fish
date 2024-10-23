begin start-nvim-session
# nvim -S (begin; fd -e vim . ; fd -e vim . ~/.local/share/nvim/sessions ; end | fzf)
begin
    fd -e vim .
    fd -e vim . ~/.local/share/nvim/sessions
end | echo
end
