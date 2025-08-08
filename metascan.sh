#!/bin/bash

if [ -z "$1" ]; then
    echo -e "\e[31m[ERROR] Usage: metascan <file> [-o output.txt]\e[0m"
    exit 1
fi

FILE="$1"
OUTPUT=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -o|--output)
            OUTPUT="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

if [ ! -f "$FILE" ]; then
    echo -e "\e[31m[ERROR] File '$FILE' not found.\e[0m"
    exit 1
fi

RESULT="====================== Metascan ======================\n"
RESULT+="File: $FILE\n\n"

if file "$FILE" | grep -Eiq 'image|pdf|document'; then
    RESULT+="=============== ExifTool ===============\n"
    RESULT+="$(exiftool "$FILE" 2>/dev/null || echo "ExifTool not found or not applicable.")\n\n"
    
    # Adicionando a ferramenta identify para imagens
    if file "$FILE" | grep -iq "image"; then
        RESULT+="=============== Identify (ImageMagick) ===============\n"
        RESULT+="$(identify -verbose "$FILE" 2>/dev/null || echo "Identify not found or not applicable.")\n\n"
    fi
fi

RESULT+="=============== Strings ===============\n"
RESULT+="$(strings "$FILE" | head -n 50)\n\n"

if file "$FILE" | grep -iq pdf; then
    RESULT+="=============== PDFInfo ===============\n"
    RESULT+="$(pdfinfo "$FILE" 2>/dev/null || echo "PDFInfo not found.")\n\n"
fi

if file "$FILE" | grep -Eiq 'audio|video'; then
    RESULT+="=============== FFProbe ===============\n"
    RESULT+="$(ffprobe -v quiet -show_format -show_streams "$FILE" 2>/dev/null || echo "FFProbe not found.")\n\n"
fi

if file "$FILE" | grep -Eiq 'binary|executable'; then
    RESULT+="=============== Binwalk ===============\n"
    RESULT+="$(binwalk "$FILE" 2>/dev/null || echo "Binwalk not found.")\n\n"
fi

RESULT+="======================================================"

if [ -n "$OUTPUT" ]; then
    echo -e "$RESULT" > "$OUTPUT"
    echo -e "\e[32m[INFO] Results saved to $OUTPUT\e[0m"
else
    echo -e "$RESULT"
fi
