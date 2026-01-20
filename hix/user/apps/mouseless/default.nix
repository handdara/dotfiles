{ ... }: {
  home.file = {
    ".config/mouseless/config.yaml".text = ''
      # the default speed for mouse movement and scrolling
      mouseLoopInterval: 100
      mouseAccelerationTime: 0
      baseMouseSpeed: 1500
      baseScrollSpeed: 40.0
      # the rest of the config defines the layers with their bindings
      layers:
        # the first layer is active at start
        - name: initial
          bindings:
            # when tab is held and another key pressed, activate mouse layer
            tab: tap-hold-next tab ; toggle-layer mouse ; 500
            # when a is held for 300ms, activate mouse layer
            # a: tap-hold a ; toggle-layer mouse ; 300
        # a layer for mouse movement
        - name: mouse
          # when true, keys that are not mapped keep their original meaning
          passThrough: true
          bindings:
            # quit mouse layer
            esc: layer initial
            # keep the mouse layer active
            space: layer mouse
            h: move -1  0
            j: move  0  0.64
            k: move  0 -0.64
            l: move  1  0
            left: move -1  0
            down: move  0  0.64
            up: move  0 -0.64
            right: move  1  0
            y: move -50 0
            u: move  0  50
            i: move  0 -50
            o: move  50 0
            p: scroll up
            n: scroll down
            rightshift: speed 2
            rightctrl: speed 0.5
            rightalt: speed 0.1
            leftshift: speed 2
            leftctrl: speed 0.5
            leftalt: speed 0.1
            f: button left
            e: button middle
            d: button right
    '';
  };
}
