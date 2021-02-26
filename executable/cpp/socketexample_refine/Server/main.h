#ifndef SERVER_MAIN_H
#define SERVER_MAIN_H

#include <WinSock2.h>

#include <iostream>
using std::cout;
using std::endl;

#include <random>
using std::random_device;
using std::mt19937;
using std::uniform_int_distribution;
using std::uniform_real_distribution;

#include <thread>
#include <chrono>

#include <string>
#include <stdexcept>

#define SERVER_PORT 11235  // server port number
#define BUF_SIZE 4096 // block transfer size  
#define QUEUE_SIZE 10
#define IPAddress "127.0.0.1" // server IP address

#endif // !SERVER_MAIN_H
