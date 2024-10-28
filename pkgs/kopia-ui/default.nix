{ fetchFromGitHub, pkgs }:

pkgs.buildGoModule rec {
  pname = "kopia-ui";
  version = "0.17.0";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Bqy9eFUvUgSdyChzh52qqPVvMi+3ad01koxVgnibbLk=";
  };

  vendorHash = "sha256-/NMp64JeCQjCcEYkE6lYzu/E+irTcwkmDCJhB04ALFY=";

  doCheck = false;

  subPackages = [ "." ];

  ldflags = [
    "-X github.com/kopia/kopia/repo.BuildVersion=${version}"
    "-X github.com/kopia/kopia/repo.BuildInfo=${src.rev}"
  ];

  buildPhase = ''
    go mod vendor
    make goreleaser
    make kopia-ui
  '';
}
