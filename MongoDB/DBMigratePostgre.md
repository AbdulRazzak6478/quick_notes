# Migrate MongoDB to PostgreSQL


#### Quick CSV route (fast; limited for nested fields)
When to use: your collection is fairly flat (name, email, password, createdAt) and you want the fastest bulk load.

Steps
- Export Mongo collection to JSON or CSV

PowerShell / WSL (replace URI & collection):
```
# JSON (keeps nested objects)
mongoexport --uri="$SRC_URI" --collection=users --out=users.json --jsonArray

# or CSV (explicit fields) - faster to import
mongoexport --uri="$SRC_URI" --collection=users --type=csv --fields=_id,name,email,password,createdAt,updatedAt --out=users.csv

```
- (Optional) Transform CSV field _id → mongo_id and convert dates
If you used CSV and fields are okay, skip. If you exported JSON and need CSV, use jq to create CSV:

Example (Linux / WSL):
```

cat users.json | jq -r '.[] | [(.["_id"]["$oid"] // .["_id"]), .name, .email, .password, .createdAt, .updatedAt] | @csv' > users.csv

```


Note: adjust jq expression depending on how mongoexport encoded _id and date fields.

- Import CSV into Postgres using \copy (psql)

PowerShell (example):

# Start psql interactive or run single command
```

psql "postgres://pguser:pgpass@pg-host:5432/eventsdb" -c "\copy users(mongo_id,name,email,password,created_at,updated_at) FROM 'C:/path/to/users.csv' CSV"

```

- Verify:
```

SELECT COUNT(*) FROM users;
SELECT mongo_id, name, created_at FROM users ORDER BY created_at DESC LIMIT 5;

```

Pros: very fast (use Postgres COPY).
Cons: tricky for nested JSON/arrays and date formats; loss of JSON structure unless you store as jsonb column.

##### Copy file into table in order from inside shell
```
\copy users(mongo_id,name,email,password,created_at,updated_at)  FROM 'C:/Users/Abdul Razzak/skygoal/users.csv' CSV HEADER;
```