SELECT
    'DROP USER '
    || USERNAME
    || ' CASCADE;' AS DROP_USER_STATEMENT
FROM
    DBA_USERS
WHERE
    USERNAME NOT IN ('SYS', 'SYSTEM');