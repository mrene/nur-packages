{ runCommand, a }:

runCommand "test" {} ''
  mkdir $out
  echo "Hi " > $out/test.txt
  cat ${a}/test.txt >> $out/test.txt
''