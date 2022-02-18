# The Book of CP-1

A study of the revolutionary hardware used by Capcom from 1989 to 1995 to release breath-taking games such as Street Fighter II, Final Fight, and 
Ghouls 'n Ghosts.

The source code is open-source but I retain ownership of all drawings. They are only provided here so the project can be compiled.

## How to build (MacOS X)

- Install fonts (in `cover` folder)
- Get MacTeX.
- Install golang (https://golang.org/doc/install)
- Install Inkscape > v1.0
- Get build system dependencies 
```
go mod init "image/draw"
go get golang.org/x/image/draw
```
- Build
```
go run build.go release
```

## How to build (Linux)

- Setup env
```
unzip cover/font.zip -d ~/.fonts
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
go run build.go release
```

### Debug mode

Building is slow when using 300dpi assets. To develop, the build system generates low dpi assets. 
Debug is the default mode.

```
go run build.go
```

### Force asset regeneration
```
go run build.go debug|release -f
```