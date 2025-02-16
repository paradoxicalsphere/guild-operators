CREATE FUNCTION grest.tip ()
  RETURNS TABLE (
    hash text,
    epoch_no word31type,
    abs_slot word63type,
    epoch_slot word31type,
    block_no word31type,
    block_time numeric
  )
  LANGUAGE PLPGSQL
  AS $$
BEGIN
  RETURN QUERY
  SELECT
    ENCODE(B.HASH::bytea, 'hex') AS BLOCK_HASH,
    b.EPOCH_NO AS EPOCH_NO,
    b.SLOT_NO AS ABS_SLOT,
    b.EPOCH_SLOT_NO AS EPOCH_SLOT,
    b.BLOCK_NO,
    EXTRACT(EPOCH from b.TIME)
  FROM
    BLOCK B
  ORDER BY
    B.ID DESC
  LIMIT 1;
END;
$$;

COMMENT ON FUNCTION grest.tip IS 'Get the tip info about the latest block seen by chain';

