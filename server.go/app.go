package main

import (
    "database/sql"
    "fmt"
    "log"
    "net/http"
    "encoding/json"
    "strconv"

    "github.com/gorilla/mux"
    _ "github.com/lib/pq"
)

// setup

// Server with router and database
type Server struct {
    Router *mux.Router
    DB     *sql.DB
}

// initializeRoutes, creates routes at endpoints
func (serv *Server) initializeRoutes() {
    serv.Router.HandleFunc("/", serv.home)
    serv.Router.HandleFunc("/registration", serv.registration).Methods("POST")
    serv.Router.HandleFunc("/user/{id:[0-9]+}", serv.getAccount).Methods("GET")
    
}

// Initialize database and server
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

    serv.Router = mux.NewRouter().StrictSlash(true)
    serv.initializeRoutes()
}

// Run server on port (currently hardcoded for local usage)
func (serv *Server) Run() {
    log.Fatal(http.ListenAndServe(":8080", serv.Router))
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

func (serv *Server) home(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "home page")
}

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

func (serv *Server) getAccount(w http.ResponseWriter, r *http.Request) {
    vars := mux.Vars(r)
    id, err := strconv.Atoi(vars["id"])
    fmt.Println("id is: ",id)
    if err != nil {
        respondWithError(w, http.StatusBadRequest, "Invalid user id")
        return
    }

    usr := User{id: id}
    fmt.Println("usr is: ",usr)
    if err := usr.GetAccountInfo(serv.DB); err != nil {
        switch err {
            case sql.ErrNoRows:
                respondWithError(w, http.StatusNotFound, "User not found")
            default:
                respondWithError(w, http.StatusInternalServerError, err.Error())
        }
        return
    }

    respondWithJSON(w, http.StatusOK, usr)
}

