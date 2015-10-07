--
--      Change development specific parameters.
--
REPLACE INTO ${CFG_DB_PREFIX}core_config_data SET value = '1', path ='dev/template/allow_symlink';
REPLACE INTO ${CFG_DB_PREFIX}core_config_data SET value = '1', path ='dev/log/active';