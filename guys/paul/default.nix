{...}: {
  my = {
    git = {
      userName = "Snoilt";
      userEmail = "paul@oellers.net";
    };
    ssh.authorizedKeys = [
      # todo
    ];
  };

  environment.variables = {
    TUCKR_CUSTOM_TARGETS = "paul";
  };
}
