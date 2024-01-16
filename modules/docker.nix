{
  virtualisation.docker = {
    rootless = {
      enable = true;
      setSocketVariable = true;
    };

    logDriver = "json-file";
    daemon.settings = {
      log-opts = {
        max-file = "5";
        max-size = "10m";
      };
    };
  };
}
