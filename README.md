<h1 align="center">heroku-buildpack-wkhtmltopdf</h1>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

## 📝 Table of Contents

- [About](#about)
- [Feature](#feature)
- [Getting Started](#getting_started)
- [Usage](#usage)
- [Acknowledgements](#acknowledgement)
- [License](#license)
- [Changelog](#changelog)


## About <a name = "about"></a>

This buildpack downloads and extracts the [wkhtmltopdf](https://wkhtmltopdf.org/) binaries and works on `heroku-18`, `heroku-20`, `heroku-22`, and `heroku-24` stacks.

- This buildpack downloads wkhtmltopdf v0.12.6.1-2 for `heroku-22` and `heroku-24`, v0.12.6-1 for `heroku-20`, and v0.12.5 for `heroku-18`.
- The buildpack can bypass stack detection if the URL to the wkhtmltopdf binary is provided through an Aptfile.

### Ownership Update

This repository was originally created and maintained by [Rohan Debroy](https://github.com/RohanDebroy). As the original author is no longer maintaining the project (This repository has been archived by the owner on Aug 10, 2024. It is now read-only.), I [John Paul Garland w/ Forest of Knowledge Inc.](https://github.com/johnpg82) have taken over the repository to continue its development and support. In this latest update, I've added support for the `heroku-24` stack to ensure compatibility with the latest Heroku environments.

## Changelog <a name = "changelog"></a>
- v1.0 (initial release)
  - Support for `Cedar-14`, `heroku-16`, and `heroku-18`
  - Support for [Aptfile](#aptfile)

- v2
  - Added support for `Heroku-20`
  - Removed support for `Cedar-14` and `heroku-16` as they reached end of life.

- v3
  - Added support for `Heroku-22`
  - Added support for bypassing stack detection.

- v4
  - Added support for `Heroku-24`
  - Maintenance taken over by a new maintainer due to the original author abandoning the project.

## Features <a name = "feature"></a>
- Downloads wkhtmltopdf binaries from [wkhtmltopdf.org](http://wkhtmltopdf.org)
- It does not add new environment variables or shell scripts.
- Tested on `heroku-24`, `heroku-22`, `heroku-20`, and `heroku-18` stack images.
- Allows you to specify a custom or the latest version of wkhtmltopdf for your app on Heroku. [Aptfile](#aptfile).

## Getting Started <a name = "getting_started"></a>
Just add the buildpack to your Heroku app by executing:

```bash
heroku buildpacks:add https://github.com/YourUsername/heroku-buildpack-wkhtmltopdf.git
