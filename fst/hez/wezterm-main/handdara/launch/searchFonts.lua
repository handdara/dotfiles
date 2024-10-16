local function mkCmd(xclipFound)
  local label = 'search through system fonts'
  -- :todo: for some reason saving into xclip doesn't work, need to debug
  -- if xclipFound then
  if false then
    return {
      label = label,
      args = { 'fish', '-c', 'nix-shell -p fontconfig --run "fc-list | fzf | xclip"' } 
      -- args = { 'fish', '-c', 'nix-shell -p fontconfig --run "fc-list | fzf | xclip -selection clipboard"' } 
    }
  else 
    return {
      label = label,
      args = { 'fish', '-c', 'nix-shell -p fontconfig --run "fc-list | fzf > ~/.local/share/searchFont.out"' } 
    }
  end
end

return {mkCmd = mkCmd} 
