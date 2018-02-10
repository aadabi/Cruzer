package main 

// user model file to interact with database

import (
    "time"
    "database/sql"
    "errors"
)

// user model
type User struct {
    userId      int         'json:"userId"'             // id
    userType    string      'json:"userType"'           // rider or driver
    gpsLong     float64     'json:"gpsLong"'            // longitude
    gpsLat      float64     'json:"gpsLat"'            // lattitude
    points      int         'json:"points"'             // tag points
    time        time.Time   'json:"time"'               // time.Now().Zone() TODO
}

// actual calls to database

// PUT to create user account
func (usr *User) createAccount(db *sql.DB) error {
    tx, err := db.conn.Begin()
    if err != nil {
        return
    }
    stmt, err := tx.Prepare(pq.CopyIn("userId", "userType", ))
    return errors.New("todo")
}

// GET to get user information
func (usr *User) getAccountInfo(db *sql.DB) error {
    return errors.New("todo")
}

// POST to update user information
func (usr *User) editAccountInfo(db *sql.DB) error {
    return errors.New("todo")
}

// DELETE to delete user account
func (usr *User) deleteAccount(db *sql.DB) error {
    return errors.New("todo")
}


// get all users
func getUsers(db *sql.DB, start, count int) ([]users, error) {
    rows, err := db.Query()
}



