number=13

while getopts n: opt; do
	case $opt in
	n)	number=${OPTARG};;
	?)	exit 1;;
	esac
done

shift $((OPTIND - 1))

if [ $# -ne 0 ]; then
	printf 'usage: %s [-n number]\n' "$0"
	printf '\t-n the number of characters to rotate (default 13)\n'
	exit 1
fi

number=$((number % 26))
A=$(printf '%d' 0$(printf '%o' \"A\"))
FROM=$(printf '%o' $((A + number)))
THRU=$(printf '%o' $((A + number - 1)))
TRUPPER=$(printf '%b-ZA-%b\n' "\0${FROM}" "\0${THRU}")
trlower=$(echo $TRUPPER | tr [[:upper:]] [[:lower:]])

exec tr "A-Za-z" "${TRUPPER}${trlower}"
