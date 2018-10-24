# Rails CSV Seed

These files will allow you to backup your current database records into a csv files, and then run a database seed to import them.

## How to use:

1. copy and paste seeds.rb contents into db/seeds.rb
2. place csv_backup.rake into lib/tasks/
3. run 'rails csv_backup' in the terminal. this will put all your db records into csv files (one for each table) in db/csv_backups/
4. to seed with your backed up data, run rails db:seed

Snippets taken from all over the internet, handy when you have complex relationships and a lot of data because you can take a snapshot, check it into version control, and then import or re-seed without worrying about validations. You could easily modify to allow different seed sets like a 'dev' seed, a 'presentation' seed, stuff like that.
