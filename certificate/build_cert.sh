#!/bin/bash 

config=`ls | grep .cfg`

generate() {
	openssl req -out sslcert.csr -newkey rsa:4096 -nodes -keyout private.key -config $config 
}
printsslcert() {
	openssl req -noout -text -in sslcert.csr
}
printhelp() {
	printf "To create a certificate request, you need to edit $config \n
	To make a file a request must be run with the $0 generate_cert key \n
	To view the request file, you need to run with the $0 print_cert key \n
	---------------^_^------------------\n
	it's so simple =) \n"
}

case "$1" in 
	gen)
		generate
	;;
	print)
		printsslcert
	;;
	*)
		printhelp
		exit 1
esac

