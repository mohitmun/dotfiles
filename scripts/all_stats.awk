#/usr/bin/env awk
BEGIN {
  min = 222222222222222222222222
}

{
  sum+=$1
  count[NR] = $1
  if ($1 > max){
    max = $1
  }
  if ($1 < min){
    min = $1
  }
}

END {

  if (NR % 2) {
    median = count[(NR + 1) / 2]
  } else {
    median = (count[(NR/2)] + count[(NR/2) + 1]) / 2.0
  }
  #print "{avg: " sum/NR " Median: "  median  " Max:"  max " Min: " min
  #print "{avg: " sum/NR " Median: "  median  " Max:"  max " Min: " min
  jo="jo avg=" sum/NR " median=" median " max=" max " min=" min
  jo | getline result
  print result
}
