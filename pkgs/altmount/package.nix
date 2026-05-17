{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "altmount";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "javi11";
    repo = "altmount";
    rev = "v${version}";
    hash = "sha256-l9gNsm3e5LoJdGfxOHl/QpZYKYRzCYvePyJHUHEyLWM=";
  };

  vendorHash = "sha256-/EJI+a9iCRecnk03Ug6MS8uyVFb1x6p9nQRYpbEhSvM=";

  subPackages = [ "cmd/altmount" ];

  ldflags = [ "-s" "-w" ];

  meta = {
    description = "Usenet virtual fs";
    homepage = "https://github.com/javi11/altmount";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "altmount";
  };
}
