package main 

// server file which contains api calls and routing

import (
    "fmt"
    "net/http"
    "database/sql"

    "github.com/gorilla/mux"
    _ "github.com/lib/pq"

)

// server data structure
type Server struct {
    Router  *mux.Router
    DB      *sql.DB

}

// creates routes
func (serv *Server) initalizeRoutes() {
    serv.Router.HandleFunc("/userLogin", serv.userLogin).Methods("POST")
    serv.Router.HandleFunc("/registration", serv.registration).Methods("PUT")
    serv.Router.HandleFunc("/postRide", serv.postRide).Methods("POST")
    serv.Router.HandleFunc("/findRide", serv.findRide).Methods("POST")
    serv.Router.HandleFunc("/notifyRider", serv.notifyRider).Methods("POST")
    serv.Router.HandleFunc("/endRide", serv.endRide).Methods("POST")
    serv.Router.HandleFunc("/rateRider", serv.rateRider).Methods("POST")
}

func (serv *Server) Initialize(user, password, dbname string) {
    conn = fmt.Sprintf("user=%s password=%s dbname=%s", user, password, dbname)

    var err error
    serv.DB, err = sql.Open("postgres", conn)
    if err != nil {
        log.Fatal(err)
    }

    serv.Router = mux.NewRouter()
}

// http handlers for specific calls



func (serv *Server) userLogin(w http.ResponseWriter, r *http.Request) error {
    return errors.New("todo")
}

func (serv *Server) registration(w http.ResponseWriter, r *http.Request) error {
    return errors.New("todo")
}

func (serv *Server) postRide(w http.ResponseWriter, r *http.Request) error {
    return errors.New("todo")
}

func (serv *Server) findRide(w http.ResponseWriter, r *http.Request) error {
    return errors.New("todo")
}

func (serv *Server) notifyRider(w http.ResponseWriter, r *http.Request) error {
    return errors.New("todo")
}

func (serv *Server) endRide(w http.ResponseWriter, r *http.Request) error {
    return errors.New("todo")
}

func (serv *Server) rateRider(w http.ResponseWriter, r *http.Request) error {
    return errors.New("todo")
}


