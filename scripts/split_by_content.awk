#!/usr/bin/awk -f
BEGIN {}  # Begin section

match($0, /[0-9a-fA-F]{40}/){
  close(file_name)
  pattern=substr($0, RSTART, RLENGTH)
  file_name = "awksome/" pattern ".log"
  print $0 >> file_name
}        # Loop section

END{}     # End section
