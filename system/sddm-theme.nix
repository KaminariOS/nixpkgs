{
  stdenv,
  fetchFromGitHub,
  fetchgit,
}: {
  sddm-sugar-candy = stdenv.mkDerivation {
    pname = "sddm-sugar-candy";
    version = "1.2";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-candy
    '';
    src = fetchFromGitHub {
      owner = "Kangie";
      repo = "sddm-sugar-candy";
      rev = "d31dbf58286ecdcd3a490cd0c9d9ba2f15c26920";
      sha256 = "sha256-HMlzUyRvXvzjaeq4FDxsHZga1zsn1w2Ln7SpctqjWk8=";
    };
  };
  sddm-clairvoyance = stdenv.mkDerivation rec {
    pname = "sddm-clairvoyance";
    version = "1.2";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/clairvoyance
    '';
    src = fetchFromGitHub {
      owner = "eayus";
      repo = "sddm-theme-clairvoyance";
      rev = "dfc5984ff8f4a0049190da8c6173ba5667904487";
      sha256 = "13z78i6si799k3pdf2cvmplhv7n1wbpwlsp708nl6gmhdsj51i81";
    };
  };
  sddm-sugar-dark = stdenv.mkDerivation rec {
    pname = "sddm-sugar-dark-theme";
    version = "1.2";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-dark
    '';
    src = fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "v${version}";
      sha256 = "0gx0am7vq1ywaw2rm1p015x90b75ccqxnb1sz3wy8yjl27v82yhb";
    };
  };
}
