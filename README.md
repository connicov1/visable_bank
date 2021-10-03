# README

Welcome to the new Visable Bank

Here you can transfer money between the existing accounts, or create a new account.
Here you can check the balance of an account and its transactions.

## NOTE:

This application uses MySQL DB, before running the applications make sure you have up and running your MySQL DB on 3306 port. Or you can change the port and even the DB by updating
`database.yml` file.

## SETUP

1. Download the project on your machine
2. run `bundle install`
3. run `rails db:seed` to get all the seeded accounts and transactions
4. run `rspec spec` to check that all the existing tests pass
5. run `rails s`

Enjoy :)


## POSTMAN Collection

Here is the POSTMAN collection you can use to create account or transactions and perform some transactions between accounts

```JSON
{
  "info": {
    "_postman_id": "c51b3f91-da1e-41dc-b556-4c55c10a82ee",
    "name": "visable_bank",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "Create Account",
      "request": {
        "method": "POST",
        "header": [],
        "url": {
          "raw": "http://localhost:3000/v1/accounts?name=Oleg's Account&iban=MD312341241&currency=EUR&nature=credit_card",
          "protocol": "http",
          "host": [
            "localhost"
          ],
          "port": "3000",
          "path": [
            "v1",
            "accounts"
          ],
          "query": [
            {
              "key": "name",
              "value": "Oleg's Account"
            },
            {
              "key": "iban",
              "value": "MD312341241"
            },
            {
              "key": "currency",
              "value": "EUR"
            },
            {
              "key": "nature",
              "value": "credit_card"
            },
            {
              "key": "status",
              "value": null,
              "disabled": true
            },
            {
              "key": "balance",
              "value": null,
              "disabled": true
            }
          ]
        }
      },
      "response": []
    },
    {
      "name": "Create Transaction",
      "request": {
        "method": "POST",
        "header": [],
        "url": {
          "raw": "http://localhost:3000/v1/transactions?account_from_iban=TEST098471723481&account_to_iban=TEST075283312931&amount=1&currency=EUR&description=payments",
          "protocol": "http",
          "host": [
            "localhost"
          ],
          "port": "3000",
          "path": [
            "v1",
            "transactions"
          ],
          "query": [
            {
              "key": "account_from_iban",
              "value": "TEST098471723481"
            },
            {
              "key": "account_to_iban",
              "value": "TEST075283312931"
            },
            {
              "key": "amount",
              "value": "1"
            },
            {
              "key": "currency",
              "value": "EUR"
            },
            {
              "key": "description",
              "value": "payments"
            }
          ]
        }
      },
      "response": []
    },
    {
      "name": "Get Account Transactions",
      "request": {
        "method": "GET",
        "header": [],
        "url": {
          "raw": "http://localhost:3000/v1/accounts/3f912150-d889-498b-b671-1a77fc8c3fa9/transactions?count=10",
          "protocol": "http",
          "host": [
            "localhost"
          ],
          "port": "3000",
          "path": [
            "v1",
            "accounts",
            "3f912150-d889-498b-b671-1a77fc8c3fa9",
            "transactions"
          ],
          "query": [
            {
              "key": "count",
              "value": "10"
            }
          ]
        }
      },
      "response": []
    }
  ]
}
```
