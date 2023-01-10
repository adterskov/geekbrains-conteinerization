package main

import (
	"fmt"
	"log"
	"net/http"
        "os"

        "github.com/gorilla/handlers"
	"github.com/gorilla/mux"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, World!")
}

func main() {
	r := mux.NewRouter().StrictSlash(true)
	r.HandleFunc("/", helloHandler)

        port, ok := os.LookupEnv("PORT")
        if !ok {
              port = "8080"
        }

        loggedRouter := handlers.LoggingHandler(os.Stdout, r)
        log.Printf("Starting listening on :%v", port)
	log.Fatal(http.ListenAndServe(":" + port, loggedRouter))
}
