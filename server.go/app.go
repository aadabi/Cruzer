package main

import (
    "database/sql"
    "fmt"
    "log"
    "net/http"
    "encoding/json"

    "github.com/gorilla/mux"
    _ "github.com/lib/pq"
)

// setup

type Server struct {
    Router *mux.Router
    DB     *sql.DB
}

// routes
func (serv *Server) initializeRoutes() {
    serv.Router.HandleFunc("/registration", serv.registration).Methods("POST")
    
}

// initializes database with login
func (serv *Server) Initialize(host string, user string, password string, port int, dbname string) {
    connectionString := fmt.Sprintf("host=%s user=%s password=%s port=%d dbname=%s sslmode=disable", host, user, password, port, dbname)

    var err error
    serv.DB, err = sql.Open("postgres", connectionString)
    if err != nil {
        log.Fatal(err)
    }

    err = serv.DB.Ping()
    if err != nil {
        panic(err)
    }

    serv.Router = mux.NewRouter()
}

// run server on port addr
func (serv *Server) Run(addr string) {
    log.Fatal(http.ListenAndServe(addr, serv.Router))
}


// helper functions

// json error response
func respondWithError(w http.ResponseWriter, code int, message string) {
    respondWithJSON(w, code, map[string]string{"error": message})
}

// json response (non-error)
func respondWithJSON(w http.ResponseWriter, code int, payload interface{}) {
    // encoding
    response, _ := json.Marshal(payload)

    w.Header().Set("Content-Type", "application/json")
    w.WriteHeader(code)
    w.Write(response)
}


// api calls

func (serv *Server) registration(w http.ResponseWriter, r *http.Request) {
    var usr User
    decoder := json.NewDecoder(r.Body)
    if err := decoder.Decode(&usr); err != nil {
        respondWithError(w, http.StatusBadRequest, "Invalid request payload")
        return
    }
    defer r.Body.Close()

    // call to model for actual query
    if err := usr.CreateAccount(serv.DB); err != nil {
        respondWithError(w, http.StatusInternalServerError, err.Error())
        return
    }

    respondWithJSON(w, http.StatusCreated, usr)
}

