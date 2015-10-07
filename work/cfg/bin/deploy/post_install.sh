#!/bin/sh
##
#   Setup Magento instance after update with Composer.
##

# local specific environment
LOCAL_ROOT=${LOCAL_ROOT}
# DB connection params
DB_HOST=${CFG_DB_HOST}
DB_NAME=${CFG_DB_NAME}
DB_USER=${CFG_DB_USER}
DB_PASS=${CFG_DB_PASS}


##
#   Drop database.
##
mysqladmin -f -u"$DB_USER" -p"$DB_PASS" -h"$DB_HOST" drop "$DB_NAME"
mysqladmin -f -u"$DB_USER" -p"$DB_PASS" -h"$DB_HOST" create "$DB_NAME"


##
#   Re-install database.
##

# remove 'local.xml' to prevent installation failure
if [ -f "$LOCAL_ROOT/work/htdocs/app/etc/local.xml" ]
then
    rm $LOCAL_ROOT/work/htdocs/app/etc/local.xml
fi


# Full list of the available options:
# http://fbrnc.net/blog/2012/03/run-magento-installer-from-command-line

php $LOCAL_ROOT/work/htdocs/install.php -- \
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
mysql --database=$DB_NAME --host=$DB_HOST --user=$DB_USER --password=$DB_PASS -e "source $LOCAL_ROOT/work/bin/deploy/post_install.sql"

##
echo "Setup filesystem permissions."
##
chmod -R go-w $LOCAL_ROOT/work/htdocs/app/etc

##
echo "Post installation setup is done."
##