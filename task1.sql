CREATE TABLE IF NOT EXISTS source (
    value String
) ENGINE Memory;

CREATE TABLE IF NOT EXISTS counters (
    id      String,
    counter UInt64
)
ENGINE SummingMergeTree()
ORDER BY id;

CREATE MATERIALIZED VIEW IF NOT EXISTS counters_mv
TO counters AS
SELECT JSONExtractString(value, 'id') AS id,
       sum(JSONExtractUInt(value, 'value')) AS counter
FROM source
GROUP BY id;