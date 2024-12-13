#include <netdb.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <linux/if_packet.h>


int main() {
    struct protoent *protocol_entry = getprotobyname("IPv4");
    printf("%s\n", protocol_entry->p_name);

    int sfd = socket(AF_INET, SOCK_RAW, protocol_entry->p_proto);

    if (sfd == -1) {
        perror("pls help me im broken");
        return -1;
    }

    close(sfd);
    return 0;
}