package model

import (
    "github.com/jinzhu/gorm"
    _ "github.com/jinzhu/gorm/dialects/postgres"
)

type User struct {
    gorm.Model
    Name   string `gorm:"unique" json:"name"`
    City   string `json:"city"`
    Age    int    `json:"age"`
    Status bool   `json:"status"`
}

func (e *User) Disable() {
    e.Status = false
}

func (p *User) Enable() {
    p.Status = true
}

// DBMigrate will create and migrate the tables, and then make the some relationships if necessary
func DBMigrate(db *gorm.DB) *gorm.DB {
    db.AutoMigrate(&User{})
    return db
}
