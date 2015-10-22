#!/bin/sh
##
#   Setup Magento instance after update with Composer.
##

# type of the deployment (skip some steps when app is deployed in TRAVIS CI, $DEPLOYMENT_TYPE='travis')
DEPLOYMENT_TYPE=${DEPLOYMENT_TYPE}
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
# use 'skip_password' to connect to server w/o password.
DB_PASS=${CFG_DB_PASS}
if [ "$DB_PASS" = "skip_password" ]; then
    MYSQL_PASS=""
    MAGE_DBPASS=""
else
    MYSQL_PASS="--password=$DB_PASS"
    MAGE_DBPASS="--db_pass ""${CFG_DB_PASS}"""
fi


##
echo "Create ./var/log folder."
##
mkdir -p $MAGE_ROOT/var/log

if [ "$DEPLOYMENT_TYPE" = "travis" ]; then
    echo "Skip ownership for TRAVIS CI."
else
    ##
    echo "Change rights to folders and files."
    ##
    chown -R $LOCAL_OWNER:$LOCAL_GROUP $MAGE_ROOT
    find $MAGE_ROOT -type d -exec chmod 770 {} \;
    find $MAGE_ROOT -type f -exec chmod 660 {} \;
fi



if [ "$DEPLOYMENT_TYPE" = "travis" ]; then
    echo "Skip DB '$DB_NAME' drop/create for TRAVIS CI."
else
    ##
    echo "Drop database '$DB_NAME'."
    ##
    mysqladmin -f -u"$DB_USER" $MYSQL_PASS -h"$DB_HOST" drop "$DB_NAME"
    mysqladmin -f -u"$DB_USER" $MYSQL_PASS -h"$DB_HOST" create "$DB_NAME"
fi



##
echo "(Re)install Magento using database '$DB_NAME' (connecting as '$DB_USER')."
##

# remove 'local.xml' to prevent repeated installation failure
if [ -f "$MAGE_ROOT/app/etc/local.xml" ]
then
    rm $MAGE_ROOT/app/etc/local.xml
fi

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
$MAGE_DBPASS \
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
#
mysql --database=$DB_NAME --host=$DB_HOST --user=$DB_USER $MYSQL_PASS -e "source $LOCAL_ROOT/bin/deploy/post_install.sql"



##
echo "Setup additional filesystem permissions."
##
chmod -R go-w $MAGE_ROOT/app/etc


##
echo "Post installation setup is done."
##