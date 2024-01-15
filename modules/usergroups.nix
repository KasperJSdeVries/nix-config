{username, ...}: {
  users = {
    mutableUsers = true;

    groups = {
      ${username} = {};
    };

    users.${username} = {
      home = "/home/${username}";
      isNormalUser = true;
      extraGroups = [
        username
        "users"
        "wheel"
        "networkmanager"
        "pcscd"
      ];
    };
  };

  security.sudo.extraRules = [
    {
      users = [username];
      commands = [
        {
          command = "/run/current-system/sw/bin/nix-store";
          options = ["NOPASSWD"];
        }
        {
          command = "/run/current-system/sw/bin/nix-copy-closure";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
