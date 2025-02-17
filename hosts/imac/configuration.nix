# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  ...
}:

let
  user = "jlou2u";
  keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMiQj3fB0odhdbTVP2sE/XPp3KyxA7nqTbVF9VOXP5zm" ];
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command flakes" ];
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Better support for general peripherals
    libinput.enable = true;
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    # Turn Caps Lock into Ctrl
    options = "ctrl:nocaps";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.pam.sshAgentAuth.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  stylix = {
    enable = true;
    image = ./wallpaper.png;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/summerfruit-light.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-light.yaml";
    fonts = {
      # monospace = "";
      # sansSerif = "";
      # serif = "";
      sizes = {
        applications = 14;
        desktop = 8;
      };
    };
  };

  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    ${user} = {
      isNormalUser = true;
      description = "Justin Lewis";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = with pkgs; [
        thunderbird
        home-manager
      ];
      openssh.authorizedKeys.keys = keys;
    };
    ltprod = {
      isNormalUser = true;
      description = "LT Productions";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages =
        with pkgs;
        [
        ];
      openssh.authorizedKeys.keys = keys;
    };
  };

  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            command = "${pkgs.systemd}/bin/reboot";
            options = [ "NOPASSWD" ];
          }
        ];
        groups = [ "wheel" ];
      }
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # see https://github.com/NixOS/nixpkgs/issues/380196
  nixpkgs.overlays = [
    (final: prev: {
      lldb = prev.lldb.overrideAttrs {
        dontCheckForBrokenSymlinks = true;
      };
    })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    coreutils
    devenv
    eza
    fzf
    git
    gnome-tweaks
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    lact
    logiops
    nix-index
    pciutils
    power-profiles-daemon
    vim
    whitesur-gtk-theme
    wget
  ];

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibername.enable = false;
    hybrid-sleep.enable = false;
  };

  systemd.services.openai = {
    enable = true;
    description = "Set OpenAI API Key";
    environment = {
      OPENAI_API_KEY = "TODO";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # Create systemd service
  # systemd.services.logiops = {
  #   description = "An unofficial userspace driver for HID++ Logitech devices";
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = "${pkgs.logiops}/bin/logid";
  #   };
  # };

  # # Configuration for logiops
  # environment.etc."logid.cfg".text = ''
  #   devices: ({
  #     name: "Marathon Mouse/Performance Plus M705";
  #     smartshift: {
  #       on: true;
  #       threshold: 12;
  #     };
  #     hiresscroll: {
  #       hires: false;
  #       target: false;
  #     };
  #     dpi: 1200;
  #   });
  # '';

  programs.dconf.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
    };
  };

  # List services that you want to enable:

  services.xserver.imwheel = {
    enable = true;
    rules = {
      ".*" = ''
        None,      Up,   Button4, 4
        None,      Down, Button5, 4
        Shift_L,   Up,   Shift_L|Button4, 2
        Shift_L,   Down, Shift_L|Button5, 2
        Control_L, Up,   Control_L|Button4
        Control_L, Down, Control_L|Button5
      '';
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
