# Iridis Alpha Theory
A deeper-than-is-possibly-sane dive into the workings of [Iridis Alpha](https://github.com/mwenge/iridisalpha/).

[<img height=360 src="https://github.com/mwenge/iatheory/raw/main/docs/images/cover_front.png">](https://github.com/mwenge/iatheory/raw/main/out/IridisAlphaTheory.pdf)

Work-in-progress is available for free as a [Scrapbook Edition](https://github.com/mwenge/iatheory/raw/main/out/IridisAlphaTheory.pdf).

You can [gift what you want](https://www.paypal.com/paypalme/hoganrobert).

You can even [sponsor future work](https://github.com/sponsors/mwenge/).

## A Peek Inside
<img height=460 src="https://github.com/mwenge/iatheory/raw/main/docs/images/page-1.png"><img height=460 src="https://github.com/mwenge/iatheory/raw/main/docs/images/page-2.png">

<img height=460 src="https://github.com/mwenge/iatheory/raw/main/docs/images/page-3.png"><img height=460 src="https://github.com/mwenge/iatheory/raw/main/docs/images/page-4.png">

## How to build (Linux)
The build system and structure is based on 'The Book of CP-System' by Fabien Sanglard, of which this repository is a fork.

- Setup env
```
cp src/fonts ~/.fonts
fc-cache -f -v
sudo apt-get update
sudo apt install -y golang-go
go mod init "image/draw"
go get golang.org/x/image/draw
sudo add-apt-repository universe
sudo add-apt-repository ppa:inkscape.dev/stable
sudo apt-get update
sudo apt install inkscape
sudo apt install -y texlive-full
```

- Build
```
./make.sh release
```

## How to build (Windows)

- Install WSL1/WSL2
- Follow Linux steps.

## How to build (MacOS X)
- Install fonts (in `src/fonts` folder)
- Get MacTeX.
- Install golang (https://golang.org/doc/install)
- Install Inkscape > v1.0
- Symlink inkscape binary to `/usr/local/bin` or add it to your PATH
- Get build system dependencies 
```
go mod init "image/draw"
go get golang.org/x/image/draw
```
- Build
```
./make.sh release
```



### Debug mode

Building is slow when using 300dpi assets. To develop, the build system generates low dpi assets. 
Debug is the default mode.

```
./make.sh debug
```

### Force asset regeneration
```
./make.sh debug|release -f
```

### Poor typesetting

If upon compilation the typesetting is "off" with blank pages, it may be that the wrong version of TexLive is used to compile. Run the following command and make sure you have at least version 2020.

```
$ tex --version
TeX 3.141592653 (TeX Live 2022)
```

This book is verified to compile properly with TexLive 2020, 2021, and 2022. In case you have an older version, use the following steps to install the lastest.

[Uninstall TexLive](https://puttym.github.io/update-texlive)

[Download TexLive NetInstall](https://www.tug.org/texlive/acquire-netinstall.html)

[Install TexLive](https://www.tug.org/texlive/quickinstall.html)
