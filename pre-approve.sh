#!/usr/bin/env bash

if [[ $preapprove != '' ]]; then

   while IFS=',' read -ra ADDR; do
        for i in "${ADDR[@]}"; do
            echo "  ${i/:/ = }" >> /stabila/FullNode/fullnode.conf
        done
   done <<< "$preapprove"

fi

echo "}" >> /stabila/FullNode/fullnode.conf