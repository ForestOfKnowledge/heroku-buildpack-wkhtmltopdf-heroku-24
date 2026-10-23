#!/usr/bin/env bash
set -euo pipefail

BUILDPACK_DIR=$(cd "$(dirname "$0")/.." && pwd)
TEST_DIR=$(mktemp -d)
trap 'rm -rf "$TEST_DIR"' EXIT
mkdir -p "$TEST_DIR/app" "$TEST_DIR/cache" "$TEST_DIR/env"

# Preserve detection for existing stacks, reject unknown stacks, and retain Aptfile overrides.
for stack in heroku-18 heroku-20 heroku-22 heroku-24 heroku-26; do
    test "$(STACK=$stack bash "$BUILDPACK_DIR/bin/detect" "$TEST_DIR/app")" = wkhtmltopdf
done
if STACK=unsupported bash "$BUILDPACK_DIR/bin/detect" "$TEST_DIR/app"; then
    echo "Unknown stacks must fail detection" >&2
    exit 1
fi
touch "$TEST_DIR/app/Aptfile"
test "$(STACK=unsupported bash "$BUILDPACK_DIR/bin/detect" "$TEST_DIR/app")" = wkhtmltopdf
rm "$TEST_DIR/app/Aptfile"

# Exercise the full installer in the stack's runtime image, including dependency resolution.
bash "$BUILDPACK_DIR/bin/compile" "$TEST_DIR/app" "$TEST_DIR/cache" "$TEST_DIR/env"
for binary in wkhtmltopdf wkhtmltoimage; do
    dependencies=$(ldd "$TEST_DIR/app/bin/$binary")
    echo "$dependencies"
    if [[ "$dependencies" == *"not found"* ]]; then
        echo "$binary has missing runtime libraries" >&2
        exit 1
    fi
    "$TEST_DIR/app/bin/$binary" --version
done
"$TEST_DIR/app/bin/wkhtmltopdf" https://example.com "$TEST_DIR/test.pdf"
test "$(head -c 5 "$TEST_DIR/test.pdf")" = %PDF-
test -s "$TEST_DIR/test.pdf"
echo "$STACK: URL-to-PDF smoke test passed ($(wc -c < "$TEST_DIR/test.pdf") bytes)"
