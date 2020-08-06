Page Admin
Url : http://postgre-sql:5431/browser/
User: Admin
Password: password

Create a DB
Host: Postgre-sql
User: postgres
Password: password

aws-cli container was not able to see local-stack and commands to create a queue was failing
because I had named the container afshin-local-satck. after renaming the container to local-stack then aws-cli was able to see that.
Effectively, containers are able to see each other with their name
