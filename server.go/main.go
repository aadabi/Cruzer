package main


func main() {
    a := Server{}
    a.Initialize("127.0.0.1", "nick", "", 5432, "sampletest")

    a.Run(":8080")
}
