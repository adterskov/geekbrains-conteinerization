package config

import "os"

type Config struct {
      	DB *DBConfig
}

type DBConfig struct {
      	Host     string
      	Port     string
      	Username string
      	Password string
      	Name     string
}

func GetConfig() *Config {
      	return &Config{
	            	DB: &DBConfig{
	                  		Host:     os.Getenv("DB_HOST"),
	                  		Port:     os.Getenv("DB_PORT"),
	                   		Username: os.Getenv("DB_USER"),
	                  		Password: os.Getenv("DB_PASSWORD"),
	                  		Name:     os.Getenv("DB_NAME"),
            		},
      	}
}
