package main

import (
    "database/sql"
    "errors"
    "time"
)

// user model
type User struct {
    id          int         `json:"id"`                 // id
    utype        string     `json:"utype"`              // rider or driver
    gpsLong     float64     `json:"gpsLong"`            // longitude
    gpsLat      float64     `json:"gpsLat"`             // lattitude
    points      int         `json:"points"`             // tag points
    time        time.Time   `json:"time"`               // time.Now().Format("2006-01-02 15:04:05") TODO
}

// actual calls to database

// PUT to create user account
func (usr *User) CreateAccount(db *sql.DB) error {
    err := db.QueryRow(
        `INSERT INTO users(data) VALUES('{"id": ?,"utype": ?, "gpsLong": ?, "gpsLat": ?, "points": ?, "time": ?}')`, usr.id, usr.utype, usr.gpsLong, usr.gpsLat, usr.points, usr.time).Scan(&usr.id, &usr.utype, &usr.gpsLong, &usr.gpsLat, &usr.points, &usr.time)

    if err != nil {
        return err
    }

    return nil
}

// GET to get user information
func (usr *User) GetAccountInfo(db *sql.DB) error {
    return db.QueryRow("SELECT * FROM users WHERE data->>id=?", usr.id).Scan(&usr.id)
}

// POST to update user information
func (usr *User) EditAccountInfo(db *sql.DB) error {
    return errors.New("todo")
}

// DELETE to delete user account
func (usr *User) DeleteAccount(db *sql.DB) error {
    _, err := db.Exec("DELETE FROM users WHERE id=$1", usr.id)

    return err
}
