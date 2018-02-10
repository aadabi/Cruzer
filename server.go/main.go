package main

// from github.com/seadsystem/Backend/blob/master/DB/landingzone/main.go

import (
    "flag"
    "io/ioutil"
    "log"
    "net"
    "net/http"
    "sync"

    "github.com/gorilla/mux"

    "./server.go"
    "./model.go"




)

// TODO
func main() {
    logLevel := flag.Int("log", 0, "Logging level. 0=No logging, 1=Most logging, 2=Log data.")
    flag.Parse()

    if *logLevel <= 0 {
        log.SetOutput(ioutil.Discard)
    }
    if *logLevel >= 2 {
        constants.Verbose = true
    }

    // Setup database
    db, err := database.New()
    if err != nil {
        log.Fatal(err)
    }
    defer db.Close()

    // Causes operations which require a new connection to block instead of failing.
    db.SetMaxOpenConns(constants.DB_MAX_CONNS)

    log.Println("Starting servers...")

    var wg sync.WaitGroup
    wg.Add(3)
    go func() {
        wg.Done()
        log.Fatal(grpcListener(grpcHandlers.Register, constants.GRPC_PORT, db))
    }()
    go func() {
        wg.Done()
        log.Fatal(httpListener(eGaugeHandlers.HandleRequest, constants.EGAUGE_PORT, db))
    }()
    go func() {
        wg.Done()
        listener(seadPlugHandlers.HandleRequest, constants.SEAD_PLUG_PORT, db)
    }()

    wg.Wait() // Wait for background servers to get a chance to start.

    log.Println("Started servers.")
    select{}
}

func listener(handler func(net.Conn, database.DB), port string, db database.DB) {
    // Set up connection
    listener, err := net.Listen("tcp4", constants.HOST+":"+port) // The plugs only support IPv4.
    if err != nil {
        log.Println("Failed to open listener on port " + port)
        log.Panic("Error was: " + err.Error())
    }
    defer listener.Close()

    // Wait for requests forever
    for {
        conn, err := listener.Accept() // Blocking
        if err != nil {
            log.Println("Failed to accept request: " + err.Error())
            continue
        }
        go handler(conn, db) // Handle request in a new go routine. The database object is thread safe.
    }
}

func httpListener(handler func(http.ResponseWriter, *http.Request, database.DB), port string, db database.DB) error {
    serverMux := http.NewServeMux()

    // Setup HTTP handler for all URLs on the specified port.
    serverMux.HandleFunc("/", func(res http.ResponseWriter, req *http.Request) { handler(res, req, db) })

    return http.ListenAndServe(constants.HOST+":"+port, serverMux)
}

