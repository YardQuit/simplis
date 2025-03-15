#!/bin/bash
mkdir -p /var/log/anacron/

if echo "$(bootc upgrade 2>/dev/null)" | grep -q "No changes"; then
    echo $(date) "bootc upgrade - already up-to-date" | tee -a /var/log/anacron/anacron_bootc_upgrade.log
elif [ $? -eq 0 ]; then
    echo $(date) "bootc upgrade - completed" | tee -a /var/log/anacron/anacron_bootc_upgrade.log
else
    echo $(date) "bootd upgrade - failed" | tee -a /var/log/anacron/anacron_bootc_upgrade.log
fi
