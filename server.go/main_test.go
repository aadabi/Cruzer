package main_test

import (
    "os"
    "testing"
    "net/http"
    "net/http/httptest"
    "encoding/json"
    "bytes"
    "log"

    "."
)

var a main.Server

const tableCreationQuery = "SET search_path to public;CREATE TABLE IF NOT EXISTS users(data jsonb);"

const testTableCreationQuery = "SET search_path to public;CREATE TABLE IF NOT EXISTS test(data jsonb);"

// helper functions

func ensureTableExists() {
    if _, err := a.DB.Exec(testTableCreationQuery); err != nil {
        log.Fatal(err)
    }
}

func clearTable() {
    a.DB.Exec("DELETE FROM users")
}

func executeRequest(req *http.Request) *httptest.ResponseRecorder {
    rr := httptest.NewRecorder()
    a.Router.ServeHTTP(rr, req)

    return rr
}

func checkResponseCode(t *testing.T, expected, actual int) {
    if expected != actual {
        t.Errorf("Expected response code %d. Got %d\n", expected, actual)
    }
}


// test functions


func TestGetNonExistentUser(t *testing.T) {
    clearTable()

    req, _ := http.NewRequest("GET", "/user/11", nil)
    response := executeRequest(req)

    checkResponseCode(t, http.StatusNotFound, response.Code)

    var m map[string]string
    json.Unmarshal(response.Body.Bytes(), &m)
    if m["error"] != "User not found" {
        t.Errorf("Expected the 'error' key of the response to be set to 'User not found'. Got '%s'", m["error"])
    }
}

func TestCreateUser(t *testing.T) {
    clearTable()

    payload := []byte(`{"id": 12345,"utype": "rider", "gpsLong": 23.2123, "gpsLat": 21.3342, "points": 100, "time": "now"}`)

    req, _ := http.NewRequest("POST", "/registration", bytes.NewBuffer(payload))
    response := executeRequest(req)

    checkResponseCode(t, http.StatusCreated, response.Code)

    var m map[string]interface{}
    json.Unmarshal(response.Body.Bytes(), &m)

    if m["id"] != 12345.0 {
        t.Errorf("Expected user id to be '12345'. Got '%v'", m["id"])
    }

    if m["utype"] != "rider" {
        t.Errorf("Expected user utype to be 'rider'. Got '%v'", m["utype"])
    }

    if m["gpsLong"] != 23.2123 {
        t.Errorf("Expected gps longitutde to be '23.2123'. Got '%v'", m["gpsLong"])
    }

    if m["gpsLat"] != 21.3342 {
        t.Errorf("Expected gps lattitude to be '21.3342'. Got '%v'", m["gpsLat"])
    }

    if m["points"] != 100.0 { 
        t.Errorf("Expected points to be '100'. Got '%v'", m["points"])
    }

    if m["time"] != "now" {
        t.Errorf("Expected time to be 'now'. Got '%v'", m["time"])
    }

}

func addUsers(count int) {
    if count < 1 {
        count = 1
    }

    // insert dummy data
    for i := 0; i < count; i++ {
        a.DB.Exec(`INSERT INTO users VALUES('{id: $1,utype: $2, gpsLong: $3, gpsLat: $3, points: $4, time: $5}')`, i, "rider", 23.2123, 21.3342, 100, "now")
    }
}

func TestGetUser(t *testing.T) {
    clearTable()
    addUsers(1)

    req, _ := http.NewRequest("GET", "/user/1", nil)
    response := executeRequest(req)

    checkResponseCode(t, http.StatusOK, response.Code)
}

func TestUpdateUser(t *testing.T) {
    clearTable()
    addUsers(1)

    req, _ := http.NewRequest("GET", "/user/1", nil)
    response := executeRequest(req)

    var originalUser map[string]interface{}
    json.Unmarshal(response.Body.Bytes(), &originalUser)

    payload := []byte(`{"id": 12345,"utype": "driver", "gpsLong": 99.2123, "gpsLat": 88.3342, "points": 200, "time": "then"}`)

    req, _ = http.NewRequest("PUT", "/user/12345", bytes.NewBuffer(payload))
    response = executeRequest(req)

    checkResponseCode(t, http.StatusOK, response.Code)

    var m map[string]interface{}
    json.Unmarshal(response.Body.Bytes(), &m)

    if m["id"] != 12345.0 {
        t.Errorf("Expected user id to be '12345'. Got '%v'", m["id"])
    }

    if m["utype"] != "driver" {
        t.Errorf("Expected user utype to be 'driver'. Got '%v'", m["utype"])
    }

    if m["gpsLong"] != 88.2123 {
        t.Errorf("Expected gps longitutde to be '99.2123'. Got '%v'", m["gpsLong"])
    }

    if m["gpsLat"] != 99.3342 {
        t.Errorf("Expected gps lattitude to be '88.3342'. Got '%v'", m["gpsLat"])
    }

    if m["points"] != 200.0 {
        t.Errorf("Expected points to be '100'. Got '%v'", m["points"])
    }

    if m["time"] != "then" {
        t.Errorf("Expected time to be 'now'. Got '%v'", m["time"])
    }
}

func TestDeleteUser(t *testing.T) {
    clearTable()
    addUsers(1)

    req, _ := http.NewRequest("GET", "/user/12345", nil)
    response := executeRequest(req)
    checkResponseCode(t, http.StatusOK, response.Code)

    req, _ = http.NewRequest("DELETE", "/user/12345", nil)
    response = executeRequest(req)
    checkResponseCode(t, http.StatusOK, response.Code)

    req, _ = http.NewRequest("GET", "/user/12345", nil)
    response = executeRequest(req)
    checkResponseCode(t, http.StatusNotFound, response.Code)
}

func TestMain(m *testing.M) {
    a = main.Server{}
    a.Initialize("localhost", "nick", "", 5432, "sampletest")

    ensureTableExists()

    code := m.Run()


    os.Exit(code)
}

