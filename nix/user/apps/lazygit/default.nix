{ ... }: {
  home.file.".config/lazygit/config.yml".text = ''
    os:
      #editPreset: 'nvim-remote'
      edit: 'nvr --remote-wait-silent {{filename}}'
      editAtLine: 'nvr --remote-wait-silent --line={{line}} {{filename}}'
      editAtLineAndWait: 'nvr --remote-wait-silent --block --line={{line}} {{filename}}'
      editInTerminal: true
      openDirInEditor: 'nvr --remote-wait-silent {{dir}}'
  '';
}
