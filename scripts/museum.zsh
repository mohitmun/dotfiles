
gencscopedb(){
  CSCOPE_DIR="$PWD/cscope"
  if [ ! -d "$CSCOPE_DIR" ]; then
  mkdir "$CSCOPE_DIR"
  fi
  echo "Finding files ..."
  find "$PWD" -name '*.[ch]' \
  -o -name '*.java' \
  -o -name '*properties' \
  -o -name '*.cpp' \
  -o -name '*.cc' \
  -o -name '*.hpp' \
  -o -name '*.py' \
  -o -name '*.rb' \
  -o -name '*.php' > "$CSCOPE_DIR/cscope.files"
  echo "Adding files to cscope db: $PWD/cscope.db ..."
  cscope -b -i "$CSCOPE_DIR/cscope.files" -f "$CSCOPE_DIR/cscope.out"

  export CSCOPE_DB="$CSCOPE_DIR/cscope.out"
  echo "Exported CSCOPE_DB to: '$CSCOPE_DB'"
}

bindkey "^z" fgvim

fgvim(){
 fg %vi
 zle reset-prompt
}
zle -N fgvim

setbadge(){
  printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "$1" | base64)
}

setprofile(){
  printf "\e]1337;SetProfile=%s\a" "$1"
}

smallfont(){
  setprofile smallfont
}

defaultProfile(){
  setprofile Default
}
