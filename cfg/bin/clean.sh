#!/usr/bin/env bash
##
#   Clean all projects files before re-deploy.
#
#   (all placeholders ${...} should be replaced by real values from 'templates.vars.[live|work].json' file
#    see node 'extra/praxigento_templates_config' in project's 'composer.json')
##

# local specific environment
LOCAL_ROOT=${LOCAL_ROOT}

rm -fr $LOCAL_ROOT/bin
rm -fr $LOCAL_ROOT/htdocs
rm -fr $LOCAL_ROOT/vendor
rm -fr $LOCAL_ROOT/composer.lock

echo "Magento 1 files are removed."