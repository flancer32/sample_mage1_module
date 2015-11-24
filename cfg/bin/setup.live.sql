--
--      Change live/pilot instance parameters.
--
REPLACE INTO ${CFG_DB_PREFIX}core_config_data SET value = 'America/Los_Angeles', path ='general/locale/timezone';