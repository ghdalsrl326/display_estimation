#define _WINSOCK_DEPRECATED_NO_WARNINGS
#define BUFFSIZE 1024

#include "main.h"
#pragma comment(lib, "ws2_32.lib")


//출처: https://nroses-taek.tistory.com/105 [dotaky99]

int makeRand();

int main(void)
{
    WORD		wVersionRequested;
    WSADATA		wsaData;
    SOCKADDR_IN servAddr, cliAddr; //Socket address information
    int			err;
    int			bytesSent;
    char        buf[BUFFSIZE];

    wVersionRequested = MAKEWORD(1, 1);
    err = WSAStartup(wVersionRequested, &wsaData);

    if (err != 0) {
        cout << "WSAStartup error " << WSAGetLastError() << endl;
        WSACleanup();
        return false;
    }

    servAddr.sin_family = AF_INET; // address family Internet
    servAddr.sin_port = htons(SERVER_PORT); //Port to connect on
    servAddr.sin_addr.s_addr = inet_addr(IPAddress); //Target IP


    SOCKET s = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP); //Create socket
    if (s == INVALID_SOCKET)
    {
        cout << "Socket error " << WSAGetLastError() << endl;
        WSACleanup();
        return false; //Couldn't create the socket
    }

    int x = bind(s, reinterpret_cast<SOCKADDR *>(&servAddr), sizeof(servAddr));
    if (x == SOCKET_ERROR)
    {
        cout << "Binding failed. Error code: " << WSAGetLastError() << endl;
        WSACleanup();
        return false; //Couldn't connect
    }

    cout << "Waiting for client..." << endl;

    listen(s, 5);
    int xx = sizeof(cliAddr);
    SOCKET s2 = accept(s, reinterpret_cast<SOCKADDR *>(&cliAddr), &xx);
    cout << "Connection established. New socket num is " << s2 << endl;

    int iRand = 0;
    int n = 0;
    while (true)
    {
        n = recv(s2, buf, BUFFSIZE, 0);
        if (n <= 0) { cout << "Got nothing" << endl; break; }
        buf[n] = 0;

		cout << "Received: " << buf << endl;
        if (!strcmp(buf, "HELLO"))
        {// Initial communication
            iRand = makeRand();
            auto sRand = std::to_string(iRand);
            cout << "Sending random number " << iRand << " to the client." << endl;
            bytesSent = send(s2, sRand.c_str(), sRand.length(), 0);

            continue;
        }
        std::string sNum(buf);
        try
		{
			;
            //iRand = stoi(sNum);
            //cout << "Server got " << "\"" << iRand << "\"" << endl;
            //std::this_thread::sleep_for(std::chrono::seconds(1));
            //cout << "Sending \"" << ++iRand << "\"" << " to client" << endl;
            //auto sRand = std::to_string(iRand);
            //bytesSent = send(s2, sRand.c_str(), sRand.length(), 0);
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

int makeRand()
{
    random_device rd;
    mt19937 rng(rd());
    uniform_int_distribution<int> ud(1, 1024);

    //return ud(rng);
	return 1000000000;
}
