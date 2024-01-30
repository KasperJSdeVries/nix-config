{
  services.redshift = {
    enable = true;

    temperature = {
      day = 5700;
      night = 3500;
    };

    provider = "manual";

    latitude = 52.0116;
    longitude = 4.3571;

    settings = {
      redshift = {
        gamma = 0.8;

        adjustment-method = "randr";
      };
      randr = {
        screen = 0;
      };
    };
  };
}
