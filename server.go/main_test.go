package main_test

import (
    "testing"
)

var a main.Server

func ensureTableExists() {
    if _, err := a.DB.Exec(tableCreationQuery); err != nil {
        log.Fatal(err)
    }
}

func clearTable() {
    a.DB.Exec("DELETE FROM users")
}

func TestEmptyTable(t *testing.T) {
    clearTable()

    req, _ := http.NewRequest("GET", "/userLogin", nil)
    response := executeRequest(req)

    checkResponseCode(t, http.StatusOK, response.Code)

    if body := response.Body.String(); body != "[]" {
        t.Errorf("Expected an empty array. Got %s", body)
    }
}

func TestMain(m *testing.M) {
    a = main.App{}

    ensureTableExists()

    code := m.Run()

    clearTable()

}

