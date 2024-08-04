{ runCommand }:

runCommand "test" {} ''
  mkdir $out
  echo "Hi" > $out/test.txt
''