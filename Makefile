CXXFLAGS=-O2 -g -Wall -pthread -lrt
CFLAGS = -O2 -g -Wall -pthread -lrt --std=gnu99

all: server_epoll server_thread client

server_epoll: server_epoll.cpp
	$(CXX) $(CXXFLAGS) -o $@ $<

server_thread: server_thread.cpp
	$(CXX) $(CXXFLAGS) -o $@ $<

server_libev: server_libev.cpp
	$(CXX) $(CXXFLAGS) -o $@ $< -lev

null_server_epoll: null_server_epoll.cpp
	$(CXX) $(CXXFLAGS) -o $@ $<

null_server_thread: null_server_thread.cpp
	$(CXX) $(CXXFLAGS) -o $@ $<

server_go: server_go.go
	go build $<

server_haskell: server_haskell.hs
	ghc6 -threaded -O --make -o $@ $<

server_erlang: server_erlang.erl
	erlc $<

server_libmill: server_libmill.c
	$(CC) $(CFLAGS) $< -o $@ -lmill

server_zewo: 
	cd swift/zewo && swift build --configuration release
	cp swift/zewo/.build/release/server_zewo .

client_libmill: client_libmill.c
	$(CC) $(CFLAGS) $< -o $@ -lmill

client: client.c
	$(CC) $(CFLAGS) $< -o $@
