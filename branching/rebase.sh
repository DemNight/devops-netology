#!/bin/bash
# display command line options

count=1
for param in "$@"; do
<<<<<<< HEAD
<<<<<<< HEAD
    echo "\$@ Parameter #$count = $param"
=======
    echo "Parameter: $param"
>>>>>>> cc6b8b9 (git-rebase 1)
=======
    echo "Next parameter: $param
>>>>>>> f4a67e2 (git-rebase 2)
    count=$(( $count + 1 ))
done

echo "====="