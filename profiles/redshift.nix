{ config, pkgs, ... }:

{
  services.redshift = {
    enable = true;
    latitude = "51.5094";
    longitude = "0.1365";
    temperature.night = 4000;
    brightness.night = "0.8";
  };
}
