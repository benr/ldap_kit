/* 
 Taken from:
 http://stuff.iain.cx/2008/05/03/ns103eb2365be169abbe3a45088a10a/
 Credit goes to Iain Patterson.
*/

#include "ns_sldap.h"
#include "ns_internal.h"

static int is_cleartext(const char *pwd) {
	return strncmp(pwd, CRYPTMARK, strlen(CRYPTMARK));
}

int main(int argc, char **argv) {
	if (argc == 1) {
		fprintf(stderr, "Usage: ns1 <hash>\n");
		fprintf(stderr, "Usage: ns1 <plaintext>\n");
		exit(1);
	}

	if (is_cleartext(argv[1])) printf("%s\n", evalue(argv[1]));
	else printf("%s\n", dvalue(argv[1]));
	exit(0);
}
