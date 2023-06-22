#!/bin/sh

function draw_line() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

for DIR in `ls ~/git`;do
  echo
  draw_line
  echo $DIR:
  git -C ~/git/$DIR $@
done

echo
draw_line

