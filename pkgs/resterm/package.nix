{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "resterm";
  version = "0.15.0";

  src = fetchFromGitHub {
    owner = "unkn0wn-root";
    repo = "resterm";
    rev = "v${version}";
    hash = "sha256-ip/0QKMK+/wbc9O3yTP2AEUgV2DJN92LmCq47YFYrhk=";
  };

  vendorHash = "sha256-E/Y4kW5xy7YamUP5bxFmDCAK6RqiqGN7DpEPG1MaCHc=";

  ldflags = [ "-s" "-w" ];

  meta = {
    description = "Terminal API client for HTTP/GraphQL/gRPC with support for SSH tunnels, WebSockets, SSE, workflows, profiling, OpenAPI and response diffs";
    homepage = "https://github.com/unkn0wn-root/resterm";
    changelog = "https://github.com/unkn0wn-root/resterm/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "resterm";
  };
}
