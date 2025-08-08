# Metascan

Metascan is a versatile Bash script for analyzing files using various metadata extraction and analysis tools.

## Features

* Supports multiple file types (images, PDFs, videos, binaries).
* Automatically applies the most relevant analysis tools for the file type.
* Clean, color-coded interface for terminal output.
* Option to save results to a file with `-o` or `--output`.

## Installation

1. Run the installation script:

   ```bash
   sudo bash install.sh
   ```

2. After installation, you can use the `metascan` command globally:

   ```bash
   metascan <file> [-o output.txt]
   ```

## Usage

```bash
metascan <file>
metascan <file> -o results.txt
```

## Examples

Analyze a PDF file and save the results to a file:

```bash
metascan document.pdf -o analysis.txt
```

Analyze an image directly in the terminal:

```bash
metascan image.jpg
```

## Requirements

* exiftool
* strings (comes pre-installed)
* pdfinfo
* ffprobe (from ffmpeg)
* binwalk
* identify (ImageMagic)

## Uninstallation

To remove Metascan:

```bash
sudo rm -r /usr/local/bin/metascan
```
