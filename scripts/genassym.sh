#!/bin/sh
# $FreeBSD$

usage()
{
	echo "usage: genassym [-o outfile] objfile"
	exit 1
}

work()
{
	${NM:='x86_64-elf-nm'} ${NMFLAGS} "$1" | gawk '
	/B .*_value$/ {
		name = substr($3, 1, length($3) - 6)  # Remove _value suffix
		size = strtonum("0x" substr($1, length($1) - 3, 4))
		printf("#define\t%s\t%d\n", name, size - 1)
	} '
}

#
#MAIN PROGGRAM
#
use_outfile="no"
while getopts "o:" option
do
	case "$option" in
	o)	outfile="$OPTARG"
		use_outfile="yes";;
	*)	usage;;
	esac
done
shift $(($OPTIND - 1))
case $# in
1)	;;
*)	usage;;
esac

if [ "$use_outfile" = "yes" ]
then
	work $1  3>"$outfile" >&3 3>&-
else
	work $1
fi

