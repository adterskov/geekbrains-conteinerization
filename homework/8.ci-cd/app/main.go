package main

import (
	"github.com/pauljamm/geekbrains-conteinerization/practice/8.ci-cd/app/app"
	"github.com/pauljamm/geekbrains-conteinerization/practice/8.ci-cd/app/config"
)

func main() {
	config := config.GetConfig()

	app := &app.App{}
	app.Initialize(config)
	app.Run(":8000")
}
