package main 

// basic server ported to 8080 on localhost
// path will be printed to page

import (
    "fmt"
    "net/http"

)

// http handler simply prints what is in the path
func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "At path: %s", r.URL.Path[1:])
}

// main function to listen on port
func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080",nil)
}
