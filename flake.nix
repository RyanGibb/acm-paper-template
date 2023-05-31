{
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      {
        defaultPackage =
          let pkgs = nixpkgs.legacyPackages.${system}; in
          pkgs.stdenv.mkDerivation {
            name = "paper-template";

            src = self;

            buildInputs = with pkgs; [
              (texlive.combine {
                inherit (texlive)
                scheme-basic
                acmart
                amscls
                amsfonts
                amsmath
                blindtext
                booktabs
                caption
                comment
                cm
                cmap
                doclicense
                draftwatermark
                environ
                etoolbox
                fancyhdr
                float
                fontaxes
                geometry
                graphics
                hyperref
                hyperxmp
                iftex
                ifmtarg
                inconsolata
                libertine
                microtype
                mmap
                ms
                mweights
                natbib
                ncctools
                newtx
                oberdiek
                pdftex
                preprint
                refcount
                setspace
                textcase
                totpages
                trimspaces
                upquote
                url
                xcolor
                xkeyval
                xstring;
              })
            ];

            installPhase = ''
              mkdir $out
              cp *.pdf $out/
            '';
          };
      }
    );
}
