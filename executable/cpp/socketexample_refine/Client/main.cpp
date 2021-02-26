#include "main.h"


int main(void)
{
    WORD		wVersionRequested;
    WSADATA		wsaData;
    SOCKADDR_IN target; //Socket address information
    SOCKET      s;
    int			err;
    int			bytesSent;
    char        buf[50];

    wVersionRequested = MAKEWORD(1, 1);
    err = WSAStartup(wVersionRequested, &wsaData);

    if (err != 0) {
        printf("WSAStartup error %ld", WSAGetLastError());
        WSACleanup();
        return 0;
    }

    target.sin_family = AF_INET; // address family Internet
    target.sin_port = htons(SERVER_PORT); //Port to connect on
    target.sin_addr.s_addr = inet_addr(IPAddress); //Target IP


    s = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP); //Create socket
    if (s == INVALID_SOCKET)
    {
        cout << "socket() error : "<< WSAGetLastError() << endl;
        WSACleanup();
        return 0; //Couldn't create the socket
    }


    if (connect(s, reinterpret_cast<SOCKADDR *>(&target), sizeof(target)) == SOCKET_ERROR)
    {
        cout << "connect() error : " << WSAGetLastError() << endl;
        cout << "서버 먼저 실행해주세요." << endl;
        WSACleanup();
        return 0; //Couldn't connect
    }

    printf("Sending HELLO...\n");
    bytesSent = send(s, "HELLO", strlen("HELLO"), 0); // use "send" in windows

    int n;
    std::string sRand;
    int iRand;
    while (true)
    {
        try
        {
            n = recv(s, buf, 50, 0); // read max 50 bytes
            if (n <= 0) { printf("Got nothing\n"); break; }
            buf[n] = 0; // make a string

            cout << "Received: " << buf << endl;
            sRand = buf;
            iRand = stoi(sRand);
            std::this_thread::sleep_for(std::chrono::seconds(1));
            cout << "Sending \"" << ++iRand << "\"" << " to client" << endl;
            sRand = std::to_string(iRand);
            bytesSent = send(s, sRand.c_str(), sRand.length(), 0);
        }
        catch (const std::invalid_argument &ex)
        {
            std::cerr << "Invalid argument while converting string to number" << endl;
            std::cerr << "Error: " << ex.what() << endl;
            break;
        }
        catch (const std::out_of_range &ex)
        {
            std::cerr << "Invalid argument while converting string to number" << endl;
            std::cerr << "Error: " << ex.what() << endl;
            break;
        }
    }

    closesocket(s);
    WSACleanup();

    return 0;

}
