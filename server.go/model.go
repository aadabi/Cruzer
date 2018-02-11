package main

import (
    "database/sql"
    "errors"
    "time"
    "fmt"


)

// User model
type User struct {
    id          int         `json:"id"`                 // id
    utype       string      `json:"utype"`              // rider or driver
    gpsLong     float64     `json:"gpsLong"`            // longitude
    gpsLat      float64     `json:"gpsLat"`             // lattitude
    points      int         `json:"points"`             // tag points
    time        time.Time   `json:"time"`               // time.Now().Format("2006-01-02 15:04:05") TODO
}

// actual calls to database

// CreateAccount PUT to create user account
func (usr *User) CreateAccount(db *sql.DB) error {
    err := db.QueryRow(
        `INSERT INTO users(data) VALUES('{"id": ?,"utype": ?, "gpsLong": ?, "gpsLat": ?, "points": ?, "time": ?}')`, usr.id, usr.utype, usr.gpsLong, usr.gpsLat, usr.points, usr.time).Scan(&usr.id, &usr.utype, &usr.gpsLong, &usr.gpsLat, &usr.points, &usr.time)

    if err != nil {
        return err
    }

    return nil
}

// GetAccountInfo GET to get user information
func (usr *User) GetAccountInfo(db *sql.DB) error {
    //err := db.QueryRow(`SELECT * FROM users WHERE data->'id'=$1`, usr.id).Scan(&usr.id)
    //fmt.Println("usr.id is: ", usr.id, "error is: ", err)
    return db.QueryRow(`SELECT * FROM users WHERE data->'id'=$1`, usr.id).Scan(&usr.id)
}

// EditAccountInfo POST to update user information
func (usr *User) EditAccountInfo(db *sql.DB) error {
    return errors.New("todo")
}

// DeleteAccount DELETE to delete user account
func (usr *User) DeleteAccount(db *sql.DB) error {
    _, err := db.Exec("DELETE FROM users WHERE id=$1", usr.id)

    return err
}
