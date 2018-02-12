package main

// entrypoint to server

func main() {
    // instantiates server
    a := Server{}

    // initliazes database
    a.Initialize("127.0.0.1", "nick", "", 5432, "sampletest")

    // runs server
    a.Run()

}
