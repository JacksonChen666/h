#!/bin/bash
commit() {
	git commit -a --allow-empty -m "h" --no-edit --no-gpg-sign -q && ((c+=1)) && echo -en "\r$c"
}
c=1
while true; do
	while [[ $(($c % 1000000)) != 0 ]]; do
		while [[ $(($c % 100000)) != 0 ]]; do
			commit
		done
		echo -n " | Cleaning up..."
		git gc --prune=all --force -q
		echo -en "\033[K"
		commit
	done
	echo -en "\033[K$c | Pushing..."
	git push -q
	echo -en "\033[K"
done
