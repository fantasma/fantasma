#!/bin/sh

# The text format of protocol buffers is great (.textproto).
# It's made specifically easy to diff, has great parsers, and is generally well supported.
# You should use it.
# However, writing it directly could be easier.
# For example, I don't have great indentation rules in Vim.
# Also there's just too many lines and indentation levels.
# I found that a very dumb lisp syntax is easier to write.

infilename="$1"
outfilename="$2"

if [ -z "$infilename" -o -z "$outfilename" ]; then
  echo 'Usage: lisp2textproto.sh {input.sxproto} {output.textproto}' >&2
  exit 1
fi


# Copy it.
cp -T "$infilename" "$outfilename"
# Strip comments.
sed -i -E -e 's/;.*$//' "$outfilename"
# Literal fields.
#   (A X) --> A: X
sed -i -z -E \
  -e 's/[(]([[:space:]]*[^[:space:]()]*)([[:space:]]+[^[:space:]()]*[[:space:]]*)[)]/\1:\2/g' \
  "$outfilename"
# Empty messages.
#   (A X) --> A: X
sed -i -z -E -e 's/[(]([[:space:]]*[^[:space:]()]*)([[:space:]]*)\)/\1 {\2}/g' "$outfilename"
# Fixpoint message expansion.
#   (A) --> A {}
#   (A B: X) --> A {B: X}
#   (A B: X C {D: Y}) --> A {B: X C {D: Y}}
while grep -q -z -E -e '[(].*[)]' "$outfilename"; do
  sed -i -z -E \
    -e 's/[(]([[:space:]]*[^[:space:]()]*)([[:space:]]+[^[:space:]()][^()]*)[)]/\1 {\2}/g' \
    "$outfilename"
done

# Remove spaces after opening brace.
sed -i -E -e 's/[{][[:space:]]+/{/g' "$outfilename"
# Unindent closing brace by 2 spaces.
sed -i -E -e 's/^[ ][ ]([[:space:]]*[}])/\1/' "$outfilename"

if grep -q -E -e '[()]' "$outfilename"; then
  printf 'lisp2textproto.sh: Unbalanced parentheses in %s\n' "$infilename" >&2
  exit 1
fi
exit 0
