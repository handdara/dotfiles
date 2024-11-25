{...}:
let
    zj_sessionizer = builtins.fetchurl {
        url = "https://github.com/laperlej/zellij-sessionizer/releases/download/v0.4.3/zellij-sessionizer.wasm";
        sha256 = "sha256:0d43jhlhm7p8pvd8kcylfbfy3dahr8q4yngpnjyqivapwip9csq0";
    };
in
{
    programs.zellij = {
        enable = true;
        enableFishIntegration = false;
        enableBashIntegration = false;
        enableZshIntegration = false;
    };
    home.file = {
        ".config/zellij/config.kdl".source = ../../../../snd/zellij/config.kdl;
        ".config/zellij/layouts".source = ../../../../snd/zellij/layouts;
        ".config/zellij/plugins/zellij-sessionizer.wasm".source = "${zj_sessionizer}";
    };
}
