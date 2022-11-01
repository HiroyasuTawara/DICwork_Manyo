| user     |        |  | task        |         |  | task-labels  |  | label       |        |
|----------|--------|--|-------------|---------|--|--------------|--|-------------|--------|
| id       |        |  | id          |         |  | id           |  | id          |        |
| name     | string |  | user-id(FK) |         |  | task-id(FK)  |  | user-id(FK) |        |
| e-mail   | string |  | name        | string  |  | label-id(FK) |  | name        | string |
| password | string |  | priolity    | integer |  |              |  | color       | string |
|          |        |  | status      | integer |  |              |  |             |        |
|          |        |  | note        | text    |  
  
**デプロイ手順**　　

1. heroku createでアプリケーションを作成  
2. 下記のgemをインストール    
3. $bundle lock --add-platform x86_64-linuxを実行  
4. git commit
5. $ heroku stack:set heroku- で指定バージョンに固定  
6. git push heroku ブランチ名:masterでデプロイ
7. heroku run rails db:migrateでテーブル作成

**gem(バージョン)**  
net-smtp (0.3.2)  
net-imap (0.3.1)  
net-pop (0.1.2)