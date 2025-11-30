{pkgs, ...}: {
    home.packages = [pkgs.lazygit];
    home.file.".config/lazygit/config.yml".text = ''
        os:
          editPreset: 'nvim-remote'
          #edit: 'myeditor {{filename}}'
          #editAtLine: 'myeditor --line={{line}} {{filename}}'
          #editAtLineAndWait: 'myeditor --block --line={{line}} {{filename}}'
          #editInTerminal: true
          #openDirInEditor: 'myeditor {{dir}}'
    '';
}
