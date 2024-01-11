use myflix
db.createUser({
    user: "root",
    pwd: "example",
    roles: [{ role: "readWrite", db: "myflix" }]
})
use myflix
exit
