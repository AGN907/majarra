{
  nawa.services._.kanata = {
    nixos = {
      services.kanata = {
        enable = true;
        keyboards.default = {
          devices = [ "/dev/input/by-id/usb-SONiX_USB_DEVICE-event-kbd" ];
          config = "
            (defsrc
              caps
            )

            (defalias
              escctrl (tap-hold 100 100 esc lctrl)
            )

            (deflayer base
              @escctrl
            )";
        };
      };
    };
  };
}
