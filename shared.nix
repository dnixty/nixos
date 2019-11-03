{
  user = {
    username = "dnixty";
    name = "Dominik Stodolny";
    email = "dominik@stodolny.org";
  };
  ports = {
    wireguard = 53898;
    sshd = 65130;
  };
  extraHosts = ''
    10.206.94.135 njord.vpn.dnixty.com
    10.206.94.35 tyr.vpn.dnixty.com
    10.206.94.130 heimdall.vpn.dnixty.com

    209.250.247.32 njord
    192.168.1.18 asgard
    192.168.1.1 niflheim
    192.168.1.118 midgard
  '';
  hosts = {
    njord = "209.250.247.32";
    asgard = "192.168.1.18";
    niflheim = "192.168.1.1";
    midgard = "192.168.1.118";
  };
  wireguard = {
    interfaces = {
      njord.ips = [ "10.206.94.135/24" ];
      tyr.ips = [ "10.206.94.35/24" ];
      heimdall.ips = [ "10.206.94.130/24" ];
    };
    peers = {
      njord = {
        publicKey = "GqfxaEbt1i6UYavN9nv81Q+Pxh701izAZpbl6hq0P2U=";
        allowedIPs = [ "10.206.94.135/32" ];
        endpoint = "njord.dnixty.com:53898";
        persistentKeepalive = 25;
      };
      tyr = {
        publicKey = "VgEoB6f8pSvgQsuyhB9wLn2V7iBPLN54UZDkW1cZX38=";
        allowedIPs = [ "10.206.94.35/32" ];
      };
      heimdall = {
        publicKey = "gH1cBycyLz5+i/7P023swUA22oIr1MPZCOp/FjHZexA=";
        allowedIPs = [ "10.206.94.130/32" ];
      };
    };
  };
  ssh_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgm5K5x4qnscueCaynv0mtg90SfY61NJW64/mwLCbPRQpQ4wTRJcF1TaDDWMEcFohPLZKaxMJlCQ/4AHHP+WHiVYpV8COfNEkFaLu8mOv68asxcikTO7l6XSQBQvEYtYVUM/nz/Fua/ksYluiWeIA8gJy0tw7DrPaxVqAxi4eo+0qjqs0IPLwsuMb553Ftl989svd8rvBgU3iLmI6r78+wjC4Gv7quzFB1L18LjQY05ZEG5S+q3VqqZin8l37fNP5Na71OwCstILoa50Yppk75j0/pX3c3yvqbT+kKdpWRzgbevcTrLKZuF/abyGP/JvAU6OtCQhrJer3e/qi0MnAX cardno:00006C5C"
  ];
}
