{
  lib,
  rustPlatform,
  fetchFromGitHub,
  testers,
  television,
  nix-update-script,
}:
rustPlatform.buildRustPackage rec {
  pname = "television";
  version = "0.11.5";

  src = fetchFromGitHub {
    owner = "alexpasmantier";
    repo = "television";
    tag = version;
    hash = "sha256-2Yt98ZtoTHqCtyqGuPL583NBe2CHI+9PIyO0fnonM4E=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-+T/WC7jq6qra9qxQ+mR929LQavETHTtAGHKWm81cwNU=";

  passthru = {
    tests.version = testers.testVersion {
      package = television;
      command = "XDG_DATA_HOME=$TMPDIR tv --version";
    };
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Blazingly fast general purpose fuzzy finder TUI";
    longDescription = ''
      Television is a fast and versatile fuzzy finder TUI.
      It lets you quickly search through any kind of data source (files, git
      repositories, environment variables, docker images, you name it) using a
      fuzzy matching algorithm and is designed to be easily extensible.
    '';
    homepage = "https://github.com/alexpasmantier/television";
    changelog = "https://github.com/alexpasmantier/television/releases/tag/${version}";
    license = lib.licenses.mit;
    mainProgram = "tv";
    maintainers = with lib.maintainers; [
      louis-thevenet
      getchoo
    ];
  };
}
