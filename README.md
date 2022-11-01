| user     |        |  | task        |         |  | task-labels  |  | label       |        |
|----------|--------|--|-------------|---------|--|--------------|--|-------------|--------|
| id       |        |  | id          |         |  | id           |  | id          |        |
| name     | string |  | user-id(FK) |         |  | task-id(FK)  |  | user-id(FK) |        |
| e-mail   | string |  | name        | string  |  | label-id(FK) |  | name        | string |
| password | string |  | priolity    | integer |  |              |  | color       | string |
|          |        |  | status      | integer |  |              |  |             |        |
|          |        |  | note        | text    |