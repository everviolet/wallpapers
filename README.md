<h3 align="center">
	<img src="https://github.com/everviolet/.github/raw/main/assets/logo-circle.png" width="100" alt="Logo"/><br/>
	Wallpapers
</h3>

<h6 align="center">
  <a href="#usage">Usage</a>
  ·
  <a href="#previews">Previews</a>
  ·
  <a href="#credits">Credits</a>
</h6>

<p align="center">
	<a href="https://github.com/everviolet/wallpapers/stargazers"><img src="https://img.shields.io/github/stars/everviolet/wallpapers?style=for-the-badge&colorA=313B40&colorB=DBBC7F"></a>
	<a href="https://github.com/everviolet/wallpapers/issues"><img src="https://img.shields.io/github/issues/everviolet/wallpapers?style=for-the-badge&colorA=313B40&colorB=E69875"></a>
	<a href="https://github.com/everviolet/wallpapers/contributors"><img src="https://img.shields.io/github/contributors/everviolet/wallpapers?style=for-the-badge&colorA=313B40&colorB=97C9C3"></a>
</p>

---

This repo provides a curated collection of wallpapers that are hand-picked for
high resolution displays. Each wallpaper has been (or will be!) converted to
the four colour schemes of [Evergarden](https://github.com/everviolet).

## Usage

### Download

See instructions on the [GitHub release page](https://github.com/everviolet/wallpapers/releases/tag/wallpapers).

### Nix

`nix flake show github:everviolet/wallpapers`

Package inputs:

- `full` (default)
- `winter`
- `fall`
- `spring`
- `summer`

`flake.nix`
```nix
inputs = {
  wallpapers = {
    url = "github:everviolet/wallpapers";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
```

`configuration.nix`
```nix
{inputs, pkgs, ...}: {
  environment = {
    etc."wallpapers".source = inputs.wallpapers.packages.${pkgs.system}.full;
  };
}
```

## Previews

Check out the [website](https://everviolet.github.io/wallpapers/)!

### credits

All images are sourced from the internet and are not my own work. If you are
the original artist and would like me to remove your work, please contact us by
opening an issue.

- [comfysage](https://github.com/comfysage)
- [42willow](https://github.com/42willow)

### Tools

- [lutgen](https://github.com/ozwaldorf/lutgen-rs) - CLI tool to generate LUTs and apply them to images

---

<p align="center">
	<a href="https://github.com/comfysage/evergarden/blob/mega/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=LICENSE&message=MIT&colorA=313B40&colorB=9BB5CF"/></a>
</p>
