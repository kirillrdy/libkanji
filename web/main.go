// +build !js

package main

import (
	"github.com/kirillrdy/gopherjs"
	"github.com/kirillrdy/libkanji"
	"github.com/kirillrdy/nadeshiko"
	"net/http"
)

func main() {

	app := gopherjs.App{PackageName: "github.com/kirillrdy/silverkanji/client"}

	http.HandleFunc("/edict", func(response http.ResponseWriter, request *http.Request) {
		http.ServeFile(response, request, libkanji.Edict2FilePath())
	})

	app.Mount("/")

	nadeshiko.StartServer()
}
