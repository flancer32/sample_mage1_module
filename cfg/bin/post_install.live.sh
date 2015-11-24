#!/bin/sh
##
#   Setup Magento instance after completion of the installation with PHP Composer.
#
#   (all placeholders ${...} should be replaced by real values from 'templates.vars.[live|work].json' file
#    see node 'extra/praxigento_templates_config' in project's 'composer.json')
##

# local specific environment
LOCAL_ROOT=${LOCAL_ROOT}
MAGE_ROOT=$LOCAL_ROOT/htdocs
# The owner of the Magento file system:
#   * Must have full control (read/write/execute) of all files and directories.
#   * Must not be the web server user; it should be a different user.
# Web server:
#   * must be a member of the '${LOCAL_GROUP}' group.
LOCAL_OWNER=${LOCAL_OWNER}
LOCAL_GROUP=${LOCAL_GROUP}
# DB connection params
DB_HOST=${CFG_DB_HOST}
DB_NAME=${CFG_DB_NAME}
DB_USER=${CFG_DB_USER}
DB_PASS=${CFG_DB_PASS}


# Check 'local.xml' to prevent repeated installation
FILE_LOCAL_XML=$MAGE_ROOT/app/etc/local.xml
if [ -f "$FILE_LOCAL_XML" ]
then
    echo "There is '$FILE_LOCAL_XML' file. Do nothing."
else
    echo "There is no '$FILE_LOCAL_XML' file."


    ##
    echo "Change rights to folders and files."
    ##
    mkdir -p $MAGE_ROOT/var/log
    chown -R $LOCAL_OWNER:$LOCAL_GROUP $MAGE_ROOT
    find $MAGE_ROOT -type d -exec chmod 770 {} \;
    find $MAGE_ROOT -type f -exec chmod 660 {} \;


    echo "launch Magento installation using database '$DB_NAME'."
    # Full list of the available options:
    # http://fbrnc.net/blog/2012/03/run-magento-installer-from-command-line
    php $MAGE_ROOT/install.php -- \
    --license_agreement_accepted "yes" \
    --locale "${CFG_LOCALE}" \
    --timezone "${CFG_TIMEZONE}" \
    --default_currency "${CFG_DEFAULT_CURRENCY}" \
    --db_host "${CFG_DB_HOST}" \
    --db_name "${CFG_DB_NAME}" \
    --db_user "${CFG_DB_USER}" \
    --db_pass "${CFG_DB_PASS}" \
    --db_prefix "${CFG_DB_PREFIX}" \
    --session_save "${CFG_SESSION_SAVE}" \
    --admin_frontname "${CFG_ADMIN_FRONTNAME}" \
    --url "${CFG_URL}" \
    --skip_url_validation "${CFG_SKIP_URL_VALIDATION}" \
    --use_rewrites "${CFG_USE_REWRITES}" \
    --use_secure "${CFG_USE_SECURE}" \
    --secure_base_url "${CFG_SECURE_BASE_URL}" \
    --use_secure_admin "${CFG_USE_SECURE_ADMIN}" \
    --enable_charts "${CFG_ENABLE_CHARTS}" \
    --admin_lastname "${CFG_ADMIN_LASTNAME}" \
    --admin_firstname "${CFG_ADMIN_FIRSTNAME}" \
    --admin_email "${CFG_ADMIN_EMAIL}" \
    --admin_username "${CFG_ADMIN_USERNAME}" \
    --admin_password "${CFG_ADMIN_PASSWORD}" \

    ##
    echo "Post installation setup for database '$DB_NAME'."
    ##
    mysql --database=$DB_NAME --host=$DB_HOST --user=$DB_USER --password=$DB_PASS -e "source $LOCAL_ROOT/bin/setup.sql"

    ##
    echo "Setup additional filesystem permissions."
    ##
    chmod -R go-w $MAGE_ROOT/app/etc

fi


##
echo "Post installation setup is done."
##