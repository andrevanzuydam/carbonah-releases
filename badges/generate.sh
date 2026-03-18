#!/usr/bin/env bash
# Generate Carbonah grade badge SVGs
# These are shields.io-style badges that projects can embed in their README.
#
# Usage:
#   bash generate.sh          # generates all grade badges
#   carbonah badge A          # (future) outputs markdown for grade A badge

set -e
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

generate_badge() {
    local grade="$1"
    local color="$2"
    local label="carbonah"
    local label_width=70
    local value_width=30
    local total_width=$((label_width + value_width))
    local label_x=$((label_width / 2))
    local value_x=$((label_width + value_width / 2))
    local file="$DIR/grade-$(echo "$grade" | tr '[:upper:]+' '[:lower:]p').svg"

    # URL-encode the plus sign for A+
    local display_grade="$grade"

    cat > "$file" << SVGEOF
<svg xmlns="http://www.w3.org/2000/svg" width="${total_width}" height="20" role="img" aria-label="${label}: ${display_grade}">
  <title>${label}: ${display_grade}</title>
  <linearGradient id="s" x2="0" y2="100%">
    <stop offset="0" stop-color="#bbb" stop-opacity=".1"/>
    <stop offset="1" stop-opacity=".1"/>
  </linearGradient>
  <clipPath id="r">
    <rect width="${total_width}" height="20" rx="3" fill="#fff"/>
  </clipPath>
  <g clip-path="url(#r)">
    <rect width="${label_width}" height="20" fill="#555"/>
    <rect x="${label_width}" width="${value_width}" height="20" fill="${color}"/>
    <rect width="${total_width}" height="20" fill="url(#s)"/>
  </g>
  <g fill="#fff" text-anchor="middle" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" text-rendering="geometricPrecision" font-size="11">
    <text aria-hidden="true" x="${label_x}" y="15" fill="#010101" fill-opacity=".3">${label}</text>
    <text x="${label_x}" y="14">${label}</text>
    <text aria-hidden="true" x="${value_x}" y="15" fill="#010101" fill-opacity=".3">${display_grade}</text>
    <text x="${value_x}" y="14">${display_grade}</text>
  </g>
</svg>
SVGEOF
    echo "  Generated: grade-$(echo "$grade" | tr '[:upper:]+' '[:lower:]p').svg  (${display_grade}, ${color})"
}

echo ""
echo "  Generating Carbonah grade badges..."
echo ""

generate_badge "A+"  "#44cc11"   # bright green
generate_badge "A"   "#97ca00"   # green
generate_badge "B"   "#dfb317"   # yellow-green
generate_badge "C"   "#fe7d37"   # orange
generate_badge "D"   "#e05d44"   # red-orange
generate_badge "F"   "#e05d44"   # red

# Also generate a generic "carbonah" badge
cat > "$DIR/carbonah.svg" << 'SVGEOF'
<svg xmlns="http://www.w3.org/2000/svg" width="120" height="20" role="img" aria-label="powered by: carbonah">
  <title>powered by: carbonah</title>
  <linearGradient id="s" x2="0" y2="100%">
    <stop offset="0" stop-color="#bbb" stop-opacity=".1"/>
    <stop offset="1" stop-opacity=".1"/>
  </linearGradient>
  <clipPath id="r">
    <rect width="120" height="20" rx="3" fill="#fff"/>
  </clipPath>
  <g clip-path="url(#r)">
    <rect width="76" height="20" fill="#555"/>
    <rect x="76" width="44" height="20" fill="#44cc11"/>
    <rect width="120" height="20" fill="url(#s)"/>
  </g>
  <g fill="#fff" text-anchor="middle" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" text-rendering="geometricPrecision" font-size="11">
    <text aria-hidden="true" x="38" y="15" fill="#010101" fill-opacity=".3">powered by</text>
    <text x="38" y="14">powered by</text>
    <text aria-hidden="true" x="97" y="15" fill="#010101" fill-opacity=".3">carbonah</text>
    <text x="97" y="14">carbonah</text>
  </g>
</svg>
SVGEOF
echo "  Generated: carbonah.svg  (powered by carbonah)"

echo ""
echo "  Usage in README.md:"
echo ""
echo '    ![carbonah A](https://raw.githubusercontent.com/andrevanzuydam/carbonah-releases/main/badges/grade-a.svg)'
echo '    ![powered by carbonah](https://raw.githubusercontent.com/andrevanzuydam/carbonah-releases/main/badges/carbonah.svg)'
echo ""
