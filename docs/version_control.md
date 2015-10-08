# Version control for Magento v1 module



## Mapping

Module's files and folders mapping is configured in module's [composer.json](../composer.json):

    "extra": {
        "map": [
            [
                "src/app/code/community/Flancer32/Sample",
                "app/code/community/Flancer32/Sample"
            ],
            [
                "src/app/etc/modules/Flancer32_Sample.xml",
                "app/etc/modules/Flancer32_Sample.xml"
            ]
        ]
    }
    
Files and folders from `work/vendor/flancer32/sample_mage1_module` are mapped into the `work/htdocs` folder using
*symlink* strategy. So when you change file `work/htdocs/app/code/community/Flancer32/Sample/etc/config.xml`
you really change file `work/vendor/flancer32/sample_mage1_module/src/app/code/community/Flancer32/Sample/etc/config.xml`.

You should use local git repository in `work/vendor/flancer32/sample_mage1_module` to work with changes in the module.
 
 
 
## Add git repositories to your IDE

You should add repositories for all your modules to your IDE including the root repo (this repo). 
This is sample for PHPStorm IDE:

![vc_ide_settings][vc_ide_settings]





## Repo conflicts

De facto you have a 2 local repositories:
* ./.git
* ./work/vendor/flancer32/sample_mage1_module/.git

that match to one remote repository https://github.com/flancer32/sample_mage1_module/

You will have a lot of _"Merge remote-tracking branch 'origin/master'"_ messages if you will change sources in both
 repositories simultaneously.

![vc_repo_conflicts][vc_repo_conflicts]
   
   
   
[vc_ide_settings]: ./img/vc_ide_settings.png
[vc_repo_conflicts]: ./img/vc_repo_conflicts.png