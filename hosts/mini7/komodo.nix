{
  pkgs,
  config,
  ...
}: {
  systemd.services.komodo-periphery = {
    description = "Komodo Periphery daemon";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];

    path = with pkgs; [
      bash
      docker
      git
      komodo
      sops
      zsh
    ];
    serviceConfig = {
      ExecStart = "${pkgs.komodo}/bin/periphery";
      Restart = "on-failure";
      User = config.my.username;
      Environment = [
        "PERIPHERY_SSL_ENABLED=false"
        "PERIPHERY_PORT=8899"
        "PERIPHERY_ROOT_DIRECTORY=/home/${config.my.username}/container/setup"
        "DOCKER_DATA=/home/${config.my.username}/container/data"
      ];
    };
  };
}
