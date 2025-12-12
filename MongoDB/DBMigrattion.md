

# MongoDB Backup & Restore Documentation

## Full Backup

To create a full backup of a MongoDB database:

```bash
mongodump --uri="mongodb://<username>:<password>@<host>:<port>/<database>" --out=/path/to/backup

mongodump --uri="mongodb://..." --archive=... --gzip --oplog
mongorestore --uri="mongodb://..." --archive=... --gzip --oplogReplay
```

- Replace `<username>`, `<password>`, `<host>`, `<port>`, and `<database>` as needed.
- The backup will be stored in `/path/to/backup`.

## Partial (Collection-Level) Backup

To backup a specific db Or collection:

```bash
mongodump --uri="mongodb://<username>:<password>@<host>:<port>/<database>" --db=eventsdb --collection=<collection> --out=/path/to/backup

mongodump --uri="mongodb+srv://..." --db=eventsdb --archive=...path.. --gzip
```

To Compressed or Get In Directory with BJSON
```
--archive=file.gz    // Single compressed file - Migrations, transfers, backups

--out=/path/dir    // Folder with many files   - Selective restore, partial inspection
```


✅ 3. How to dump only specific DBs or specific collections
Dump only ONE database
```
mongodump `
  --uri="mongodb://..." `
  --db=eventsdb `
  --archive=C:\tmp\eventsdb.archive.gz `
  --gzip

```

Dump only ONE collection
```
mongodump `
  --uri="mongodb://..." `
  --db=eventsdb `
  --collection=users `
  --archive=C:\tmp\eventsdb_users.archive.gz `
  --gzip
```
Dump multiple specific collections (not full DB)

Must dump each collection separately:

```
mongodump --uri="mongodb://..." --db=eventsdb --collection=users --archive=C:\tmp\users.gz --gzip
mongodump --uri="mongodb://..." --db=eventsdb --collection=orders --archive=C:\tmp\orders.gz --gzip
```

or use --out to dump into a folder:

```
mongodump --uri="mongodb://..." --db=eventsdb --collection=users --out=C:\backup
mongodump --uri="mongodb://..." --db=eventsdb --collection=orders --out=C:\backup
```

### How to confirm you can read the oplog (run these in PowerShell / Git Bash after installing mongosh)

```
mongosh "<SRV_URI>" --eval "rs.status()" --quiet
```

##### Try reading one oplog record (tests oplog access & permissions)
```
mongosh "<SRV_URI>" --eval 'db.getSiblingDB("local").oplog.rs.find().limit(1).pretty()' --quiet
```
- If this returns a BSON document → you have oplog read access.

- If it returns a permission error or empty → you lack permissions or the provider blocks oplog access.

##### Check which hosts the driver sees (optional)
```
mongosh "<SRV_URI>" --eval 'db.getMongo().getURI()' --quiet
```


```
# 1) Test oplog read
mongosh "<SRV_URI>" --eval 'db.getSiblingDB("local").oplog.rs.find().limit(1).pretty()' --quiet

# 2) Full dump (if test succeeded)
mongodump --uri="<SRV_URI>" --archive=C:\tmp\full_dump_with_oplog.archive.gz --gzip --oplog

# 3) Verify the file
Get-Item C:\tmp\full_dump_with_oplog.archive.gz | Select-Object Name, Length

# 4) Restore to destination
mongorestore --uri="<DEST_SRV_URI>" --archive=C:\tmp\full_dump_with_oplog.archive.gz --gzip --oplogReplay


# JSON (keeps nested objects)
mongoexport --uri="$SRC_URI" --collection=users --out=users.json --jsonArray

# or CSV (explicit fields) - faster to import
mongoexport --uri="$SRC_URI" --collection=users --type=csv --fields=_id,name,email,password,createdAt,updatedAt --out=users.csv

```



✅ FIX (Safe & Recommended)

Enable PowerShell to run signed scripts (Node/npm scripts are signed).

Run this in PowerShell as Administrator:

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser


Press:

Y


Now restart PowerShell and test:

npm -v
node -v


This should remove the npm.ps1 cannot be loaded error.
## Incremental Backup
